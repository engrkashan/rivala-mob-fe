import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rivala/controllers/providers/brands_provider.dart';
import 'package:rivala/controllers/providers/media_provider.dart';
import 'package:rivala/controllers/providers/product_provider.dart';
import 'package:rivala/models/product_model.dart';

import '../../models/squad_model.dart';
import '../../models/store_model.dart';
import '../../models/user_model.dart';
import '../repos/squad_repo.dart';

class SquadProvider extends ChangeNotifier {
  List<SquadModel> _squads = [];
  List<SquadModel> get squads => _squads;
  List<SquadModel> _filteredSquads = [];
  List<SquadModel> get filteredSquads => _filteredSquads;
  SquadRepo _repo = SquadRepo();
  String? _error;

  SquadModel? _singleSquad;
  SquadModel? get singleSquad => _singleSquad;

  List<UserModel> selectedMembers = [];

  String? get error => _error;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void toggleMember(UserModel member) {
    if (selectedMembers.any((m) => m.id == member.id)) {
      selectedMembers.removeWhere((m) => m.id == member.id);
    } else {
      selectedMembers.add(member);
    }
    notifyListeners();
  }

  void searchSquads(String query) {
    if (query.isEmpty) {
      _filteredSquads = _squads;
    } else {
      _filteredSquads = _squads
          .where((squad) =>
              squad.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void clear() {
    selectedMembers.clear();
    notifyListeners();
  }

  Future<void> getSquads() async {
    setLoading(true);

    try {
      _squads = await _repo.getSquads();
      _filteredSquads = _squads;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> loadSingleSquad(String squadId) async {
    setLoading(true);
    try {
      _singleSquad = await _repo.getSquadById(squadId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      setLoading(false);
    }
  }

  Future<void> sendSquadRequest(
      String name, String summary, BuildContext context) async {
    setLoading(true);
    try {
      // Upload logo first
      await context.read<MediaProvider>().upload();

      // Create SquadModel with proper nested objects
      SquadModel squad = SquadModel(
        name: name,
        description: summary,
        members: selectedMembers
            .map((e) => UserModel(id: e.id, name: e.name, email: e.email))
            .toList(),
        products: context
            .read<ProductProvider>()
            .selectedMembers
            .map((p) => ProductModel(id: p.id, title: p.title))
            .toList(),
        sellers: context
            .read<BrandsProvider>()
            .selectedBrands
            .map((b) => StoreModel(id: b.id, name: b.name))
            .toList(),
        logo: context.read<MediaProvider>().uploadedUrl,
        createdAt: DateTime.now(),
      );

      await _repo.createSquad(squad);
      await getSquads();
      print("Squad created successfully");
      clear();
    } catch (e) {
      print("Error while creating squad: $e");
    } finally {
      setLoading(false);
    }
  }

  Future<void> deleteSquad(String squadId) async {
    setLoading(true);
    try {
      await _repo.deleteSquad(squadId);
      _squads.removeWhere((squad) => squad.id == squadId);
      _filteredSquads = _squads;
      notifyListeners();
    } catch (e) {
      print("Error while deleting squad: $e");
    } finally {
      setLoading(false);
    }
  }
}
