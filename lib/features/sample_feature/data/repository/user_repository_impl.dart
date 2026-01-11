import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/repository/user_repository.dart';
import '../model/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final DioClient _dioClient;

  UserRepositoryImpl(this._dioClient);

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _dioClient.get('/users');
    final List<dynamic> data = response;
    return data.map((json) => UserModel.fromJson(json)).toList();
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.watch(dioClientProvider));
});
