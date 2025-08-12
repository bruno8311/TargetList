class TarjetaItem {
  final String titulo;
  final String descripcion;
  final String detalle;
  final String? imageUrl; //URL opcional

  TarjetaItem({
    required this.titulo, 
    required this.descripcion,
    required this.detalle,
    this.imageUrl,
  });
}
