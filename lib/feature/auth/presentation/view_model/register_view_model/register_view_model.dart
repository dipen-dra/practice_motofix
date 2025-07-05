import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motofix_app/app/service_locator/service_locator.dart';
import 'package:motofix_app/core/common/snack_bar.dart';
import 'package:motofix_app/feature/auth/domain/use_case/register_use_case.dart';
import 'package:motofix_app/feature/auth/presentation/view/signin_page.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/egister_event.dart';
import 'package:motofix_app/feature/auth/presentation/view_model/register_view_model/register_state.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final UserRegisterUseCase _userRegisterUseCase;

  RegisterViewModel(this._userRegisterUseCase) : super(RegisterState.initial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<NavigateToLoginEvent>(_onNavigateToLoginView);
  }

  /// Handles user registration
  Future<void> _onRegisterUser(
      RegisterUserEvent event,
      Emitter<RegisterState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _userRegisterUseCase(
      RegisterUserParams(
        email: event.email,
        fullName: event.fullName,
        password: event.password,
      ),
    );

    result.fold(
          (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: failure.message,
          color: Colors.red,
        );
      },
          (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
          context: event.context,
          message: "Registration successful! Please sign in.",
          color: Colors.green,
        );
        add(NavigateToLoginEvent(context: event.context));
      },
    );
  }

  /// Navigates to the login screen
  void _onNavigateToLoginView(
      NavigateToLoginEvent event,
      Emitter<RegisterState> emit,
      ) {
    Navigator.pushAndRemoveUntil(
      event.context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: serviceLocator<LoginViewModel>(),
          child: const SignInPage(),
        ),
      ),
          (route) => false,
    );
  }
}
