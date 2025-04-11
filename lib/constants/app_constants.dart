import 'api.dart';

String generateUrl(String query) {
  return "https://api.edamam.com/search?q=$query&app_id=$appId&app_key=$apiKey";
}
