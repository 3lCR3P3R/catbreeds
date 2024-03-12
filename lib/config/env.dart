import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static Future<void> init() async => await dotenv.load(fileName: ".env");

  factory Env() => _instance;

  Env._internal();
  static final Env _instance = Env._internal();

  /// Environment variables
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
