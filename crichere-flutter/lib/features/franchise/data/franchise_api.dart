import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../domain/entities/franchise_squad.dart';

part 'franchise_api.g.dart';

@RestApi()
abstract class FranchiseApi {
  factory FranchiseApi(Dio dio, {String baseUrl}) = _FranchiseApi;

  @GET('/franchises/{id}/squad')
  Future<FranchiseSquad> getSquad(@Path('id') String franchiseId);
}
