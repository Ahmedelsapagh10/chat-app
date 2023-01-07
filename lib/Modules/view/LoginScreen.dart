// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/Component.dart';
import 'package:chat_app/Modules/controller/HomeCubit/HomCubit.dart';
import 'package:chat_app/Modules/controller/loginCubit/loginCubit.dart';
import 'package:chat_app/Modules/controller/loginCubit/loginState.dart';
import 'package:chat_app/Modules/view/HomeScreen.dart';
import 'package:chat_app/Modules/view/registerScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String id = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  ///
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoadingLoginState) {
          isLoading = true;
        } else if (state is SuccessLoginState) {
          BlocProvider.of<HomeCubit>(context).getAllMessages();
          Navigator.popAndPushNamed(context, HomeScreen.id, arguments: email);
          isLoading = false;
        } else if (state is FailureLoginState) {
          ShowSnakBar(context, state.erroeMessage, Colors.black);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: KprimaryColor,
          body: SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: isLoading,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Image.asset(
                          kLogo,
                          width: double.infinity,
                          height: 150,
                        ),
                        const Text(
                          appName,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Pacifico',
                              fontSize: 32),
                        ),
                        MySpace(),
                        Container(
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                //  fontFamily: 'Pacifico',
                                fontSize: 28),
                          ),
                        ),
                        MySpace(),
                        Custom_Text_Field(
                            onChange: (e) {
                              email = e;
                            },
                            hintText: 'Email',
                            textInputType: TextInputType.text),
                        MySpace(),
                        Custom_Text_Field(
                          onChange: (p) {
                            password = p;
                          },
                          hintText: 'password',
                          obscureText: true,
                          textInputType: TextInputType.visiblePassword,
                        ),
                        MySpace(),
                        MyButton(
                          text: 'Sign in',
                          OnTap: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<LoginCubit>(context).LoginUser(
                                  email: email!, password: password!);
                            }
                          },
                        ),
                        MySpace(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('if you don\'t have account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                )),
                            InkWell(
                              onTap: () {
                                // RegisterScreen.id  افضل بحيث يكون القيمه ثابته
                                Navigator.pushNamed(context, RegisterScreen.id);
                              },
                              child: const Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Color(0xffC7EDE6),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Future<void> LoginUser() async {
  //   var auth = FirebaseAuth.instance;
  //   final User = await auth.signInWithEmailAndPassword(
  //       email: email!, password: password!);
  // }
}
