import 'package:dio/dio.dart';

/// A normalized view of a backend `ApiError` for the UI layer.
///
/// The backend wraps failures in `ApiResponse{ success:false, error:{ code,
/// message, ... } }`. Because the Dio interceptor unwraps the `data` field on
/// success, error bodies still arrive as the full envelope on a [DioException].
class ApiError {
  final String? code;
  final String message;
  final int? statusCode;

  const ApiError({this.code, required this.message, this.statusCode});

  /// Extracts an [ApiError] from any thrown object (typically a [DioException]).
  factory ApiError.from(Object error) {
    if (error is DioException) {
      final status = error.response?.statusCode;
      final body = error.response?.data;
      if (body is Map) {
        final err = body['error'];
        if (err is Map) {
          final code = err['code']?.toString();
          final serverMsg = err['message']?.toString();
          return ApiError(
            code: code,
            message: _friendlyFor(code) ?? serverMsg ?? _defaultForStatus(status),
            statusCode: status,
          );
        }
        // Some endpoints return a flat `{message}`.
        final flatMsg = body['message']?.toString();
        if (flatMsg != null) {
          return ApiError(message: flatMsg, statusCode: status);
        }
      }
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        return ApiError(message: 'The connection timed out. Please try again.', statusCode: status);
      }
      if (error.type == DioExceptionType.connectionError) {
        return const ApiError(message: 'No internet connection.');
      }
      return ApiError(message: _defaultForStatus(status), statusCode: status);
    }
    return ApiError(message: error.toString());
  }

  /// Whether this represents the "auction is valid but not live yet" case used
  /// by the public spectator view.
  bool get isAuctionNotLive => code == 'error.auction_not_live';

  static String _defaultForStatus(int? status) {
    switch (status) {
      case 400:
        return 'Invalid request.';
      case 401:
        return 'Your session has expired. Please sign in again.';
      case 403:
        return "You don't have permission to do that.";
      case 404:
        return 'Not found.';
      case 409:
        return 'That action conflicts with the current state.';
      case 422:
        return 'Some details are invalid.';
      case 500:
        return 'Something went wrong on our side. Please try again.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }

  /// Maps known backend error codes to user-facing copy. Returns null to fall
  /// back to the server-provided message.
  static String? _friendlyFor(String? code) {
    switch (code) {
      case 'error.auction_not_live':
        return 'This auction is not live yet. Hang tight — it will start soon.';
      case 'error.invalid_bid_amount':
        return 'That bid amount is not valid.';
      case 'error.insufficient_purse':
        return 'This franchise does not have enough purse for that bid.';
      case 'error.player_already_sold':
        return 'That player has already been sold.';
      case 'error.no_active_player':
        return 'There is no player up for bidding right now.';
      case 'error.auction_already_started':
        return 'This auction has already started.';
      case 'error.token_required':
      case 'error.invalid_token':
        return 'This invite link is invalid or has expired.';
      case 'error.reason_required':
        return 'Please provide a reason.';
      case 'error.notes_required':
        return 'Admin notes are required.';
      default:
        return null;
    }
  }
}
