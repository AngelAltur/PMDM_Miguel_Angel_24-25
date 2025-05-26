import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';   // ← Importa el archivo generado
import 'screens/login.dart';
import 'screens/home.dart';
import 'screens/register.dart';
import 'widgets/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  
  );
  runApp(const SafeBiteApp());
}

class SafeBiteApp extends StatelessWidget {
  const SafeBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeBite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green,
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,  
      elevation: 0,
  ),
      ),
      home: const Autenti(),
      routes: {
        '/login':    (_) => const PantallaLogin(),
        '/register': (_) => const PantallaRegistro(),
        '/reset':    (_) => const PantallaRecuperar(),
        '/home':     (_) => const PantallaHome(),
      },
    );
  }
}
