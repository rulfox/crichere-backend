import '../domain/entities/franchise_squad.dart';
import '../domain/entities/franchise_invite.dart';
import '../domain/entities/franchise.dart';
import '../domain/repositories/franchise_repository.dart';
import 'franchise_api.dart';

class FranchiseRepositoryImpl implements FranchiseRepository {
  final FranchiseApi _api;

  FranchiseRepositoryImpl(this._api);

  @override
  Future<Franchise> getFranchise(String id) async {
    return await _api.getFranchise(id);
  }

  @override
  Future<Franchise> updateFranchise(String id, {String? name, String? logoUrl, int? totalPurse}) async {
    return await _api.updateFranchise(id, {
      if (name != null) 'name': name,
      if (logoUrl != null) 'logoUrl': logoUrl,
      if (totalPurse != null) 'totalPurse': totalPurse,
    });
  }

  @override
  Future<FranchiseSquadResponse> getSquad(String franchiseId) async {
    return await _api.getSquad(franchiseId);
  }

  @override
  Future<List<FranchiseInvite>> getInvites(String franchiseId) async {
    return await _api.getInvites(franchiseId);
  }

  @override
  Future<InviteValidationResponse> validateInvite(String token) async {
    return await _api.validateInvite(token);
  }

  @override
  Future<Franchise> acceptInvite(String token) async {
    return await _api.acceptInvite(InviteAcceptRequest(token: token));
  }
}
