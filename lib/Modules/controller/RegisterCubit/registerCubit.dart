import 'package:chat_app/Modules/controller/RegisterCubit/registerState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(InitRegisterState());
  Future<void> register_User(
      {required String email, required String password}) async {
    emit(LoadingRegisterState());

    try {
      var auth = FirebaseAuth.instance;
      UserCredential UserData = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(SucessRegisterState());
      // print(UserData.user!.email);
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'weak-password') {
        emit(FaliureRegisterState(errorMessage: 'weak-password'));
      } else if (exception.code == 'email-already-in-use') {
        emit(FaliureRegisterState(errorMessage: 'email-already-in-use'));
      }
    } catch (e) {
      emit(FaliureRegisterState(errorMessage: e.toString()));
    }
  }
}
