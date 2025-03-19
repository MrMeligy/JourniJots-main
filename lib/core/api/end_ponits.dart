class EndPoint {
  static String baseUrl = "http://10.0.2.2:5206/api/";
  static String logIn = "Account/Login";
  static String getUserDataEndPoint(id) {
    return "user/get-user/$id";
  }
}

class ApiKey {
  static String status = "status";
  static String errorMessage = "errors";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String id = "id";
}
