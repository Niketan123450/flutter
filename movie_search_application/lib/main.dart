import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:movie_search_application/core/routes/go_router.dart';
import 'package:movie_search_application/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCvhl2Say1QAfMb2rA13DqxVaB8IP2h-Y0",
      appId: "1:973797220694:android:ec4b4863104ea06f26b6f7",
      messagingSenderId: "973797220694",
      projectId: "movie-search-application-a1ebe",
    ),
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: route,
    );
  }
}
