class DatabaseException implements Exception {
  final String message;

  DatabaseException([this.message = 'Database error occurred']);

  @override
  String toString() => 'DatabaseException: $message';
}
