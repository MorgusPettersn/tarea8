import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import '../models/incidencia.dart';

class DetalleIncidenciaScreen extends StatelessWidget {
  final Incidencia incidencia;
  final AudioPlayer _audioPlayer = AudioPlayer();

  DetalleIncidenciaScreen({required this.incidencia});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(incidencia.titulo)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha: ${incidencia.fecha}'),
            SizedBox(height: 10),
            Text('Descripción: ${incidencia.descripcion}'),
            SizedBox(height: 20),
            if (incidencia.foto.isNotEmpty)
              Image.file(File(incidencia.foto))
            else
              Text('No hay foto disponible'),
            SizedBox(height: 20),
            if (incidencia.audio.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  _audioPlayer.play(DeviceFileSource(incidencia.audio));
                },
                child: Text('Reproducir Audio'),
              )
            else
              Text('No hay audio disponible'),
          ],
        ),
      ),
    );
  }
}