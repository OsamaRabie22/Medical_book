import 'package:flutter/material.dart';
import 'package:get/get.dart';

// الثوابت
import 'core/constants/app_colors.dart';
import 'core/constants/app_styles.dart';

// الشاشات
import 'screens/intro/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Medical Book',
      theme: ThemeData(
        // استخدام الثوابت بدل القيم المباشرة
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.primaryLight,
          background: AppColors.scaffoldBackground,
        ),
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        useMaterial3: true,
        fontFamily: 'Inter',

        // تطبيق الـ TextStyles globally
        textTheme: const TextTheme(
          displayLarge: AppTextStyles.headlineLarge,
          displayMedium: AppTextStyles.headlineMedium,
          displaySmall: AppTextStyles.headlineSmall,
          bodyLarge: AppTextStyles.bodyLarge,
          bodyMedium: AppTextStyles.bodyMedium,
          bodySmall: AppTextStyles.bodySmall,
        ),

        // تطبيق styles للأزرار
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            textStyle: AppTextStyles.buttonMedium,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),

        // تطبيق styles لحقول الإدخال
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.greyLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
      home: const WelcomeScreen(),
      debugShowCheckedModeBanner: false,

      // إعدادات أداء إضافية
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0, // منع تكبير النص
          ),
          child: child!,
        );
      },
    );
  }
}