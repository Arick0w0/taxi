import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../model/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> createUser(Map<String, dynamic> userData);
  Future<UserModel> updateUser(String id, Map<String, dynamic> userData);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient _client;

  UserRemoteDataSourceImpl(this._client);

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await _client.get('/users');
    return (response as List).map((e) => UserModel.fromJson(e)).toList();
  }

  @override
  Future<UserModel> createUser(Map<String, dynamic> userData) async {
    // Example POST request
    final response = await _client.post('/users', data: userData);
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> updateUser(String id, Map<String, dynamic> userData) async {
    // Example PUT request
    final response = await _client.put('/users/$id', data: userData);
    return UserModel.fromJson(response);
  }
}

final userRemoteDataSourceProvider = Provider<UserRemoteDataSource>((ref) {
  return UserRemoteDataSourceImpl(ref.watch(dioClientProvider));
});
