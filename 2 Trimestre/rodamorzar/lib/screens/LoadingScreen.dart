import 'package:flutter/material.dart';

//Falsear una pantalla de carga con animacion de incio
//no implementado
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
