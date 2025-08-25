import 'package:flutter/material.dart';
import '../../domain/entities/card_item.dart';
import '../../domain/usecases/cards/get_cards.dart';
import '../../domain/usecases/cards/add_card.dart';
import '../../domain/usecases/cards/edit_card.dart';
import '../../domain/usecases/cards/remove_card.dart';
import '../../data/repositories/card_repository_impl.dart';
class CardProvider extends ChangeNotifier {
  //Casos de uso
	final GetCards getCardsUseCase;
	final AddCard addCardUseCase;
	final EditCard editCardUseCase;
	final RemoveCard removeCardUseCase;

	List<CardItem> listElements = [];

	CardProvider()
		: getCardsUseCase = GetCards(CardRepositoryImpl()),
      addCardUseCase = AddCard(CardRepositoryImpl()),
	    editCardUseCase = EditCard(CardRepositoryImpl()),
	  	removeCardUseCase = RemoveCard(CardRepositoryImpl());

	Future<void> addCard(CardItem newCard) async {
		await addCardUseCase.call(newCard); //caso de uso para añadir elemento de tipo CardItem
		await loadCards();
		notifyListeners();
	}

	Future<void> editCard(int index, CardItem newCard) async {
		await editCardUseCase.call(index, newCard);
		await loadCards();
		notifyListeners();
	}

	Future<void> removeCard(int index) async {
		await removeCardUseCase.call(index);
		await loadCards();
		notifyListeners();
	}

	Future<void> loadCards() async {
		listElements = await getCardsUseCase.call();
		notifyListeners();
	}
}