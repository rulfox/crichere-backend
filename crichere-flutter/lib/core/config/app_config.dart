class AppConfig {
  AppConfig._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.crichere.com/api/v1',
  );

  static const String environment = String.fromEnvironment(
    'ENV',
    defaultValue: 'dev',
  );

  static bool get isProduction => environment == 'prod';
  static bool get isDevelopment => environment == 'dev';
}
