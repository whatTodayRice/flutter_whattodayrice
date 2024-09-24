class SuPaBaseEnv {
  final String _projURL = "https://hgfeeytxdfteoizikzut.supabase.co";
  final String _projApiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhnZmVleXR4ZGZ0ZW9pemlrenV0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjYyMDY3NTMsImV4cCI6MjA0MTc4Mjc1M30.a_bwLBwoQfjeUe5TS9Tu4Z7ZcqyelWG0kboR1W1wN50";
  final String _KAKAO_CLIENT_ID = "fae09a789296ff73d9a6d96fd04cc2b3";
  final String _KAKAO_JS_CLIENT_ID = "1aa6141b181b33feb8fc8fbda29527b9";

  static SuPaBaseEnv? _instance;

  static SuPaBaseEnv get instance => _instance ??= SuPaBaseEnv._internal();

  SuPaBaseEnv._internal();

  String get projectURL => _projURL;

  String get projectApiKey => _projApiKey;

  String get kaKaoClientId => _KAKAO_CLIENT_ID;

  String get kaKaoJsClientId => _KAKAO_JS_CLIENT_ID;
}
