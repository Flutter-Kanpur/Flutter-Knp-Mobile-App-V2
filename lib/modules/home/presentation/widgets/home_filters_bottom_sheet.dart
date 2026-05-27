import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/app/theme/app_colors.dart';
import 'package:flutter_knp_mobile_app_v2/app/theme/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_kanpur_ui_kit/flutter_kanpur_ui_kit.dart';

class HomeFiltersBottomSheet extends StatefulWidget {
  const HomeFiltersBottomSheet({
    super.key,
    required this.selectedStatusFilter,
    required this.selectedModeFilter,
    required this.selectedTimeFilter,
    required this.selectedAccessFilter,
    required this.selectedInterestFilters,
    required this.onStatusChanged,
    required this.onModeChanged,
    required this.onTimeChanged,
    required this.onAccessChanged,
    required this.onInterestToggled,
  });

  final String? selectedStatusFilter;
  final String? selectedModeFilter;
  final String? selectedTimeFilter;
  final String? selectedAccessFilter;
  final Set<String> selectedInterestFilters;
  final ValueChanged<String?> onStatusChanged;
  final ValueChanged<String?> onModeChanged;
  final ValueChanged<String?> onTimeChanged;
  final ValueChanged<String?> onAccessChanged;
  final ValueChanged<String> onInterestToggled;

  static void show(
    BuildContext context, {
    required String? selectedStatusFilter,
    required String? selectedModeFilter,
    required String? selectedTimeFilter,
    required String? selectedAccessFilter,
    required Set<String> selectedInterestFilters,
    required ValueChanged<String?> onStatusChanged,
    required ValueChanged<String?> onModeChanged,
    required ValueChanged<String?> onTimeChanged,
    required ValueChanged<String?> onAccessChanged,
    required ValueChanged<String> onInterestToggled,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => HomeFiltersBottomSheet(
        selectedStatusFilter: selectedStatusFilter,
        selectedModeFilter: selectedModeFilter,
        selectedTimeFilter: selectedTimeFilter,
        selectedAccessFilter: selectedAccessFilter,
        selectedInterestFilters: Set<String>.from(selectedInterestFilters),
        onStatusChanged: onStatusChanged,
        onModeChanged: onModeChanged,
        onTimeChanged: onTimeChanged,
        onAccessChanged: onAccessChanged,
        onInterestToggled: onInterestToggled,
      ),
    );
  }

  @override
  State<HomeFiltersBottomSheet> createState() => _HomeFiltersBottomSheetState();
}

class _HomeFiltersBottomSheetState extends State<HomeFiltersBottomSheet> {
  late String? _selectedStatusFilter;
  late String? _selectedModeFilter;
  late String? _selectedTimeFilter;
  late String? _selectedAccessFilter;
  late Set<String> _selectedInterestFilters;

  @override
  void initState() {
    super.initState();
    _selectedStatusFilter = widget.selectedStatusFilter;
    _selectedModeFilter = widget.selectedModeFilter;
    _selectedTimeFilter = widget.selectedTimeFilter;
    _selectedAccessFilter = widget.selectedAccessFilter;
    _selectedInterestFilters = Set<String>.from(widget.selectedInterestFilters);
  }

  void _onStatus(String? v) {
    setState(() => _selectedStatusFilter = v);
    widget.onStatusChanged(v);
  }

  void _onMode(String? v) {
    setState(() => _selectedModeFilter = v);
    widget.onModeChanged(v);
  }

  void _onTime(String? v) {
    setState(() => _selectedTimeFilter = v);
    widget.onTimeChanged(v);
  }

  void _onAccess(String? v) {
    setState(() => _selectedAccessFilter = v);
    widget.onAccessChanged(v);
  }

  void _onInterest(String v) {
    setState(() {
      if (_selectedInterestFilters.contains(v)) {
        _selectedInterestFilters.remove(v);
      } else {
        _selectedInterestFilters.add(v);
      }
    });
    widget.onInterestToggled(v);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.communityBorderColor,
                ),
                alignment: Alignment.center,
                height: 5.h,
                width: 100.w,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filters', style: textStyle_16MediumBlack()),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Icon(
                      Icons.cancel,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FilterSection(
                    title: 'Status-based',
                    options: const ['Flutter', 'Live', 'Today', 'Past'],
                    selectedValue: _selectedStatusFilter,
                    onSelected: _onStatus,
                  ),
                  20.verticalSpace,
                  _FilterSection(
                    title: 'Mode / Format',
                    options: const ['Online', 'Offline'],
                    selectedValue: _selectedModeFilter,
                    onSelected: _onMode,
                  ),
                  20.verticalSpace,
                  _FilterSection(
                    title: 'Time-based',
                    options: const ['This Week', 'This Month'],
                    selectedValue: _selectedTimeFilter,
                    onSelected: _onTime,
                  ),
                  20.verticalSpace,
                  _FilterSection(
                    title: 'Access',
                    options: const ['Free', 'Open to All'],
                    selectedValue: _selectedAccessFilter,
                    onSelected: _onAccess,
                  ),
                  20.verticalSpace,
                  _MultiSelectFilterSection(
                    title: 'Interest / Type',
                    options: const [
                      'Flutter',
                      'UI / UX',
                      'Advanced',
                      'Beginner Friendly',
                      'Design',
                    ],
                    selectedValues: _selectedInterestFilters,
                    onToggle: _onInterest,
                  ),
                  40.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
  });

  final String title;
  final List<String> options;
  final String? selectedValue;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textStyle_16MediumBlack()),
        12.verticalSpace,
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: options.map((option) {
            final isSelected = selectedValue == option;
            return GestureDetector(
              onTap: () => onSelected(option),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFE0E7FF)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4F46E5)
                        : const Color(0xFFE5E7EB),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  option,
                  style: textStyle_14MediumGreyHintStyle().copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? const Color(0xFF4F46E5)
                        : const Color(0xFF111827),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _MultiSelectFilterSection extends StatelessWidget {
  const _MultiSelectFilterSection({
    required this.title,
    required this.options,
    required this.selectedValues,
    required this.onToggle,
  });

  final String title;
  final List<String> options;
  final Set<String> selectedValues;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: textStyle_16MediumBlack()),
        12.verticalSpace,
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: options.map((option) {
            final isSelected = selectedValues.contains(option);
            return GestureDetector(
              onTap: () => onToggle(option),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFE0E7FF)
                      : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4F46E5)
                        : const Color(0xFFE5E7EB),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Text(
                  option,
                  style: textStyle_14MediumGreyHintStyle().copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? const Color(0xFF4F46E5)
                        : const Color(0xFF111827),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
