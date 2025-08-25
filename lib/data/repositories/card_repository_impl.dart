import '../models/card_item_model.dart';
import '../../domain/entities/card_item.dart';
import '../../domain/repositories/card_repository.dart';
import '../datasources/card_local_datasource.dart';

class CardRepositoryImpl implements CardRepository {
  final CardLocalDatasource _datasource = CardLocalDatasource();

  @override
  Future<List<CardItemModel>> getCards() async {
    return await _datasource.getCards();
  }

  @override
  Future<void> addCard(CardItem card) async { //Se llamo aqui
    final cards = await getCards(); //Llama los cards existentes
    cards.add(CardItemModel(
      title: card.title,
      description: card.description,
      detail: card.detail,
      imageUrl: card.imageUrl,
    )); //Añade el elemento
    await _datasource.saveCards(cards); //guarda
  }

  @override
  Future<void> editCard(int index, CardItem card) async {
    final cards = await getCards();
    cards[index] = CardItemModel(
      title: card.title,
      description: card.description,
      detail: card.detail,
      imageUrl: card.imageUrl,
    );
    await _datasource.saveCards(cards);
  }

  @override
  Future<void> removeCard(int index) async {
    final cards = await getCards();
    cards.removeAt(index);
    await _datasource.saveCards(cards);
  }
}
