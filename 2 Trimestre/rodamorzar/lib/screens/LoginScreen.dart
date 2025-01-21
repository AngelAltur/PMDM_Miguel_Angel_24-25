import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildHeader(),
              Spacer(),
              _buildLoginForm(context), // Pasamos el contexto
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(top: 50.0),
      child: Text(
        'RODAMORZAR',
        style: TextStyle(
          fontSize: 32,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) { // Recibe el contexto como parámetro
    return Column(
      children: [
        _buildTextField('Usuari'),
        SizedBox(height: 20),
        _buildTextField('Contrasenya', obscureText: true),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Acción para el botón de entrada
          },
          child: Text('Entrada'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
          child: Text(
            'Mode proba',
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            // Acción para el enlace de registro
          },
          child: Text(
            'No tens conte? Registrat açí.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String labelText, {bool obscureText = false}) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15), 
        ),
      ),
      obscureText: obscureText,
    );
  }
}
