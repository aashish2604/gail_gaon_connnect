import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sjs_app/firebase_options.dart';
import 'package:sjs_app/services/theme.dart';
import 'package:sjs_app/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.transparent),
        scaffoldBackgroundColor: kCatsKillWhiteColor.withOpacity(1),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Wrapper(),
    );
  }
}
