import 'dart:typed_data';
import 'package:share_plus/share_plus.dart';

/// Saves/shares raw bytes (PDF, PNG, …) cross-platform.
///
/// Uses `XFile.fromData` + share_plus, which works on both web (browser
/// download/share sheet) and mobile (native share sheet) — no `dart:io` path
/// handling needed. Use this for server-rendered exports that arrive as bytes.
class FileShare {
  static Future<void> shareBytes(
    List<int> bytes, {
    required String fileName,
    required String mimeType,
    String? text,
  }) async {
    final file = XFile.fromData(
      Uint8List.fromList(bytes),
      name: fileName,
      mimeType: mimeType,
    );
    await SharePlus.instance.share(ShareParams(files: [file], text: text));
  }
}
