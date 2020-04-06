class ApiUtils {
  static String URL_API = "http://10.0.2.2:8080";
}

class StatusCode {
  static const int OK = 200;
  static const int CREATED = 201;
  static const int NO_CONTENT = 204;
  static const int BAD_REQUEST = 400;
  static const int UNAUTHORIZED = 401;
  static const int NOT_FOUND = 404;
}

class Headers {
  static const Map<String, String> APPLICATION_JSON = {
    "Content-Type": "application/json"
  };
}
