class ServerException implements Exception {
  final dynamic message;

  ServerException([this.message]);
}

class CacheException implements Exception {}
