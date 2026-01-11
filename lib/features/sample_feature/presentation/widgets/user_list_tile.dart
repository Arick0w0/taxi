import 'package:flutter/material.dart';
import '../../../../core/theme/app_dimens.dart';

class UserListTile extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback? onTap;

  const UserListTile({
    super.key,
    required this.name,
    required this.email,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Basic logic to handle potential empty names if data is malformed
    final initial = name.isNotEmpty ? name[0] : "?";

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimens.spacingM,
      ),
      leading: CircleAvatar(radius: AppDimens.iconM, child: Text(initial)),
      title: Text(name, style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text(email),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
