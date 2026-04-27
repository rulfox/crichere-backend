import '../config/app_config.dart';

class ApiEndpoints {
  static const String baseUrl = AppConfig.baseUrl;
  
  static const String authOtpSend = '/auth/otp/send';
  static const String authOtpVerify = '/auth/otp/verify';
  static const String authRefresh = '/auth/token/refresh';
  static const String authMe = '/auth/me';
  static const String authClaimProfile = '/auth/claim-profile';
  static const String authLogout = '/auth/logout';
  
  static const String users = '/users';
  static const String players = '/players';
  static const String leagues = '/leagues';
  static const String auctions = '/auctions';
  static const String franchises = '/franchises';
  static const String notifications = '/notifications';
}
