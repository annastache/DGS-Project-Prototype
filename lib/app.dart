import 'package:flutter/material.dart';

import 'core/app_colors.dart';
import 'screens/main_shell.dart';

class ViatoleaPrototypeApp extends StatelessWidget {
  const ViatoleaPrototypeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'viatolea Prototype',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accentYellow,
          surface: AppColors.surface,
        ),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.w800),
          titleLarge: TextStyle(fontWeight: FontWeight.w800),
          titleMedium: TextStyle(fontWeight: FontWeight.w700),
          bodyMedium: TextStyle(height: 1.35),
        ),
      ),
      builder: (context, child) => _PhonePreviewFrame(child: child ?? const SizedBox.shrink()),
      home: const MainShell(),
    );
  }
}

class _PhonePreviewFrame extends StatelessWidget {
  const _PhonePreviewFrame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWidePreview = size.width > 520;

    if (!isWidePreview) {
      return child;
    }

    return ColoredBox(
      color: const Color(0xFF172217),
      child: Center(
        child: Container(
          width: 390,
          height: size.height < 860 ? size.height - 28 : 844,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(34),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.32),
                blurRadius: 28,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: Size(390, size.height < 860 ? size.height - 28 : 844),
              padding: EdgeInsets.zero,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
