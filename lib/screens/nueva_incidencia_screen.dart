import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import '../database/database_helper.dart';
import '../models/incidencia.dart';

class NuevaIncidenciaScreen extends StatefulWidget {
  @override
  _NuevaIncidenciaScreenState createState() => _NuevaIncidenciaScreenState();
}

class _NuevaIncidenciaScreenState extends State<NuevaIncidenciaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();
  String? _imagePath;
  String? _audioPath;
  bool _isRecording = false;
  final _audioRecorder = Record();
  final _audioPlayer = AudioPlayer();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final path = await _audioRecorder.stop();
      setState(() {
        _isRecording = false;
        _audioPath = path;
      });
    } else {
      if (await _audioRecorder.hasPermission()) {
        final directory = await getApplicationDocumentsDirectory();
        final path = '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
        await _audioRecorder.start(path: path);
        setState(() {
          _isRecording = true;
        });
      }
    }
  }

  Future<void> _playAudio() async {
    if (_audioPath != null) {
      await _audioPlayer.play(DeviceFileSource(_audioPath!));
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final incidencia = Incidencia(
        titulo: _tituloController.text,
        fecha: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        descripcion: _descripcionController.text,
        foto: _imagePath ?? '',
        audio: _audioPath ?? '',
      );

      await DatabaseHelper.instance.insertIncidencia(incidencia.toMap());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nueva Incidencia')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Tomar Foto'),
            ),
            if (_imagePath != null) Text('Foto capturada'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleRecording,
              child: Text(_isRecording ? 'Detener Grabación' : 'Iniciar Grabación'),
            ),
            if (_audioPath != null)
              ElevatedButton(
                onPressed: _playAudio,
                child: Text('Reproducir Audio'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Guardar Incidencia'),
            ),
          ],
        ),
      ),
    );
  }
}