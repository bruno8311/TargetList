import '../../entities/card_item.dart';
import '../../repositories/card_repository.dart';

class EditCard {
  final CardRepository repository;
  EditCard(this.repository);

  Future<void> call(int index, CardItem card) async {
    await repository.editCard(index, card);
  }
}
