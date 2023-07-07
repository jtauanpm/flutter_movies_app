import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnvironmentConfig {
  // final movieApiKey = const String.fromEnvironment("apiKey");

  final movieApiKey = "8c3ab9c9";
}

final environmentConfigProvider = Provider<EnvironmentConfig>((ref) {
  return EnvironmentConfig();
});
