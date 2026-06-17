import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class TopBrandHeader extends StatelessWidget {
  const TopBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 6),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle_outlined),
            color: AppColors.primary,
          ),
          Expanded(
            child: Center(
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                    letterSpacing: -1.4,
                  ),
                  children: [
                    TextSpan(text: 'viat'),
                    TextSpan(
                      text: 'o',
                      style: TextStyle(color: AppColors.accentYellow),
                    ),
                    TextSpan(text: 'lea'),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help_outline),
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
