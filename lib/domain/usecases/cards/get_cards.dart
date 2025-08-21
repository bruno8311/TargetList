import '../../entities/card_item.dart';
import '../../repositories/card_repository.dart';

class GetCards {
  final CardRepository repository;
  GetCards(this.repository);

  Future<List<CardItem>> call() async {
    return await repository.getCards();
  }
}
