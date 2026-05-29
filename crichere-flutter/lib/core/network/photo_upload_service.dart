import 'package:dio/dio.dart';
import 'storage_api.dart';
import '../../features/auth/data/auth_api.dart';

/// Orchestrates the presigned-upload flow for a user profile photo:
///   1. `POST /storage/presigned-url {fileName, contentType}` → `{url, s3Key}`
///   2. `PUT <url>` with the raw bytes (no auth header — the URL is pre-signed)
///   3. `PUT /users/{id}/photo {s3Key}` to attach the object.
///
/// Bytes-based (not `dart:io File`) so it works on web and mobile alike.
class PhotoUploadService {
  final StorageApi _storageApi;
  final AuthApi _authApi;

  /// A clean Dio with NO interceptors — the presigned S3 PUT must not carry our
  /// `Authorization` header or pass through the envelope-unwrap/refresh logic.
  final Dio _uploadDio;

  PhotoUploadService(this._storageApi, this._authApi) : _uploadDio = Dio();

  /// Uploads [bytes] and attaches the result to [userId]. Returns the S3 key.
  Future<String> uploadUserPhoto({
    required String userId,
    required List<int> bytes,
    required String fileName,
    required String contentType,
  }) async {
    if (contentType.contains('image') && bytes.length > 10 * 1024 * 1024) {
      throw Exception('Image too large (max 10MB).');
    }

    final presigned = await _storageApi.getPresignedUrl({
      'fileName': fileName,
      'contentType': contentType,
    });
    final map = presigned is Map
        ? Map<String, dynamic>.from(presigned)
        : <String, dynamic>{};
    final url = map['url'] as String?;
    final s3Key = map['s3Key'] as String?;
    if (url == null || s3Key == null) {
      throw Exception('Failed to obtain a presigned upload URL.');
    }

    final response = await _uploadDio.put(
      url,
      data: Stream<List<int>>.fromIterable([bytes]),
      options: Options(
        headers: {
          'Content-Type': contentType,
          'Content-Length': bytes.length,
        },
      ),
    );
    if (response.statusCode != 200) {
      throw Exception('Upload failed (${response.statusCode}).');
    }

    await _authApi.updatePhoto(userId, {'s3Key': s3Key});
    return s3Key;
  }
}
