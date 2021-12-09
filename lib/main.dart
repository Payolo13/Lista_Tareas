import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lista_tareas/pages/home_page.dart';
import 'package:lista_tareas/pages/singin_page.dart';
import 'package:lista_tareas/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = const SingIn();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = const Home();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: currentPage,
    );
  }
}
