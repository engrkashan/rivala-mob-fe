import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';
import 'package:rivala/models/report_model.dart';

class ReportsRepo {
  ApiClient api = ApiClient();

  /// Create a new report
  Future<ReportModel> createReport({
    required String targetId,
    required String reason,
  }) async {
    final response = await api.postResponse(
      endpoints: Endpoints.reports,
      data: {
        'targetId': targetId,
        'reason': reason,
      },
    );
    return ReportModel.fromJson(response);
  }

  /// Get report by ID
  Future<ReportModel> getReportById(String id) async {
    final response =
        await api.getResponse(endpoints: Endpoints.reportsById(id));
    return ReportModel.fromJson(response);
  }
}
