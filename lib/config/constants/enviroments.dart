import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'no api';
  static String stipeKeyPublic = dotenv.env['STRIPE_PUBLIC'] ?? 'no key';
  static String stipeKeySecret = dotenv.env['STRIPE_KEY'] ?? 'no key';
}
