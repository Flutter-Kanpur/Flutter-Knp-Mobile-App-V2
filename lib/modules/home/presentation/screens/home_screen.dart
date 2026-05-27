import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/gradiant_background.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/search_bar.dart';
import 'package:flutter_knp_mobile_app_v2/modules/home/presentation/widgets/home_app_bar_v2.dart';
import 'package:flutter_knp_mobile_app_v2/modules/home/presentation/widgets/home_announcement_carousel_v2.dart';
import 'package:flutter_knp_mobile_app_v2/modules/home/presentation/widgets/home_filter_tabs_v2.dart';
import 'package:flutter_knp_mobile_app_v2/modules/home/presentation/widgets/event_card_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenV2 extends StatefulWidget {
  const HomeScreenV2({super.key});

  @override
  State<HomeScreenV2> createState() => _HomeScreenV2State();
}

class _HomeScreenV2State extends State<HomeScreenV2> {
  late int _currentAnnouncementPage = 0;
  late int _selectedFilterIndex = 1;
  late int _selectedFiltersCount = 0;

  final List<Map<String, String?>> _announcements = [
    {
      'title': 'Design Challenge 2026',
      'body':
          'Join us for an exciting design challenge! Create Stunning UI/UX design and win amazing prize!',
      'btn_text': 'View Details',
      'btn_url': '',
      'background_image': null,
    },
    {
      'title': 'Flutter Workshop',
      'body':
          'Learn advanced Flutter patterns and best practices from industry experts.',
      'btn_text': 'Register Now',
      'btn_url': '',
      'background_image': null,
    },
    {
      'title': 'Hackathon 2026',
      'body':
          'Build innovative solutions and compete with other developers for exciting prizes.',
      'btn_text': 'Sign Up',
      'btn_url': '',
      'background_image': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
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
                  hintText: 'Search Events',
                  onTap: () {
                    // Handle search navigation
                  },
                ),
                HomeAnnouncementCarouselV2(
                  announcements: _announcements,
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
                      const SnackBar(
                        content: Text('Filters bottom sheet will open here'),
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
                        "What's new",
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
                              "See all",
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
                        svgIconPath: 'assets/launch_event.svg',
                        status: 'Upcoming',
                        statusColor: const Color(0xFF10B981),
                        organization: 'Flutter Kanpur',
                        title: 'Launch Event',
                        description:
                            'Join us on an insightful session with industry speakers discussing new trends and practices in tech ecosystem.',
                        dateTime: 'Sun, 7 Apr • 4:00 PM • Kanpur',
                        buttonText: 'Join live  ->',
                        onButtonPressed: () {},
                        showEyeIcon: true,
                        onEyeIconPressed: () {},
                      ),
                      16.verticalSpace,
                      // Second Event Card
                      EventCardComponent(
                        svgIconPath: 'assets/flutter_kanpur_card.svg',
                        status: 'Upcoming',
                        statusColor: const Color(0xFF10B981),
                        organization: 'Flutter Kanpur',
                        title: 'From Figma to Flutter: Practical Workflow',
                        description:
                            'This session focuses on building the Flutter applications that scale in real-world scenario...see more',
                        dateTime: 'Sun, 7 Apr • 4:00 PM • Kanpur',
                        buttonText: 'Join live  ->',
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
      ),
    );
  }
}
