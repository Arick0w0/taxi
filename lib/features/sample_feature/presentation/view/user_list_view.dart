import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/user_viewmodel.dart';
import '../viewmodel/user_state.dart';
import '../../../../shared/widgets/app_loading_indicator.dart';
import '../../../../shared/widgets/app_error_view.dart';
// import '../../../../core/utils/connectivity_service.dart'; // No longer needed here

class UserListView extends ConsumerStatefulWidget {
  const UserListView({super.key});

  @override
  ConsumerState<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends ConsumerState<UserListView> {
  @override
  void initState() {
    super.initState();
    // Fetch data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userViewModelProvider.notifier).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to ViewModel state
    final userState = ref.watch(userViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(userViewModelProvider.notifier).fetchUsers(),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (userState.status) {
            case UserStatus.loading:
              return const AppLoadingIndicator();
            case UserStatus.error:
              return AppErrorView(
                message: userState.errorMessage ?? 'Unknown error',
                onRetry: () =>
                    ref.read(userViewModelProvider.notifier).fetchUsers(),
              );
            case UserStatus.success:
              if (userState.users.isEmpty) {
                return const Center(child: Text("No users found."));
              }
              return ListView.separated(
                itemCount: userState.users.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final user = userState.users[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(user.name[0])),
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // Navigate to details (not implemented in this sample but structured for it)
                      // context.goNamed('userDetails', pathParameters: {'id': user.id.toString()});
                    },
                  );
                },
              );
            case UserStatus.initial:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
