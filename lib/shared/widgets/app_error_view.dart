import 'package:flutter/material.dart';
import 'app_button.dart';

class AppErrorView extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;

  const AppErrorView({
    super.key,
    this.title = 'Error',
    required this.message,
    this.onRetry,
  });

  factory AppErrorView.noInternet({VoidCallback? onRetry}) {
    return AppErrorView(
      title: 'No Internet Connection',
      message: 'Please check your network settings and try again.',
      onRetry: onRetry,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              AppButton(text: 'Retry', onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}
