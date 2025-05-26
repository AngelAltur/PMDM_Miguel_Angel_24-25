import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/login.dart';
import '../screens/home.dart';

/// Widget que decide qué pantalla mostrar según el estado de autenticación.
class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Mientras esperamos el estado
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Usuario autenticado
        if (snapshot.hasData) {
          return const PantallaHome();
        }

        // No autenticado
        return const PantallaLogin();
      },
    );
  }
}
