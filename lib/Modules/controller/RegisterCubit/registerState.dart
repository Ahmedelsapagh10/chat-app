abstract class RegisterState {}

class InitRegisterState extends RegisterState {}

class SucessRegisterState extends RegisterState {}

class FaliureRegisterState extends RegisterState {
  String errorMessage;
  FaliureRegisterState({
    required this.errorMessage,
  });
}

class LoadingRegisterState extends RegisterState {}
