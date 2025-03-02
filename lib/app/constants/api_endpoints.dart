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
  static const String getUserById = "user/";
  static const String updateProfile = "user/update";
  static const String deleteAccount = "user/delete";

//  ______-art work
  static const String getArtworks = "artwork/findall";
  static const String getArtworkbyId = "artwork/find";
  static const String createNewArtwork = "artwork/save";
  static const String uploadArtImage = "artwork/uploadArtImage";
  static const String getArtworksbyUserId = "artwork/users-art";
  static const String deleteArtworkbyId = "artwork/delete";
  static const String updateArtwork = 'artwork/update1';
  static const String searchArtworks = 'artwork/search';

  // purchase
  static const String getPurchasesByUserId = "purchases/getpurchases";
  static const String createPurchase = "purchases/create";
  static const String getArtistSales = "purchases/getSales";
  static const String updateStatus = "purchases/status";

  // save artworks [saveArt]
  static const String save = "saveArt/save";
  static const String removeFromCollection = "saveArt/";
  static const String getCollection = "saveArt/fetchcollection1";
  static const String checkStatus = "saveArt/checkStatus";

  // Notification
  static const String getUserNotification = "user-notifications/";
}
