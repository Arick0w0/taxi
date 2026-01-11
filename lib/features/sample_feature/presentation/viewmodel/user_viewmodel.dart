import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecase/get_users_usecase.dart';
import 'user_state.dart';
import '../../../../core/error/exceptions.dart';

class UserViewModel extends Notifier<UserState> {
  @override
  UserState build() {
    return const UserState();
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    final getUsersUseCase = ref.read(getUsersUseCaseProvider);
    
    // 4. Background Loading (Silent)
    // If we have data and it's a refresh, don't show full page loading skeleton
    // In a real app, you might set a separate `isRefreshing` flag here.
    if (!isRefresh || state.users.isEmpty) {
      state = state.copyWith(status: UserStatus.loading);
    }
    
    try {
      final users = await getUsersUseCase();
      state = state.copyWith(status: UserStatus.success, users: users);
    } on NetworkException catch (e) {
      state = state.copyWith(status: UserStatus.error, errorMessage: e.message);
    } on ServerException catch (e) {
      state = state.copyWith(status: UserStatus.error, errorMessage: e.message);
    } on UnauthorizedException catch (e) {
      state = state.copyWith(status: UserStatus.error, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(
        status: UserStatus.error,
        errorMessage: "Unexpected error occurred: $e",
      );
    }
  }
}

final userViewModelProvider = NotifierProvider<UserViewModel, UserState>(
  UserViewModel.new,
);
