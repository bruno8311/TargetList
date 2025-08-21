import '../entities/card_item.dart';

abstract class CardRepository {
  Future<List<CardItem>> getCards();
  Future<void> addCard(CardItem card);
  Future<void> editCard(int index, CardItem card);
  Future<void> removeCard(int index);
}
