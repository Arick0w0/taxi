import 'package:flutter/material.dart';
import '../../core/theme/app_dimens.dart';

class PaymentProcessingDialog extends StatelessWidget {
  final String title;
  final String message;

  const PaymentProcessingDialog({
    super.key,
    this.title = 'Processing',
    this.message = 'Please wait while we process your request...',
  });

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const PaymentProcessingDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimens.radiusL),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.spacingL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: AppDimens.spacingM),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppDimens.spacingS),
              Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
