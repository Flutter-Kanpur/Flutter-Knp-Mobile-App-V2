import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/application/community_provider.dart';
import 'package:flutter_knp_mobile_app_v2/shared/widgets/fk_card.dart';
import 'package:flutter_knp_mobile_app_v2/shared/widgets/fk_header.dart';
import 'package:flutter_knp_mobile_app_v2/shared/widgets/fk_screen.dart';
import 'package:flutter_knp_mobile_app_v2/shared/widgets/fk_section_title.dart';
import 'package:flutter_knp_mobile_app_v2/shared/widgets/fk_status_chip.dart';
import 'package:flutter_knp_mobile_app_v2/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final community = ref.watch(communityDashboardProvider);

    return FkScreen(
      children: [
        FkHeader(
          title: 'Flutter Kanpur',
          subtitle:
              'Guest workspace is open while auth is under implementation.',
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded),
          ),
        ),
        const SizedBox(height: 18),
        FkCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FkStatusChip(
                label: 'Development mode',
                icon: Icons.lock_open_rounded,
              ),
              const SizedBox(height: 12),
              Text(
                'Start community pages now',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 8),
              const Text(
                'Auth, profile restore, and Supabase writes can be connected later. UI/state flow is ready for feature work.',
              ),
            ],
          ),
        ),
        FkSectionTitle(
          title: 'Ecosystem Modules',
          actionLabel: 'Community',
          onActionTap: () => context.go('/community'),
        ),
        _ModuleTile(
          title: 'Community',
          subtitle:
              '${community.memberCount} members - ${community.postCount} feed items',
          icon: Icons.groups_rounded,
          onTap: () => context.go('/community'),
        ),
        _ModuleTile(
          title: 'Events',
          subtitle: 'Meetups, workshops, tickets, QR check-in',
          icon: Icons.event_rounded,
          onTap: () => context.go('/events'),
        ),
        _ModuleTile(
          title: 'Blogs',
          subtitle: 'Modular blog platform integration',
          icon: Icons.article_rounded,
          onTap: () => context.go('/blogs'),
        ),
        _ModuleTile(
          title: 'Profile',
          subtitle: 'Default guest profile until auth is connected',
          icon: Icons.person_rounded,
          onTap: () => context.go('/profile'),
        ),
      ],
    );
  }
}

class _ModuleTile extends StatelessWidget {
  const _ModuleTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FkCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}
