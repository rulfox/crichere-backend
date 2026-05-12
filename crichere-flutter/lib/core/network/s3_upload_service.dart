import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class S3UploadService {
  final Dio _dio = Dio();
  final _logger = Logger();

  Future<void> uploadFile({
    required String presignedUrl,
    required File file,
    required String contentType,
  }) async {
    try {
      final fileLength = await file.length();
      
      // Mandatory size checks (FR-018)
      if (contentType.contains('image') && fileLength > 10 * 1024 * 1024) {
        throw Exception('Image too large (Max 10MB)');
      }
      if (contentType.contains('pdf') && fileLength > 50 * 1024 * 1024) {
        throw Exception('PDF too large (Max 50MB)');
      }

      final response = await _dio.put(
        presignedUrl,
        data: file.openRead(),
        options: Options(
          headers: {
            'Content-Type': contentType,
            'Content-Length': fileLength,
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to upload to S3: ${response.statusMessage}');
      }
    } catch (e) {
      _logger.e('S3 Upload Error', error: e);
      rethrow;
    }
  }
}
