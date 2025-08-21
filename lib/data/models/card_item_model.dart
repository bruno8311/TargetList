import '../../domain/entities/card_item.dart';

class CardItemModel extends CardItem {
  CardItemModel({
    required super.title,
    required super.description,
    required super.detail,
    super.imageUrl,
  });

  //Permiten crear una instancia de tipo CardItemModel
  factory CardItemModel.fromJson(Map<String, dynamic> json) => CardItemModel(
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    detail: json['detail'] ?? '',
    imageUrl: json['imageUrl'],
  );

  //Convierte un objeto a un modelo
  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'detail': detail,
    'imageUrl': imageUrl,
  };
}
