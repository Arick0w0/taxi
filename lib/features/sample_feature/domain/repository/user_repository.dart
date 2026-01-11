import '../../data/model/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers();
  Future<UserModel> createUser(Map<String, dynamic> data);
  Future<UserModel> updateUser(String id, Map<String, dynamic> data);
}
