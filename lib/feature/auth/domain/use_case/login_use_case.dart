import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:motofix_app/app/usecase/usecase.dart';
import 'package:motofix_app/core/error/failure.dart';
import 'package:motofix_app/feature/auth/domain/repository/user_repository.dart';


class LoginParams extends Equatable {
  final String email;

  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}

class UserLoginUseCase implements UseCaseWithParams<String, LoginParams> {
  final IUserRepository _userRepository;

  UserLoginUseCase({required IUserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, String>> call(LoginParams params) async {
    return await _userRepository.loginUser(params.email, params.password);
  }
}