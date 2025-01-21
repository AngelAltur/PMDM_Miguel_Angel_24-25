import 'package:flutter/material.dart';
import 'darkwidget.dart'; // Importar el widget correcto

// Define el modelo AudioTrack
class AudioTrack {
  final String title;
  final String path;
  final String imgAlbum;

  AudioTrack({
    required this.title,
    required this.path,
    required this.imgAlbum,
  });
}

// Servicio para obtener las pistas de audio
class AudioService {
  static List<AudioTrack> getAudioTracks() {
    return [
      AudioTrack(
        title: 'AC/DC - Thunderstruck',
        path: 'lib/assets/audio/animote.mp3',
        imgAlbum: 'lib/assets/imagen/acdc.jpg', 
      ),
      AudioTrack(
        title: 'Stromae Pomme',
        path: 'lib/assets/audio/Stromae__Pomme_-_Ma_Meilleure_Ennemie_English_Lyrics__Arcane_Season_2_Soundtrack__[_YouConvert.net_].mp3',
        imgAlbum: 'lib/assets/imagen/dumbbel.jpg',
      ),
      AudioTrack(
        title: 'Twenty One Pilots',
        path: 'lib/assets/audio/Twenty_One_Pilots_-____The_Line_____from_Arcane_Season_2___Official_Music_Video__[_YouConvert.net_].mp3',
        imgAlbum: 'lib/assets/imagen/Twenty-One.jpg',
      ),
    ];
  }
}

// Pantalla que muestra las pistas de audio
class AudioTracksScreen extends StatelessWidget {
  final List<AudioTrack> _tracks = AudioService.getAudioTracks();

  AudioTracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canciones'),
      ),
      body: ListView.builder(
        itemCount: _tracks.length,
        itemBuilder: (context, index) {
          return DarkCardWidget(
            title: _tracks[index].title,
            description: 'Descripción de la pista ${_tracks[index].title}',
            imgAlbum: _tracks[index].imgAlbum,
          );
        },
      ),
    );
  }
}
