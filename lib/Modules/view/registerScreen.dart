// ignore_for_file: use_build_context_synchronously

import 'package:chat_app/Component.dart';
import 'package:chat_app/Modules/controller/RegisterCubit/registerCubit.dart';
import 'package:chat_app/Modules/controller/RegisterCubit/registerState.dart';
import 'package:chat_app/Modules/view/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static String id = 'RegisterScreen';
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is LoadingRegisterState) {
          isLoading = true;
        } else if (state is SucessRegisterState) {
          isLoading = false;
          Navigator.pushNamed(context, HomeScreen.id, arguments: email);
        } else if (state is FaliureRegisterState) {
          ShowSnakBar(context, state.errorMessage, Colors.black45);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: KprimaryColor,
            body: SafeArea(
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
                            'REGISTER',
                            style: TextStyle(
                                color: Colors.white,
                                //  fontFamily: 'Pacifico',
                                fontSize: 28),
                          ),
                        ),
                        MySpace(),
                        Custom_Text_Field(
                          hintText: 'Email',
                          textInputType: TextInputType.text,
                          onChange: (e) {
                            email = e;
                          },
                        ),
                        MySpace(),
                        Custom_Text_Field(
                          hintText: 'password',
                          textInputType: TextInputType.visiblePassword,
                          onChange: (p) {
                            password = p;
                          },
                        ),
                        MySpace(),
                        MyButton(
                            text: 'Sign Up',
                            OnTap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context)
                                    .register_User(
                                        email: email!, password: password!);
                              }
                            }),
                        MySpace(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('I Already have account! ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Sign in',
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

}
