class ServerExceptions implements Exception {
  final String errorMessage;

  ServerExceptions({required this.errorMessage});
}
