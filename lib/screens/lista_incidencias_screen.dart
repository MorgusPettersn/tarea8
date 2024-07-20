import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/incidencia.dart';
import 'detalle_incidencia_screen.dart';

class ListaIncidenciasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Incidencias')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.getIncidencias(),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final incidencia = Incidencia.fromMap(snapshot.data![index]);
                return ListTile(
                  title: Text(incidencia.titulo),
                  subtitle: Text(incidencia.fecha),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleIncidenciaScreen(incidencia: incidencia),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}