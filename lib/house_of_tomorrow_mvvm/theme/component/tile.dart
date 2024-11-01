import 'package:flutter/material.dart';
import 'package:flutter_workspace/house_of_tomorrow_mvvm/src/service/theme_service.dart';

import 'asset_icon.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final String icon;
  final String title;
  final String subtitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Start Icon
            AssetIcon(icon),
            const SizedBox(width: 8),

            // Title
            Expanded(
              child: Text(
                title,
                style: context.typo.headline5,
              ),
            ),
            const SizedBox(width: 8),

            // Subtitle
            Text(
              subtitle,
              style: context.typo.subtitle1.copyWith(
                color: context.color.primary,
              ),
            ),
            const SizedBox(width: 8),

            // End Icon
            const AssetIcon('chevron-right'),
          ],
        ),
      ),
    );
  }
}
