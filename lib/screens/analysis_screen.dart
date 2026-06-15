import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../widgets/top_brand_header.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const TopBrandHeader(),
          const Divider(height: 1, color: AppColors.primary),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.insights_outlined, size: 62, color: AppColors.primary),
                  const SizedBox(height: 18),
                  Text('Analyse', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.primary)),
                  const SizedBox(height: 12),
                  const Text(
                    'Die echte Analyse ist für diesen Click-Dummy nicht notwendig. Der Screen bleibt als Navigationspunkt erhalten, damit sich der Prototyp nah an der bestehenden App anfühlt.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.textSoft),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
