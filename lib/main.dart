import 'package:flutter/material.dart';
import 'package:flutter_apptask/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyBoPI3puVz3q4P0BlIGKqgb99ZVOMQwNY4',
          appId: '1:968606669521:android:ecaa60ca36b62f47d0c3f0',
          messagingSenderId: '968606669521',
          projectId: "app-sgp-tech"));
  runApp(AppTask());
}

class AppTask extends StatelessWidget {
  const AppTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTask',
      debugShowCheckedModeBanner: false,
      home: HomrePage(),
    );
  }
}
