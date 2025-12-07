import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';
import 'search_page.dart'; // إحنا هنستخدم SearchPage بدل DoctorsPage

// DoctorsPage إتستبدلت بـ SearchPage
class DoctorsPage extends StatelessWidget {
  const DoctorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SearchPage(); // رجعت SearchPage هنا
  }
}

// باقي الـ pages تبقى كما هي
class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Appointments",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Appointments Page",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          "Profile Page",
          style: AppTextStyles.headlineMedium.copyWith(
            fontSize: 24 * scale,
          ),
        ),
      ),
    );
  }
}