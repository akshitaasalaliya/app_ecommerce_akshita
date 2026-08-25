
class RepositoryConstants {

  static final RepositoryConstants _instance = RepositoryConstants._internal();

  factory RepositoryConstants() {
    return _instance;
  }

  RepositoryConstants._internal();

  static String products = "products";
  static String id = "id";
  static String title = "title";
  static String description = "description";
  static String images = "images";
  static String image = "image";
  static String price = "price";
  static String stock = "stock";
  static String category = "category";
  static String availabilityStatus = "availabilityStatus";
  static String rating = "rating";
  static String minimumOrderQuantity = "minimumOrderQuantity";
  static String isFavorite = "isFavorite";
  static String quantity = "quantity";

}