import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng? _currentLocation;
  final MapController _mapController = MapController(); // Controlador del mapa

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Servicio de localización no disponible.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permiso denegado');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Permisos permanentemente denegados');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      // Mueve el mapa a la nueva ubicación
      _mapController.move(_currentLocation!, 13.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inici'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Buscar...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Acción del icono de añadir
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController, // Añade el controlador al mapa
              options: MapOptions(
                center: _currentLocation ?? LatLng(51.5, -0.09),
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pedal_bike),
            label: 'Inici',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Bars',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Tu',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: () {
          // Acción del icono de configuración
        },
      ),
    );
  }
}
