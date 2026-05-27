import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/gradiant_background.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/search_bar.dart';
import 'package:flutter_knp_mobile_app_v2/modules/home/presentation/widgets/home_app_bar_v2.dart';
import 'package:flutter_knp_mobile_app_v2/modules/home/presentation/widgets/home_announcement_carousel_v2.dart';
import 'package:flutter_knp_mobile_app_v2/modules/home/presentation/widgets/home_filter_tabs_v2.dart';
import 'package:flutter_knp_mobile_app_v2/modules/home/presentation/widgets/event_card_component.dart';
import 'package:flutter_knp_mobile_app_v2/utils/assets_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreenV2 extends StatefulWidget {
  const HomeScreenV2({super.key});

  @override
  State<HomeScreenV2> createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> {
  late int _currentAnnouncementPage = 0;
  late int _selectedFilterIndex = 1;
  late int _selectedFiltersCount = 0;

  @override
  Widget build(BuildContext context) {
    final announcements = [
      {
        'title': 'home.announcements.first.title'.tr(),
        'body': 'home.announcements.first.body'.tr(),
        'btn_text': 'home.announcements.first.button'.tr(),
        'btn_url': '',
        'background_image': null,
      },
      {
        'title': 'home.announcements.second.title'.tr(),
        'body': 'home.announcements.second.body'.tr(),
        'btn_text': 'home.announcements.second.button'.tr(),
        'btn_url': '',
        'background_image': null,
      },
      {
        'title': 'home.announcements.third.title'.tr(),
        'body': 'home.announcements.third.body'.tr(),
        'btn_text': 'home.announcements.third.button'.tr(),
        'btn_url': '',
        'background_image': null,
      },
    ];

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBarV2(),
                CommonSearchBar(
                  readOnly: true,
                  hintText: 'home.searchHint'.tr(),
                  onTap: () {
                    // Handle search navigation
                  },
                ),
                HomeAnnouncementCarouselV2(
                  announcements: announcements,
                  currentPage: _currentAnnouncementPage,
                  onPageChanged: (page) {
                    setState(() {
                      _currentAnnouncementPage = page;
                    });
                  },
                ),

                HomeFilterTabsV2(
                  selectedFilterIndex: _selectedFilterIndex,
                  onFilterSelected: (index) {
                    setState(() {
                      _selectedFilterIndex = index;
                    });
                  },
                  onFiltersTap: () {
                    // Handle filters bottom sheet
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'home.filtersBottomSheetPlaceholder'.tr(),
                        ),
                      ),
                    );
                  },
                  selectedFiltersCount: _selectedFiltersCount,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'home.whatsNew'.tr(),
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle see all navigation
                        },
                        child: Row(
                          children: [
                            Text(
                              'home.seeAll'.tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Icon(
                              Icons.chevron_right,
                              size: 20.sp,
                              color: Colors.grey[600],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      // First Event Card
                      EventCardComponent(
                        assetPath: AssetsPath.launcheventpng,
                        status: 'home.events.upcoming'.tr(),
                        statusColor: const Color(0xFF10B981),
                        organization: 'home.events.organization'.tr(),
                        title: 'home.events.first.title'.tr(),
                        description: 'home.events.first.description'.tr(),
                        dateTime: 'home.events.first.dateTime'.tr(),
                        buttonText: 'home.events.button'.tr(),
                        onButtonPressed: () {},
                        showEyeIcon: true,
                        onEyeIconPressed: () {},
                      ),
                      16.verticalSpace,
                      // Second Event Card
                      EventCardComponent(
                        assetPath: AssetsPath.fkcard,
                        status: 'home.events.upcoming'.tr(),
                        statusColor: const Color(0xFF10B981),
                        organization: 'home.events.organization'.tr(),
                        title: 'home.events.second.title'.tr(),
                        description: 'home.events.second.description'.tr(),
                        dateTime: 'home.events.second.dateTime'.tr(),
                        buttonText: 'home.events.button'.tr(),
                        onButtonPressed: () {},
                        showEyeIcon: true,
                        onEyeIconPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        bottomNavigationBar: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 7.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Optional top divider/padding
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavItem(
                      assetPath: AssetsPath.home,
                      label: 'home.bottomNav.home'.tr(),
                      active: true,
                      onTap: () {},
                    ),
                    _NavItem(
                      assetPath: AssetsPath.community,
                      label: 'home.bottomNav.community'.tr(),
                      active: false,
                      onTap: () {
                        //navigate to community_screen
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => CommunityScreen()));
                      },
                    ),
                    _NavItem(
                      assetPath: AssetsPath.explore,
                      label: 'home.bottomNav.explore'.tr(),
                      active: false,
                      onTap: () {},
                    ),
                    _NavItem(
                      assetPath: AssetsPath.profile,
                      label: 'home.bottomNav.profile'.tr(),
                      active: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.assetPath,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String assetPath;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? const Color(0xFF2563EB) : Colors.grey[500];
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            assetPath,
            width: 24.sp,
            height: 24.sp,
            fit: BoxFit.contain,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
