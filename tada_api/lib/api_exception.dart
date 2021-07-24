class TadaApiException implements Exception {
  final String message;

  TadaApiException({this.message = 'common error'});

  String toString() {
    return "Exception: $message";
  }
}

class TadaApiNotFoundException extends TadaApiException {}
