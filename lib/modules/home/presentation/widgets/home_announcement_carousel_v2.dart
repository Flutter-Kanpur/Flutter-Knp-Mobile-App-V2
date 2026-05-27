import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/app/theme/app_text_styles.dart';
import 'package:flutter_knp_mobile_app_v2/utils/assets_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeAnnouncementCarouselV2 extends StatelessWidget {
  const HomeAnnouncementCarouselV2({
    super.key,
    required this.announcements,
    required this.currentPage,
    required this.onPageChanged,
    this.carouselController,
  });

  /// Each map has keys: title, body, btn_text, btn_url, background_image (nullable).
  final List<Map<String, String?>> announcements;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final CarouselSliderController? carouselController;

  @override
  Widget build(BuildContext context) {
    if (announcements.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          CarouselSlider.builder(

            carouselController: carouselController ?? CarouselSliderController(),
            itemCount: announcements.length,
            itemBuilder: (context, index, realIndex) {
              final n = announcements.length;
              final safeIndex = ((realIndex % n) + n) % n;
              return _AnnouncementCard(announcement: announcements[safeIndex]);
            },
            options: CarouselOptions(
              height: 190.h,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: announcements.length > 1,
              reverse: false,
              autoPlay: announcements.length > 1,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
              final n = announcements.length;
              onPageChanged(((index % n) + n) % n);
            },
              scrollDirection: Axis.horizontal,
            ),
          ),
          if (announcements.length > 1) ...[
            12.verticalSpace,
            _CarouselIndicators(
              count: announcements.length,
              currentPage: currentPage,
            ),
          ],
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  const _AnnouncementCard({required this.announcement});

  final Map<String, String?> announcement;

  void _openDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AnnouncementDetailSheet(announcement: announcement),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = announcement['title'] ?? '';
    final body = announcement['body'] ?? '';
    final btnText = announcement['btn_text'] ?? '';
    final bgImage = announcement['background_image'];
    final hasImage = bgImage != null && bgImage.isNotEmpty;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background: SVG or network image
            if (hasImage)
              Image.network(
                bgImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => SvgPicture.asset(
                  AssetsPath.announcementcardbg ,
                  fit: BoxFit.cover,
                ),
              )
            else
              SvgPicture.asset(
                AssetsPath.announcementcardbg,
                fit: BoxFit.cover,
              ),

            // Image-only mode: just a button anchored to the bottom-left
            if (hasImage)
              Positioned(
                left: 20.w,
                bottom: 20.h,
                child: ElevatedButton(
                  onPressed: () => _openDetail(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF4F46E5),
                    padding: EdgeInsets.symmetric(
                        horizontal: 24.w, vertical: 5.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    btnText.isNotEmpty ? btnText : 'View Details',
                    style: textStyle_14MediumGreyHintStyle().copyWith(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
            // Text + button mode
            else
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: textStyle_18MediumBlack().copyWith(
                              color: Colors.white,
                              height: 1.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          8.verticalSpace,
                          Text(
                            body,
                            style: textStyle_14MediumGreyHintStyle().copyWith(
                              color: Colors.white,
                              height: 1.2,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    8.verticalSpace,
                    if (btnText.isNotEmpty)
                      ElevatedButton(
                        onPressed: () => _openDetail(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF4F46E5),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 5.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          btnText,
                          style: textStyle_14MediumGreyHintStyle().copyWith(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
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

class _AnnouncementDetailSheet extends StatelessWidget {
  const _AnnouncementDetailSheet({required this.announcement});

  final Map<String, String?> announcement;

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = announcement['title'] ?? '';
    final body = announcement['body'] ?? '';
    final btnText = announcement['btn_text'] ?? '';
    final btnUrl = announcement['btn_url'] ?? '';
    final bgImage = announcement['background_image'];
    final hasImage = bgImage != null && bgImage.isNotEmpty;
    final hasUrl = btnUrl.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner image with drag handle overlaid on top
          Stack(
            children: [
              // Full-width banner clipped to match the sheet's top corners
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                  child: hasImage
                      ? Image.network(
                          bgImage,
                          height: 120.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => SvgPicture.asset(
                            AssetsPath.announcementcardbg,
                            height: 120.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        )
                      : SvgPicture.asset(
                          AssetsPath.announcementcardbg,
                          height: 120.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              // Drag handle overlaid at the top-center of the banner
              Positioned(
                top: 12.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textStyle_18MediumBlack().copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    height: 1.3,
                  ),
                ),
                const Divider(),
                12.verticalSpace,
                Text(
                  body,
                  style: textStyle_14MediumGreyHintStyle().copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                ),
                if (hasUrl) ...[
                  20.verticalSpace,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _launchUrl(btnUrl),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4F46E5),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        btnText.isNotEmpty ? btnText : 'Open Link',
                        style: textStyle_14MediumGreyHintStyle().copyWith(
                          fontSize: 15.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 24.h + MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CarouselIndicators extends StatelessWidget {
  const _CarouselIndicators({
    required this.count,
    required this.currentPage,
  });

  final int count;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          width: isActive ? 24.w : 8.w,
          height: 8.h,
          decoration: BoxDecoration(
            color: isActive
                ? const Color(0xFF111827)
                : const Color(0xFF111827).withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
