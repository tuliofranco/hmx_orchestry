import 'package:flutter/material.dart';
import 'package:hmx_orchestry/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logging/logging.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
_setupLogging();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL; // Configura o nível de log
  Logger.root.onRecord.listen((record) {
  print('${record.level.name}: ${record.time}: ${record.message}');
  });
}
