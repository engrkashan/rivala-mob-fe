import 'dart:io';

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

  Future<void> createSquad(SquadModel squad, {File? logoFile}) async {
    print("Create squad in repo: ${squad.toJson()}");

    final response = await api.multipartRequest(
        endpoint: Endpoints.squads,
        fields: squad.toCreateFields(),
        file: logoFile,
        method: "POST");
  }

  Future<SquadModel> getSquadById(String squadId) async {
    final response =
        await api.getResponse(endpoints: Endpoints.squadsById(squadId));

    final squad = response["squad"];
    return SquadModel.fromJson(squad);
  }

  Future<void> updateSquad(String id, SquadModel squad,
      {File? logoFile}) async {
    await api.multipartRequest(
        endpoint: Endpoints.squadsById(id),
        fields: squad.toCreateFields(),
        file: logoFile,
        method: "PATCH");
  }

  Future<void> deleteSquad(String squadId) async {
    await api.deleteRequest(endpoint: Endpoints.squadsById(squadId));
  }
}
