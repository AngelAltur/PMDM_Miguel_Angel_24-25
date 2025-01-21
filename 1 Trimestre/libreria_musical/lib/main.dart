import 'package:flutter/material.dart';
import 'package:libreria_musical/audio_player.dart';
import 'audio_service.dart'; 
import 'darkwidget.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multimedia Service',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto', 
      ),
      home: AudioListScreen(),
    );
  }
}

class AudioListScreen extends StatefulWidget {
  @override
  _AudioListScreenState createState() => _AudioListScreenState();
}

class _AudioListScreenState extends State<AudioListScreen> {
  late List<AudioTrack> _tracks;

  @override
  void initState() {
    super.initState();
    _loadAudioTracks();
  }

  void _loadAudioTracks() {
    _tracks = AudioService.getAudioTracks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ritmo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[800], 
      ),
      body: Container(
        color: Colors.grey[900], 
        child: _tracks.isEmpty
            ? const Center(
                child: CircularProgressIndicator(), 
              )
            : ListView.builder(
                itemCount: _tracks.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AudioPlayerScreen(track: _tracks[index]),
                        ),
                      );
                    },
                    child: DarkCardWidget(
                      title: _tracks[index].title,
                      description: 'Descripción de la pista ${_tracks[index].title}',
                      imgAlbum: _tracks[index].imgAlbum,
                    ),
                  );
                },
              ),
      ),
    );
  }
}
