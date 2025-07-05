import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String fullName;
  final String email;
  final String password;
  final String? phone;

  const UserEntity({
    this.userId,
    required this.fullName,
    required this.email,
    required this.password,
    this.phone,
  });

  @override
  List<Object?> get props => [userId, fullName, email, password, phone];
}