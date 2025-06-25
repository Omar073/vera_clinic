class FirebaseOperationException implements Exception {
  final String message;
  FirebaseOperationException(this.message);

  @override
  String toString() => message;
} 