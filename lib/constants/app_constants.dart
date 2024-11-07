String apiKey = "17a55592b7dee41dfd6c20bd4d305177";
String appId = "67c8ff96";

String generateUrl(String query) {
  return "https://api.edamam.com/search?q=$query&app_id=$appId&app_key=$apiKey";
}
