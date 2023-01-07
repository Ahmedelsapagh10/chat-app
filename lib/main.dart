import 'package:chat_app/Modules/controller/HomeCubit/HomCubit.dart';
import 'package:chat_app/Modules/controller/RegisterCubit/registerCubit.dart';
import 'package:chat_app/Modules/controller/loginCubit/loginCubit.dart';
import 'package:chat_app/Modules/view/HomeScreen.dart';
import 'package:chat_app/Modules/view/registerScreen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Modules/view/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          RegisterScreen.id: (context) => RegisterScreen()
        },
        initialRoute: LoginScreen.id,
        //    home: LoginScreen(),
      ),
    );
  }
}
