import 'package:auto_route/auto_route.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'app_router.gr.dart'; // Will be generated

class AuthGuard extends AutoRouteGuard {
  final FlutterSecureStorage _storage;

  AuthGuard(this._storage);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final token = await _storage.read(key: 'accessToken');
    if (token != null) {
      resolver.next(true);
    } else {
      // router.push(const PhoneEntryRoute());
      resolver.next(false);
    }
  }
}
