import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:geo_tek/config/api_config.dart';
import 'package:geo_tek/models/groundwater_survey_model.dart';
import 'package:geo_tek/models/groundwater_survey_submit_result.dart';
import 'package:geo_tek/models/survey_agent_report_model.dart';

class GroundwaterSurveyService {
  GroundwaterSurveyService({Dio? dio}) : _dio = dio ?? _createDio();

  final Dio _dio;

  static const List<String> allowedExtensions = [
    'csv',
    // 'doc',
    // 'docx',
    // 'pdf',
  ];

  static Dio _createDio() {
    return Dio(
      BaseOptions(
        connectTimeout: ApiConfig.connectTimeout.inMilliseconds,
        receiveTimeout: ApiConfig.receiveTimeout.inMilliseconds,
        sendTimeout: ApiConfig.sendTimeout.inMilliseconds,
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
  }

  Future<PlatformFile?> pickSurveyFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
      withData: false,
    );

    if (result == null || result.files.isEmpty) return null;

    final file = result.files.first;
    if (!isAllowedFile(file)) return null;

    return file;
  }

  bool isAllowedFile(PlatformFile file) {
    final ext = (file.extension ?? '').toLowerCase();
    return allowedExtensions.contains(ext);
  }

  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  GroundwaterSurveyModel modelFromPickedFile(PlatformFile file) {
    return GroundwaterSurveyModel(
      filePath: file.path,
      file: file.name,
      fileSize: file.size,
    );
  }

  Future<GroundwaterSurveySubmitResult> submitSurvey(
    GroundwaterSurveyModel survey,
  ) async {
    if (!survey.hasFile) {
      return GroundwaterSurveySubmitResult.failure(
        message: 'Survey file is required.',
      );
    }

    final file = File(survey.filePath!);
    if (!await file.exists()) {
      return GroundwaterSurveySubmitResult.failure(
        message: 'Selected file is no longer available. Please pick it again.',
      );
    }

    try {
      final payload = <String, dynamic>{
        'file': await MultipartFile.fromFile(
          survey.filePath!,
          filename: survey.file,
        ),
        ...survey.toFormFields(),
      };

      final formData = FormData.fromMap(payload);

      log('[SURVEY-SUBMIT] :: posting to ${ApiConfig.processSurveyData}');
      log('[SURVEY-PAYLOAD] :: ${survey.toJson()}');

      final response = await _dio.post(
        ApiConfig.processSurveyData,
        data: formData,
        options: Options(
          // Let Dio set multipart boundary automatically.
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (_isSuccessResponse(response)) {
        SurveyProcessingResult? processingResult;
        final data = response.data;
        if (data is Map) {
          processingResult = SurveyProcessingResult.fromJson(
            Map<String, dynamic>.from(data),
          );
          log('[SURVEY-AGENT-REPORT] :: ${processingResult.agentReport?.title}');
        }

        return GroundwaterSurveySubmitResult.success(
          statusCode: response.statusCode,
          processingResult: processingResult,
        );
      }

      log('[SURVEY-SUBMIT-FAILED] :: ${response.statusCode} ${response.data}');

      return GroundwaterSurveySubmitResult.failure(
        message: _messageFromResponse(response),
        statusCode: response.statusCode,
      );
    } on DioError catch (error) {
      log('[SURVEY-SUBMIT-ERROR] :: $error');
      if (error.response != null) {
        log('[SURVEY-SUBMIT-ERROR-RESPONSE] :: ${error.response?.data}');
      }

      return GroundwaterSurveySubmitResult.failure(
        message: _networkErrorMessage(error),
        statusCode: error.response?.statusCode,
      );
    } catch (error) {
      log('[SURVEY-SUBMIT-ERROR] :: $error');
      return GroundwaterSurveySubmitResult.failure(
        message: 'An unexpected error occurred while submitting the survey.',
      );
    }
  }

  bool _isSuccessResponse(Response response) {
    return response.statusCode == 200 || response.statusCode == 201;
  }

  String _messageFromResponse(Response response) {
    final data = response.data;
    if (data is Map && data['message'] != null) {
      return data['message'].toString();
    }
    return 'Unable to submit survey (HTTP ${response.statusCode}).';
  }

  String _networkErrorMessage(DioError error) {
    final type = error.type;
    final endpoint = ApiConfig.processSurveyData;
    final isConnectionIssue = type == DioErrorType.connectTimeout ||
        type == DioErrorType.receiveTimeout ||
        type == DioErrorType.sendTimeout ||
        type == DioErrorType.other;

    if (isConnectionIssue) {
      return 'Unable to submit survey. Check your internet connection and try again.';
    }

    if (type == DioErrorType.response && error.response != null) {
      return _messageFromResponse(error.response!);
    }

    return 'An error occurred while submitting the survey.';
  }
}
