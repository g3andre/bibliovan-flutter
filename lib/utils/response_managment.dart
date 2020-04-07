class ResponseManagment<T> {
  bool _hasError;
  String _message;
  T _responseBody;

  ResponseManagment(
      {bool hasError = false, String message = "", responseBody}) {
    this._hasError = hasError;
    this.message = message;
    this._responseBody = responseBody;
  }

  set hasError(bool hasError) {
    this._hasError = hasError;
  }

  set message(String message) {
    this._message = message;
  }

  set responseBody(T responseBody) => this._responseBody = responseBody;

  get hasError => this._hasError;
  get message => this._message;
  get responseBody => this._responseBody;
}
