import '../entities/franchise_squad.dart';

abstract class FranchiseRepository {
  Future<FranchiseSquad> getSquad(String franchiseId);
}
