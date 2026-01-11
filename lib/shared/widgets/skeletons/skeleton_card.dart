import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/theme/app_dimens.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppDimens.spacingM),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.spacingM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Bone(height: 120, width: double.infinity),
            const SizedBox(height: AppDimens.spacingM),
            Bone.text(words: 3, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppDimens.spacingS),
            const Bone.text(words: 10),
          ],
        ),
      ),
    );
  }
}
