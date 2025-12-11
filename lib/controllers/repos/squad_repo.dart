import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/models/squad_model.dart';

import '../../config/network/endpoints.dart';

class SquadRepo {
  final ApiClient api = ApiClient();

  Future<List<SquadModel>> getSquads() async {
    final response = await api.getResponse(endpoints: Endpoints.squads);
    final List<dynamic> data = response['squads'] ?? [];
    print("Squad data: $data");
    return data.map((item) => SquadModel.fromJson(item)).toList();
  }

  Future<void> createSquad(SquadModel squad) async {
    final response =
        await api.postResponse(endpoints: Endpoints.squads, data: squad);
  }

  Future<SquadModel> getSquadById(String squadId) async {
    final response =
        await api.getResponse(endpoints: Endpoints.squadsById(squadId));

    final squad = response["squad"];
    return SquadModel.fromJson(squad);
  }

  Future<void> deleteSquad(String squadId) async {
    await api.deleteRequest(endpoint: Endpoints.squadsById(squadId));
  }
}
