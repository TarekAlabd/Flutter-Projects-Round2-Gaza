class ApiPath {
  static String products() => 'products/';
  static String product(String productId) => 'products/$productId';

  static String users() => 'users/';
  static String user(String userId) => 'users/$userId';

  static String favorites(String userId) => 'users/$userId/favorites/';
  static String favoriteItem(String userId, String favoriteId) => 'users/$userId/favorites/$favoriteId';

  static String cart(String userId) => 'users/$userId/cart/';
  static String cartItem(String userId, String itemId) => 'users/$userId/cart/$itemId';
}
