abstract class LoginState {}

class InitLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {}

class FailureLoginState extends LoginState {
  String erroeMessage;
  FailureLoginState({
    required this.erroeMessage,
  });
}
