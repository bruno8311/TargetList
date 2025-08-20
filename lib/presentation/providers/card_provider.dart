import 'package:flutter/material.dart';
import '../../models/card_item.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CardProvider extends ChangeNotifier {
	CardProvider() {
		loadCards();
	}

	List<CardItem> listElements = List.generate(
		3,
		(index) => CardItem(
			titulo: 'Tarjeta ${index + 1}',
			descripcion: 'Esta es una breve descripcion de la tarjeta ${index + 1} que se mostrara en la pantalla principal, que sea menor de 100 caracteres para que no se corte.',
			detalle: 'Aquí puedes encontrar información más específica sobre la tarjeta ${index + 1}. Este es el contenido que se mostrará en la pantalla de detalles cuando el usuario toque la tarjeta. Puedes incluir información técnica, características especiales, o cualquier otro dato relevante que consideres importante para el usuario.',
			imageUrl: 'https://picsum.photos/200/200?random=${index + 1}',
		),
	);

	Future<void> addCard(CardItem newCard) async {
		listElements.add(newCard);
		await saveCards();
		notifyListeners();
	}

	Future<void> editCard(int index, CardItem newCard) async {
		listElements[index] = newCard;
		await saveCards();
		notifyListeners();
	}

	Future<void> removeCard(int index) async {
		listElements.removeAt(index);
		await saveCards();
		notifyListeners();
	}

	Future<void> saveCards() async {
		final prefs = await SharedPreferences.getInstance();
		final tarjetasJson = listElements.map((e) => e.toJson()).toList();
		await prefs.setString('cards', jsonEncode(tarjetasJson));
	}

	Future<void> loadCards() async {
		final prefs = await SharedPreferences.getInstance();
		final tarjetasString = prefs.getString('cards');
		if (tarjetasString != null) {
			final tarjetasJson = jsonDecode(tarjetasString) as List;
			listElements = tarjetasJson
					.map((e) => CardItem.fromJson(Map<String, dynamic>.from(e)))
					.toList();
			notifyListeners();
		}
	}
}