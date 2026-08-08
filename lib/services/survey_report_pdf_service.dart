import 'dart:developer';
import 'dart:io';

import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:geo_tek/models/survey_agent_report_model.dart';

class SurveyReportPdfService {
  /// Builds a PDF from [agentReport] (and optional related context),
  /// saves it to device storage, and opens it for the user.
  Future<File> generateAndSaveAgentReportPdf({
    required SurveyAgentReport agentReport,
    String? analysisId,
    Map<String, dynamic>? report,
    List<String> warnings = const [],
  }) async {
    final doc = pw.Document();
    final cover = report?['cover'] is Map
        ? Map<String, dynamic>.from(report!['cover'] as Map)
        : <String, dynamic>{};
    final conclusion = report?['conclusion'] is Map
        ? Map<String, dynamic>.from(report!['conclusion'] as Map)
        : <String, dynamic>{};
    final location = report?['location'] is Map
        ? Map<String, dynamic>.from(report!['location'] as Map)
        : <String, dynamic>{};
    final methodology = report?['methodology'] is Map
        ? Map<String, dynamic>.from(report!['methodology'] as Map)
        : <String, dynamic>{};

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'GeoTek Water Solutions',
              style: pw.TextStyle(
                fontSize: 10,
                color: PdfColors.blueGrey700,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Divider(color: PdfColors.blueGrey300),
            pw.SizedBox(height: 8),
          ],
        ),
        footer: (context) => pw.Column(
          children: [
            pw.Divider(color: PdfColors.blueGrey300),
            pw.SizedBox(height: 4),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  analysisId != null && analysisId.isNotEmpty
                      ? 'Analysis ID: $analysisId'
                      : 'Groundwater Survey Report',
                  style: const pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.Text(
                  'Page ${context.pageNumber} of ${context.pagesCount}',
                  style: const pw.TextStyle(
                    fontSize: 9,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
            ),
          ],
        ),
        build: (context) => [
          pw.Text(
            agentReport.title,
            style: pw.TextStyle(
              fontSize: 22,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.indigo900,
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'Generated: ${DateTime.now().toLocal()}',
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
          ),
          pw.SizedBox(height: 20),

          // Cover / meta details when available
          if (cover.isNotEmpty || location.isNotEmpty) ...[
            _sectionTitle('Report Details'),
            if (cover['locationName'] != null)
              _kv('Location', cover['locationName']),
            if (cover['client'] != null) _kv('Client', cover['client']),
            if (cover['reportedBy'] != null)
              _kv('Reported by', cover['reportedBy']),
            if (cover['reportDate'] != null)
              _kv('Report date', cover['reportDate']),
            if (location['address'] != null)
              _kv('Address', location['address']),
            if (location['latitude'] != null)
              _kv('Latitude', location['latitude']),
            if (location['longitude'] != null)
              _kv('Longitude', location['longitude']),
            pw.SizedBox(height: 16),
          ],

          _sectionTitle('Executive Summary'),
          pw.Text(
            agentReport.executiveSummary.isEmpty
                ? 'No executive summary provided.'
                : agentReport.executiveSummary,
            style: const pw.TextStyle(fontSize: 11, lineSpacing: 2),
            textAlign: pw.TextAlign.justify,
          ),
          pw.SizedBox(height: 16),

          if (methodology.isNotEmpty) ...[
            _sectionTitle('Methodology'),
            if (methodology['fieldTechnique'] != null)
              _kv('Field technique', methodology['fieldTechnique']),
            if (methodology['instrumentation'] != null)
              _kv('Instrumentation', methodology['instrumentation']),
            pw.SizedBox(height: 16),
          ],

          if (agentReport.artifactCaptions.isNotEmpty) ...[
            _sectionTitle('Artifact Captions'),
            ...agentReport.artifactCaptions.map((item) {
              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 10),
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      item.artifactKey,
                      style: pw.TextStyle(
                        fontSize: 11,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      item.caption,
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'Relevance: ${item.relevance}',
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.blueGrey700,
                      ),
                    ),
                  ],
                ),
              );
            }),
            pw.SizedBox(height: 8),
          ],

          if (agentReport.cautions.isNotEmpty) ...[
            _sectionTitle('Cautions'),
            ...agentReport.cautions.map(
              (caution) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('•  ', style: const pw.TextStyle(fontSize: 11)),
                    pw.Expanded(
                      child: pw.Text(
                        caution,
                        style: const pw.TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            pw.SizedBox(height: 16),
          ],

          if (conclusion.isNotEmpty) ...[
            _sectionTitle('Conclusion'),
            if (conclusion['feasibility'] != null)
              _kv(
                'Feasibility',
                conclusion['feasibility'] == true ? 'Yes' : 'No',
              ),
            if (conclusion['yieldExpectation'] != null)
              _kv('Yield expectation', conclusion['yieldExpectation']),
            if (conclusion['recommendedDrillDepthM'] != null)
              _kv(
                'Recommended drill depth (m)',
                conclusion['recommendedDrillDepthM'],
              ),
            if (conclusion['overburdenEstimateM'] != null)
              _kv(
                'Overburden estimate (m)',
                conclusion['overburdenEstimateM'],
              ),
            if (conclusion['narrative'] != null) ...[
              pw.SizedBox(height: 6),
              pw.Text(
                conclusion['narrative'].toString(),
                style: const pw.TextStyle(fontSize: 11, lineSpacing: 2),
                textAlign: pw.TextAlign.justify,
              ),
            ],
            if (conclusion['recommendedStations'] is List &&
                (conclusion['recommendedStations'] as List).isNotEmpty) ...[
              pw.SizedBox(height: 8),
              pw.Text(
                'Recommended stations:',
                style: pw.TextStyle(
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              ...(conclusion['recommendedStations'] as List).map(
                (station) => pw.Text(
                  '• ${station.toString()}',
                  style: const pw.TextStyle(fontSize: 11),
                ),
              ),
            ],
            pw.SizedBox(height: 16),
          ],

          if (agentReport.pdfLayout.sectionOrder.isNotEmpty) ...[
            _sectionTitle('PDF Layout'),
            _kv(
              'Section order',
              agentReport.pdfLayout.sectionOrder.join(', '),
            ),
            if (agentReport.pdfLayout.includeArtifacts.isNotEmpty)
              _kv(
                'Include artifacts',
                agentReport.pdfLayout.includeArtifacts.join(', '),
              ),
            pw.SizedBox(height: 16),
          ],

          if (warnings.isNotEmpty) ...[
            _sectionTitle('Warnings'),
            ...warnings.map(
              (warning) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Text(
                  '• $warning',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.orange800,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );

    final directory = await _resolveSaveDirectory();
    final safeTitle = agentReport.title
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '_');
    final fileName =
        'geotek_agent_report_${safeTitle.isEmpty ? 'survey' : safeTitle}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(await doc.save());

    log('[SURVEY-PDF-SAVED] :: ${file.path}');
    return file;
  }

  Future<OpenResult> openPdf(File file) {
    return OpenFilex.open(file.path);
  }

  Future<Directory> _resolveSaveDirectory() async {
    try {
      final downloads = await getDownloadsDirectory();
      if (downloads != null) return downloads;
    } catch (e) {
      log('[SURVEY-PDF-DOWNLOADS-DIR] :: $e');
    }

    return getApplicationDocumentsDirectory();
  }

  pw.Widget _sectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: 14,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.indigo800,
        ),
      ),
    );
  }

  pw.Widget _kv(String label, dynamic value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.RichText(
        text: pw.TextSpan(
          children: [
            pw.TextSpan(
              text: '$label: ',
              style: pw.TextStyle(
                fontSize: 11,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.TextSpan(
              text: value?.toString() ?? '-',
              style: const pw.TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
