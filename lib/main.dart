import 'package:flutter/material.dart';
import 'dart:io';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Banco local
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Telas
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Doação de Roupas",
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}