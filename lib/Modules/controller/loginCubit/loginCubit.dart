import 'package:chat_app/Modules/controller/loginCubit/loginState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitLoginState());

  LoginUser({required String email, required String password}) async {
    emit(LoadingLoginState());
    try {
      var auth = FirebaseAuth.instance;
      final User = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(SuccessLoginState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(FailureLoginState(erroeMessage: 'user-not-found'));
      } else if (e.code == 'wrong-password') {
        emit(FailureLoginState(erroeMessage: 'wrong-password'));
      }
    } catch (e) {
      emit(FailureLoginState(erroeMessage: e.toString()));
    }
  }
}
