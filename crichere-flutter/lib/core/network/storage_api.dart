import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'storage_api.g.dart';

/// Client for the backend `StorageController` (`/storage`).
///
/// The presigned-upload flow is:
///   1. `POST /storage/presigned-url {fileName, contentType}` → `{url, s3Key}`.
///   2. `PUT <url>` with the file bytes (see [S3UploadService]).
///   3. `PUT /users/{id}/photo {s3Key}` to attach the uploaded object.
@RestApi()
abstract class StorageApi {
  factory StorageApi(Dio dio, {String baseUrl}) = _StorageApi;

  /// Returns `{url, s3Key}` (after the Dio envelope is unwrapped).
  @POST('/storage/presigned-url')
  Future<dynamic> getPresignedUrl(@Body() Map<String, dynamic> body);
}
