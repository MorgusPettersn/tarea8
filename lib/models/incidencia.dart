class Incidencia {
  final int? id;
  final String titulo;
  final String fecha;
  final String descripcion;
  final String foto;
  final String audio;

  Incidencia({
    this.id,
    required this.titulo,
    required this.fecha,
    required this.descripcion,
    required this.foto,
    required this.audio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'fecha': fecha,
      'descripcion': descripcion,
      'foto': foto,
      'audio': audio,
    };
  }

  factory Incidencia.fromMap(Map<String, dynamic> map) {
    return Incidencia(
      id: map['id'],
      titulo: map['titulo'],
      fecha: map['fecha'],
      descripcion: map['descripcion'],
      foto: map['foto'],
      audio: map['audio'],
    );
  }
}