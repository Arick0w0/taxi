import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repository/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../model/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<UserModel>> getUsers() {
    return _remoteDataSource.getUsers();
  }

  @override
  Future<UserModel> createUser(Map<String, dynamic> data) {
    return _remoteDataSource.createUser(data);
  }

  @override
  Future<UserModel> updateUser(String id, Map<String, dynamic> data) {
    return _remoteDataSource.updateUser(id, data);
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.watch(userRemoteDataSourceProvider));
});
