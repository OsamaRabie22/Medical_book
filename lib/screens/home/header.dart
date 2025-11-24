import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';
import '../../core/utils/responsive_utils.dart';

Widget buildHeader(BuildContext context) {
  final scale = ResponsiveUtils.getScale(context);
  final isTablet = ResponsiveUtils.isTablet(context);

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: isTablet ? 28 * scale : 22 * scale,
            backgroundImage: const AssetImage(
              "assets/photogrid.photocollagemaker.photoeditor.squarepic_202422121565198.png",
            ),
          ),
          SizedBox(width: isTablet ? 16 * scale : 12 * scale),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, Osama👋",
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? 18 * scale : 16 * scale,
                ),
              ),
              Text(
                "How are you feeling today?",
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.grey,
                  fontSize: isTablet ? 14 * scale : 12 * scale,
                ),
              ),
            ],
          ),
        ],
      ),
      Icon(
          Icons.notifications_none,
          size: isTablet ? 32 * scale : 28 * scale,
          color: AppColors.primary
      ),
    ],
  );
}