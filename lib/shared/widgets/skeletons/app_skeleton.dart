import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// The base wrapper for all Skeleton loading states in the app.
/// 
/// Usage: Wraps a widget (like ListView) to animate it.
/// If [enabled] is true, the child is rendered as a Skeleton.
class AppSkeleton extends StatelessWidget {
  final bool enabled;
  final Widget child;
  final bool containersColor;
  final PaintingEffect? effect;

  const AppSkeleton({
    super.key,
    required this.enabled,
    required this.child,
    this.containersColor = false,
    this.effect,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      containersColor: containersColor ? Colors.grey.shade300 : null,
      // Centralized Effect config for the entire app. 
      // Change here to switch between Shimmer/Pulse globally.
      effect: effect ?? const ShimmerEffect(), 
      child: child,
    );
  }
}
