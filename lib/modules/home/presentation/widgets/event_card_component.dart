import 'package:flutter/material.dart';
import 'package:flutter_kanpur_ui_kit/flutter_kanpur_ui_kit.dart';
import 'package:flutter_knp_mobile_app_v2/app/theme/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventCardComponent extends StatelessWidget {
  const EventCardComponent({
    super.key,
    required this.svgIconPath,
    required this.status,
    required this.statusColor,
    required this.organization,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.buttonText,
    required this.onButtonPressed,
    this.showEyeIcon = true,
    this.onEyeIconPressed,
  });

  /// Path to the SVG icon asset (e.g., 'assets/launch_event.svg')
  final String svgIconPath;

  /// Status text (e.g., 'Upcoming', 'Ongoing')
  final String status;

  /// Color for the status badge
  final Color statusColor;

  /// Organization name (e.g., 'Flutter Kanpur')
  final String organization;

  /// Event title (e.g., 'Launch Event')
  final String title;

  /// Event description
  final String description;

  /// Date and time info (e.g., 'Sun, 7 Apr • 4:00 PM • Kanpur')
  final String dateTime;

  /// Button text (e.g., 'Join live')
  final String buttonText;

  /// Callback when button is pressed
  final VoidCallback onButtonPressed;

  /// Whether to show eye icon on button (optional)
  final bool showEyeIcon;

  /// Callback when eye icon is pressed (optional)
  final VoidCallback? onEyeIconPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.grey[300]!, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SVG Icon with overlay status badge
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 12.h),
            child: Center(
              child: Stack(
                children: [
                  // SVG Icon background
                  Container(
                    width: 80.w,
                    height: 80.h,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: SvgPicture.asset(
                      svgIconPath,
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  // Status badge overlay on top-left
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: statusColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(status, style: textStyle_12SemiBoldWhite()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          12.verticalSpace,
          // Organization section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [10.verticalSpace],
            ),
          ),
          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(title, style: textStyle_18BlackMedium()),
          ),
          12.verticalSpace,
          // Date/Time
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(dateTime, style: textStyle_13SemiBoldBlue()),
          ),
          8.verticalSpace,
          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              description,
              style: textStyle_13RegularGrey(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          20.verticalSpace,
          // Button section
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: GradientButton(
                    onTap: onButtonPressed,
                    text: buttonText,
                    textStyle: textStyle_14SemiBoldWhite(),
                  ),
                ),
                if (showEyeIcon) ...[
                  12.horizontalSpace,
                  GestureDetector(
                    onTap: onEyeIconPressed,
                    child: Container(
                      width: 43.w,
                      height: 43.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(40.r),
                      ),
                      child: Icon(
                        Icons.visibility_outlined,
                        size: 20.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          20.verticalSpace,
        ],
      ),
    );
  }
}
