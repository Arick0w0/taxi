import 'package:flutter/material.dart';
import 'package:flutter_mvvm_101/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/localization/locale_provider.dart';
import '../viewmodel/user_viewmodel.dart';
import '../viewmodel/user_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../data/model/user_model.dart';
import '../widgets/user_list_tile.dart';
import '../../../../shared/widgets/skeletons/skeleton_widgets.dart';
import '../../../../shared/widgets/app_primary_button.dart';
import '../../../../shared/widgets/payment_processing_dialog.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../../shared/widgets/app_error_view.dart';
// import '../../../../core/utils/connectivity_service.dart'; // No longer needed here

class UserListView extends ConsumerStatefulWidget {
  const UserListView({super.key});

  @override
  ConsumerState<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends ConsumerState<UserListView> {
  // Option A (Cleanest): Generic Skeletons
  // We don't need _loadingUsers anymore if we use Option B.

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
        title: Text(S.of(context)!.userListTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: S.of(context)!.changeLanguage,
            onPressed: () {
              ref.read(localeProvider.notifier).toggleLocale();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                ref.read(userViewModelProvider.notifier).fetchUsers(),
          ),
        ],
      ),
      floatingActionButton: AppPrimaryButton(
        text: 'Simulate Payment',
        onPressed: () async {
          // 5. Payment / Critical Action (Blocking Dialog)
          PaymentProcessingDialog.show(context);

          // Simulate network delay
          await Future.delayed(const Duration(seconds: 3));

          if (context.mounted) {
            Navigator.of(context).pop(); // Close dialog
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment Successful!')),
            );
          }
        },
      ),
      body: Builder(
        builder: (context) {
          if (userState.status == UserStatus.error) {
            return AppErrorView(
              message: userState.errorMessage ?? 'Unknown error',
              onRetry: () =>
                  ref.read(userViewModelProvider.notifier).fetchUsers(),
            );
          }

          // 1. Page Load (Skeleton)
          final isLoading = userState.status == UserStatus.loading;

          return AppSkeleton(
            enabled: isLoading,
            child: ListView.separated(
              itemCount: isLoading ? 10 : userState.users.length,
              separatorBuilder: (context, index) => const Divider(),
              padding: const EdgeInsets.all(AppDimens.spacingM),
              itemBuilder: (context, index) {
                if (isLoading) {
                  return const SkeletonListTile();
                }

                final user = userState.users[index];
                return UserListTile(
                  name: user.name,
                  email: user.email,
                  onTap: () {
                    // Handle tap
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
