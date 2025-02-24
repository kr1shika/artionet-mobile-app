class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:5055/api/";

  // For iphone
  // static const String baseUrl = "http://localhost:3000/api/v1/";

// --------AUth ROutes
  static const String register = "user/register";
  static const String login = "user/login";
  static const String uploadImage = "user/uploadImage";

//  ______-art work
  static const String getArtworks = "artwork/findall";
  static const String getArtworkbyId = "artwork/find";
  static const String createNewArtwork = "artwork/save";
  static const String uploadArtImage = "artwork/uploadArtImage";
  static const String getArtworksbyUserId = "artwork//users-art";

  // purchase
  static const String getPurchasesByUserId = "purchases/getpurchases";
  static const String createPurchase = "purchases/create";
}
