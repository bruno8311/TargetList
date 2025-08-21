import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/card_item_model.dart';

class CardLocalDatasource {
  static const String key = 'cards';

  //Conseguimos las tarjetas desde SharedPreferences
  Future<List<CardItemModel>> getCards() async {
    final prefs = await SharedPreferences.getInstance();
    final cardsString = prefs.getString(key);
    if (cardsString != null) {
      final cardsJson = jsonDecode(cardsString) as List;
      return cardsJson.map((e) => CardItemModel.fromJson(Map<String, dynamic>.from(e))).toList();
    }
    // Si no hay datos, retorna una lista inicial
    return List.generate(
      3,
      (index) => CardItemModel(
        title: 'Tarjeta ${index + 1}',
        description: 'Esta es una descripción corta para la tarjeta ${index + 1} que aparecerá en la pantalla principal. Mantenla por debajo de 100 caracteres para que no se corte.',
        detail: 'Aquí puedes encontrar información más específica sobre la tarjeta ${index + 1}. Este es el contenido que se mostrará en la pantalla de detalles cuando el usuario toque la tarjeta. Puedes incluir información técnica, características especiales o cualquier otro dato relevante que consideres importante para el usuario.',
        imageUrl: 'https://picsum.photos/200/200?random=${index + 1}',
      ),
    );
  }

  // Guardamos los datos en SharedPreferences
  Future<void> saveCards(List<CardItemModel> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final cardsJson = cards.map((e) => e.toJson()).toList();
    await prefs.setString(key, jsonEncode(cardsJson));
  }
}
