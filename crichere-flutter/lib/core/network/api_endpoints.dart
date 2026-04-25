class ApiEndpoints {
  static const String baseUrl = 'http://localhost:8080/api/v1'; // TODO: Update for production
  
  static const String authLogin = '/auth/login';
  static const String authVerify = '/auth/verify';
  static const String authRefresh = '/auth/refresh';
  static const String authProfile = '/auth/profile';
  static const String authClaim = '/auth/claim';
  
  static const String leagues = '/leagues';
  static const String players = '/players';
  static const String auctions = '/auctions';
  static const String franchises = '/franchises';
  static const String notifications = '/notifications';
}
