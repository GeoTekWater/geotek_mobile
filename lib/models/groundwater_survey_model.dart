/// Data model for a groundwater survey submission.
class GroundwaterSurveyModel {
  String? filePath;
  String? file;
  int? fileSize;
  String? locationName;
  String? client;
  String? reportedBy;
  double? latitude;
  double? longitude;

  GroundwaterSurveyModel({
    this.filePath,
    this.file,
    this.fileSize,
    this.locationName,
    this.client,
    this.reportedBy,
    this.latitude,
    this.longitude,
  });

  GroundwaterSurveyModel.fromJson(Map<String, dynamic> json) {
    filePath = json['filePath'];
    file = json['file'];
    fileSize = json['fileSize'];
    locationName = json['locationName'];
    client = json['client'];
    reportedBy = json['reportedBy'];
    latitude = _toDouble(json['latitude']);
    longitude = _toDouble(json['longitude']);
  }

  Map<String, dynamic> toJson() {
    return {
      'filePath': filePath,
      'file': file,
      'fileSize': fileSize,
      'locationName': locationName,
      'client': client,
      'reportedBy': reportedBy,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  /// Fields sent with the multipart request (excluding the file itself).
  Map<String, dynamic> toFormFields() {
    final data = <String, dynamic>{};

    final location = locationName?.trim() ?? '';
    final clientName = client?.trim() ?? '';
    final reporter = reportedBy?.trim() ?? '';

    if (location.isNotEmpty) data['locationName'] = location;
    if (clientName.isNotEmpty) data['client'] = clientName;
    if (reporter.isNotEmpty) data['reportedBy'] = reporter;
    if (latitude != null) data['latitude'] = latitude;
    if (longitude != null) data['longitude'] = longitude;

    return data;
  }

  bool get hasFile =>
      filePath != null &&
      filePath!.isNotEmpty &&
      file != null &&
      file!.isNotEmpty;

  GroundwaterSurveyModel copyWith({
    String? filePath,
    String? file,
    int? fileSize,
    String? locationName,
    String? client,
    String? reportedBy,
    double? latitude,
    double? longitude,
  }) {
    return GroundwaterSurveyModel(
      filePath: filePath ?? this.filePath,
      file: file ?? this.file,
      fileSize: fileSize ?? this.fileSize,
      locationName: locationName ?? this.locationName,
      client: client ?? this.client,
      reportedBy: reportedBy ?? this.reportedBy,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
