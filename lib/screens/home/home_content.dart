import 'package:flutter/material.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../widgets/app_logo.dart';
import '../../widgets/doctor_card.dart';
import 'booking_page.dart';
import 'header.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 24 * scale : 20 * scale,
          vertical: isTablet ? 12 * scale : 8 * scale,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ اللوجو
            const Center(child: AppLogo()),

            // ✅ Header
            buildHeader(context),
            SizedBox(height: isTablet ? 30 * scale : 25 * scale),

            // ✅ إزالة الـ Search Bar من هنا

            SizedBox(height: isTablet ? 35 * scale : 30 * scale),

            // ✅ Section Title
            Text(
              "Top Doctors",
              style: AppTextStyles.headlineSmall.copyWith(
                color: AppColors.primaryDark,
                fontSize: isTablet ? 22 * scale : 20 * scale,
              ),
            ),
            SizedBox(height: isTablet ? 25 * scale : 20 * scale),

            // ✅ Doctor Cards
            DoctorCard(
              name: "Dr. Ahmed Hassan",
              specialty: "Cardiologist",
              location: "Cairo – Maadi",
              rating: 4.9,
              image: "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
              onBookPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(
                      doctorName: "Dr. Ahmed Hassan",
                      specialty: "Cardiologist",
                      doctorImage: "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: isTablet ? 20 * scale : 18 * scale),
            DoctorCard(
              name: "Dr. Sara Mohamed",
              specialty: "Dermatologist",
              location: "Cairo – Nasr City",
              rating: 4.8,
              image: "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
              onBookPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(
                      doctorName: "Dr. Sara Mohamed",
                      specialty: "Dermatologist",
                      doctorImage: "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: isTablet ? 30 * scale : 25 * scale),
          ],
        ),
      ),
    );
  }
}