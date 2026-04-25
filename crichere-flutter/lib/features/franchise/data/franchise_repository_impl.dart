import '../domain/entities/franchise_squad.dart';
import '../domain/repositories/franchise_repository.dart';
import 'franchise_api.dart';

class FranchiseRepositoryImpl implements FranchiseRepository {
  final FranchiseApi _api;

  FranchiseRepositoryImpl(this._api);

  @override
  Future<FranchiseSquad> getSquad(String franchiseId) async {
    return await _api.getSquad(franchiseId);
  }
}
