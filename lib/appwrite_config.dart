import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppwriteConfig {
  static final Client _client = Client()
    ..setEndpoint(dotenv.env['APPWRITE_ENDPOINT']!)
    ..setProject(dotenv.env['APPWRITE_PROJECT_ID']!)
    ..setSelfSigned(); // solo para desarrollo

  static Client getClient() => _client;

  static String get databaseId => dotenv.env['APPWRITE_DATABASE_ID']!;
  static String get collectionId => dotenv.env['APPWRITE_COLLECTION_ID']!;
}
