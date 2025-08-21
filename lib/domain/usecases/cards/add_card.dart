import '../../entities/card_item.dart';
import '../../repositories/card_repository.dart';

class AddCard {
  //Propiedad
  final CardRepository repository;
  AddCard(this.repository);

  //Metodo para agregar card
  Future<void> call(CardItem card) async {
    await repository.addCard(card);
  }
}
