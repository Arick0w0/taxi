import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/theme/app_dimens.dart';

class SkeletonListTile extends StatelessWidget {
  const SkeletonListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.spacingM,
        vertical: AppDimens.spacingS,
      ),
      child: Row(
        children: [
          const Bone.circle(size: 40),
          const SizedBox(width: AppDimens.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Bone.text(
                  words: 2,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                const Bone.text(width: 100),
              ],
            ),
          ),
          const SizedBox(width: AppDimens.spacingM),
          const Bone.icon(),
        ],
      ),
    );
  }
}
