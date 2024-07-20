import 'package:flutter/material.dart';

class AcercaDeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Acerca de')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/profile_photo.jpg'), // Asegúrate de tener esta imagen
            ),
            SizedBox(height: 20),
            Text('Nombre: [Tu Nombre]'),
            Text('Apellido: [Tu Apellido]'),
            Text('Matrícula: 20210291'),
            SizedBox(height: 20),
            Text(
              'Reflexión sobre seguridad:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'La vigilancia es el precio de la libertad. Nuestra misión es proteger a los ciudadanos mientras respetamos sus derechos fundamentales.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}