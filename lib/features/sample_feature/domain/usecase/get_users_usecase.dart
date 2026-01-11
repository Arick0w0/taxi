import '../repository/user_repository.dart';
import '../../data/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/user_repository_impl.dart';

class GetUsersUseCase {
  final UserRepository _repository;

  GetUsersUseCase(this._repository);

  Future<List<UserModel>> call() async {
    return _repository.getUsers();
  }
}

final getUsersUseCaseProvider = Provider<GetUsersUseCase>((ref) {
  return GetUsersUseCase(ref.watch(userRepositoryProvider));
});
