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
    // Si no hay datos guardados, retorna un array vacío
    return [];
  }

  // Guardamos los datos en SharedPreferences
  Future<void> saveCards(List<CardItemModel> cards) async {
    final prefs = await SharedPreferences.getInstance();
    final cardsJson = cards.map((e) => e.toJson()).toList();
    await prefs.setString(key, jsonEncode(cardsJson));
  }
}
