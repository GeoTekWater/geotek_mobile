/// Models for the process-survey-data API response (`SurveyProcessingResultInfo`).

class SurveyArtifactCaption {
  final String artifactKey;
  final String caption;
  final String relevance;

  SurveyArtifactCaption({
    required this.artifactKey,
    required this.caption,
    required this.relevance,
  });

  factory SurveyArtifactCaption.fromJson(Map<String, dynamic> json) {
    return SurveyArtifactCaption(
      artifactKey: json['artifactKey']?.toString() ?? '',
      caption: json['caption']?.toString() ?? '',
      relevance: json['relevance']?.toString() ?? '',
    );
  }
}

class SurveyPdfLayout {
  final List<String> sectionOrder;
  final List<String> includeArtifacts;

  SurveyPdfLayout({
    required this.sectionOrder,
    required this.includeArtifacts,
  });

  factory SurveyPdfLayout.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return SurveyPdfLayout(sectionOrder: const [], includeArtifacts: const []);
    }
    return SurveyPdfLayout(
      sectionOrder: List<String>.from(
        (json['sectionOrder'] as List? ?? []).map((e) => e.toString()),
      ),
      includeArtifacts: List<String>.from(
        (json['includeArtifacts'] as List? ?? []).map((e) => e.toString()),
      ),
    );
  }
}

class SurveyAgentReport {
  final String title;
  final String executiveSummary;
  final List<SurveyArtifactCaption> artifactCaptions;
  final List<String> cautions;
  final SurveyPdfLayout pdfLayout;

  SurveyAgentReport({
    required this.title,
    required this.executiveSummary,
    required this.artifactCaptions,
    required this.cautions,
    required this.pdfLayout,
  });

  factory SurveyAgentReport.fromJson(Map<String, dynamic> json) {
    final captionsRaw = json['artifactCaptions'] as List? ?? [];
    final cautionsRaw = json['cautions'] as List? ?? [];

    return SurveyAgentReport(
      title: json['title']?.toString() ?? 'Agent Survey Report',
      executiveSummary: json['executiveSummary']?.toString() ?? '',
      artifactCaptions: captionsRaw
          .whereType<Map>()
          .map((e) => SurveyArtifactCaption.fromJson(
                Map<String, dynamic>.from(e),
              ))
          .toList(),
      cautions: cautionsRaw.map((e) => e.toString()).toList(),
      pdfLayout: SurveyPdfLayout.fromJson(
        json['pdfLayout'] is Map
            ? Map<String, dynamic>.from(json['pdfLayout'] as Map)
            : null,
      ),
    );
  }
}

class SurveyProcessingResult {
  final String analysisId;
  final SurveyAgentReport? agentReport;
  final String? pdfUrl;
  final List<String> warnings;
  final Map<String, dynamic>? report;
  final Map<String, dynamic> raw;

  SurveyProcessingResult({
    required this.analysisId,
    required this.agentReport,
    required this.pdfUrl,
    required this.warnings,
    required this.report,
    required this.raw,
  });

  factory SurveyProcessingResult.fromJson(Map<String, dynamic> json) {
    final agentRaw = json['agentReport'];
    return SurveyProcessingResult(
      analysisId: json['analysisId']?.toString() ?? '',
      agentReport: agentRaw is Map
          ? SurveyAgentReport.fromJson(Map<String, dynamic>.from(agentRaw))
          : null,
      pdfUrl: json['pdfUrl']?.toString(),
      warnings: List<String>.from(
        (json['warnings'] as List? ?? []).map((e) => e.toString()),
      ),
      report: json['report'] is Map
          ? Map<String, dynamic>.from(json['report'] as Map)
          : null,
      raw: json,
    );
  }
}
