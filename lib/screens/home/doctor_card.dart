// في DoctorCard widget بدل ما نعمل onBookPressed
// هنعمل onTap على الكارد كله

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final String specialty;
  final String location;
  final double rating;
  final String image;
  final VoidCallback onTap; // غيرنا الاسم

  const DoctorCard({
    super.key,
    required this.name,
    required this.specialty,
    required this.location,
    required this.rating,
    required this.image,
    required this.onTap, // غيرنا الاسم
  });

  @override
  Widget build(BuildContext context) {
    final scale = ResponsiveUtils.getScale(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return GestureDetector( // ضفنا GestureDetector
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isTablet ? 20 * scale : 18 * scale),
        decoration: BoxDecoration(
          color: AppColors.scaffoldBackground, // خلفية فاتحة للكروت
          borderRadius: BorderRadius.circular(isTablet ? 24 * scale : 22 * scale),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8 * scale,
              offset: Offset(0, 3 * scale),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة
            ClipRRect(
              borderRadius: BorderRadius.circular(isTablet ? 20 * scale : 18 * scale),
              child: Image.asset(
                image,
                width: isTablet ? 100 * scale : 85 * scale,
                height: isTablet ? 130 * scale : 110 * scale,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: isTablet ? 20 * scale : 18 * scale),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: AppTextStyles.headlineSmall.copyWith(
                            color: AppColors.primaryDark,
                            fontSize: isTablet ? 19 * scale : 17 * scale,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                          Icons.bookmark_border,
                          size: isTablet ? 22 * scale : 20 * scale,
                          color: AppColors.primary
                      ),
                    ],
                  ),
                  SizedBox(height: isTablet ? 6 * scale : 4 * scale),
                  Text(
                    specialty,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.greyDark,
                      fontSize: isTablet ? 16 * scale : 14 * scale,
                    ),
                  ),
                  SizedBox(height: isTablet ? 8 * scale : 6 * scale),
                  Row(
                    children: [
                      Icon(
                          Icons.location_on,
                          size: isTablet ? 18 * scale : 16 * scale,
                          color: Colors.red.shade400
                      ),
                      SizedBox(width: isTablet ? 6 * scale : 4 * scale),
                      Expanded(
                        child: Text(
                          location,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.greyDark,
                            fontSize: isTablet ? 14 * scale : 12 * scale,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isTablet ? 8 * scale : 6 * scale),
                  Row(
                    children: [
                      Icon(
                          Icons.star,
                          size: isTablet ? 20 * scale : 18 * scale,
                          color: Colors.amber.shade700
                      ),
                      SizedBox(width: isTablet ? 6 * scale : 4 * scale),
                      Text(
                        "$rating",
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: isTablet ? 16 * scale : 14 * scale,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}