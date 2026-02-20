import 'package:firebase/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var firebaseOptions = const FirebaseOptions(
    apiKey: "AIzaSyCFQLLL8a_4sqqFZMuCOW41E7IJfPH4v4M",
    appId: "1:856276416659:android:c8ea9b9f9cfd200ac43566",
    messagingSenderId: "856276416659",
    projectId: "whatsapp-dd9b9",
    storageBucket: "whatsapp-dd9b9.appspot.com",
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
