class Failure {
  final String message;
  final int? statusCode;
  Failure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'Failure(message: $message, statusCode: $statusCode)';
}

// local database ko failure
class LocaldatabaseFailure extends Failure {
  LocaldatabaseFailure({
    required super.message,
  });
}

// api failure
class ApiFailure extends Failure {
  @override
  final int? statusCode;
  ApiFailure({
    this.statusCode,
    required super.message,
  });
}
