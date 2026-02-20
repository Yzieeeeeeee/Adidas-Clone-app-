import 'package:firebase/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var firebaseOptions = const FirebaseOptions(
    apiKey: "",
    appId: "",
    messagingSenderId: "",
    projectId: "",
    storageBucket: "",
  );

  await Firebase.initializeApp(options: firebaseOptions);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp( // ✅ Use GetMaterialApp instead of MaterialApp
      debugShowCheckedModeBanner: false,
      home: Splashscreen(),
    );
  }
}
