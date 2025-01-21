import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'audio_service.dart'; // Asegúrate de que esta clase existe y está bien configurada

/// Pantalla de reproducción de audio
class AudioPlayerScreen extends StatefulWidget {
  final AudioTrack track; // Objeto que contiene información de la pista de audio

  const AudioPlayerScreen({Key? key, required this.track}) : super(key: key);

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false; // Indica si el audio se está reproduciendo
  Duration _duration = Duration.zero; // Duración total de la pista
  Duration _position = Duration.zero; // Posición actual del audio
  bool _isDisposed = false; 

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Configurar los eventos del AudioPlayer
    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          _duration = duration;
        });
      }
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() {
          _position = position;
        });
      }
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _audioPlayer.dispose(); 
    super.dispose();
  }

  // Reproducir el audio
  void _play() async {
    try {
      await _audioPlayer.play(AssetSource(widget.track.path));
      if (mounted) {
        setState(() {
          _isPlaying = true;
        });
      }
    } catch (e) {
      print("Error al reproducir el audio: $e");
    }
  }

  // Alternar entre reproducción y pausa
  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _play();
    }
  }

  // Detener el audio
  void _stop() {
    _audioPlayer.stop();
    if (!_isDisposed) {
      setState(() {
        _position = Duration.zero;
      });
    }
  }

  
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.track.title),
    ),
    backgroundColor: Colors.blueGrey, 
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título de la pista
          Text(
            widget.track.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),

          // Barra de progreso
          Slider(
            min: 0,
            max: _duration.inSeconds.toDouble(),
            value: _position.inSeconds.toDouble().clamp(0, _duration.inSeconds.toDouble()),
            onChanged: (value) {
              _audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),

          // Controles de reproducción
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: _playPause,
              ),
              IconButton(
                icon: const Icon(Icons.stop),
                onPressed: _stop,
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Tiempos actuales y duración total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_formatDuration(_position)),
              Text(_formatDuration(_duration)),
            ],
          ),
        ],
      ),
    ),
  );
}

}

