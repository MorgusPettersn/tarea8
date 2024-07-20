import 'package:flutter/material.dart';
import 'nueva_incidencia_screen.dart';
import 'lista_incidencias_screen.dart';
import 'acerca_de_screen.dart';
import '../database/database_helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Policías Secretos App'),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[900]!, Colors.blue[700]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildButton(
                context,
                'Nueva Incidencia',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NuevaIncidenciaScreen()),
                ),
                Icons.add_circle,
              ),
              SizedBox(height: 20),
              _buildButton(
                context,
                'Ver Incidencias',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaIncidenciasScreen()),
                ),
                Icons.list,
              ),
              SizedBox(height: 20),
              _buildButton(
                context,
                'Acerca de',
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AcercaDeScreen()),
                ),
                Icons.info,
              ),
              SizedBox(height: 20),
              _buildButton(
                context,
                'Borrar Todos los Registros',
                () => _borrarTodosLosRegistros(context),
                Icons.delete_forever,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed, IconData icon, {Color? color}) {
    return ElevatedButton.icon(
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: TextStyle(fontSize: 18)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  void _borrarTodosLosRegistros(BuildContext context) async {
    bool confirmacion = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Borrar todos los registros"),
          content: Text("¿Estás seguro de que quieres borrar todos los registros? Esta acción no se puede deshacer."),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text("Borrar"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmacion == true) {
      await DatabaseHelper.instance.deleteAllIncidencias();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Todos los registros han sido borrados')),
      );
    }
  }
}