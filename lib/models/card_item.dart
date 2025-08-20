

class CardItem {
  final String titulo;
  final String descripcion;
  final String detalle;
  final String? imageUrl;

  CardItem({
    required this.titulo,
    required this.descripcion,
    required this.detalle,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'titulo': titulo,
    'descripcion': descripcion,
    'detalle': detalle,
    'imageUrl': imageUrl,
  };

  factory CardItem.fromJson(Map<String, dynamic> json) => CardItem(
    titulo: json['titulo'],
    descripcion: json['descripcion'],
    detalle: json['detalle'],
    imageUrl: json['imageUrl'],
  );
}
