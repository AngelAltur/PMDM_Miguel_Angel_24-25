import 'package:flutter/material.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int comptador = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Numero de clics'),
              Text(
                "$comptador",
                style: const TextStyle(fontSize: 50),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                
              
              const SizedBox(width: 5), 
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    comptador--;
                  });
                  print("$comptador");
                },
                child: const Icon(Icons.remove),
              ),
              const SizedBox(width: 5), 
              
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    comptador = 0;
                  });
                  print("$comptador");
                },
                child: const Icon(Icons.restore),
              ),
              const SizedBox(width: 5),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    comptador++;
                  });
                  print("$comptador");
                },
                child: const Icon(Icons.add),
              ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
