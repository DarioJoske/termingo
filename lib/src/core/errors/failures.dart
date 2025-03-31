import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String? message;
  final String? statusCode;

  String get errorMessage => 'Error: $message';
  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});
}
