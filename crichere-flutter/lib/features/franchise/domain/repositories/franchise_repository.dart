import '../entities/franchise_squad.dart';
import '../entities/franchise_invite.dart';
import '../entities/franchise.dart';

abstract class FranchiseRepository {
  Future<Franchise> getFranchise(String id);
  Future<Franchise> updateFranchise(String id, {String? name, String? logoUrl, int? totalPurse});
  Future<FranchiseSquadResponse> getSquad(String franchiseId);
  Future<List<FranchiseInvite>> getInvites(String franchiseId);
  Future<InviteValidationResponse> validateInvite(String token);
  Future<Franchise> acceptInvite(String token);
}
