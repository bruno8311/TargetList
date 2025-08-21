import '../../repositories/card_repository.dart';

class RemoveCard {
  final CardRepository repository;
  RemoveCard(this.repository);

  Future<void> call(int index) async {
    await repository.removeCard(index);
  }
}
