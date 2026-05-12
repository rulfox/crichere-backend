import '../entities/franchise_squad.dart';
import '../entities/franchise_invite.dart';
import '../entities/franchise.dart';

abstract class FranchiseRepository {
  Future<FranchiseSquad> getSquad(String franchiseId);
  Future<InviteValidationResponse> validateInvite(String token);
  Future<Franchise> acceptInvite(String token);
}
