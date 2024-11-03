import 'dart:developer';
import 'package:firebase_aoy/Blocs/SignUpBloc/sign_up_blocks.dart';
import 'package:firebase_aoy/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'Blocs/LoginBloc/LogIn_Bloc.dart';
import 'Login_Signup/Login.dart';
//import 'Login_Signup/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    log('Invalid Error! $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_)=> SignUpBloc()),
      BlocProvider(create: (_)=> LoginBloc()),
    ],
        child:GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FooDash',
      theme: ThemeData.light(),
      themeMode: ThemeMode.system,
      home: const Login(),
    ));
  }
}
