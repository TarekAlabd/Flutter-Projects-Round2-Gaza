class ApiPaths {
  static String user(String uid) => 'users/$uid';

  static String message(String messageId) => 'messages/$messageId';
  static String messages() => 'messages/';
}