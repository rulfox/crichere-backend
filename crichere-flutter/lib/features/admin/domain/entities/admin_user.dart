import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_user.freezed.dart';
part 'admin_user.g.dart';

/// A user row in the platform-admin user list. Backend returns the `User`
/// entity directly from `GET /admin/users`, so this is a tolerant subset.
@freezed
abstract class AdminUser with _$AdminUser {
  const factory AdminUser({
    required String id,
    String? phone,
    String? name,
    String? email,
    String? profileStatus,
    @Default(false) bool suspended,
    String? suspensionReason,
  }) = _AdminUser;

  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);
}
