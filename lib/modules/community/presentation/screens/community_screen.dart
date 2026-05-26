import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/application/community_provider.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/presentation/widgets/community_post_card.dart';
import 'package:flutter_knp_mobile_app_v2/shared/v2/fk_card.dart';
import 'package:flutter_knp_mobile_app_v2/shared/v2/fk_header.dart';
import 'package:flutter_knp_mobile_app_v2/shared/v2/fk_screen.dart';
import 'package:flutter_knp_mobile_app_v2/shared/v2/fk_section_title.dart';
import 'package:flutter_knp_mobile_app_v2/shared/v2/fk_status_chip.dart';
import 'package:flutter_knp_mobile_app_v2/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final community = ref.watch(communityDashboardProvider);

    return FkScreen(
      children: [
        FkHeader(
          title: 'Community',
          subtitle:
              'Build feed, members, QnA, projects, roles, and contribution flows.',
          trailing: IconButton.filled(
            onPressed: () {},
            icon: const Icon(Icons.add_rounded),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                label: 'Members',
                value: '${community.memberCount}',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatCard(label: 'Posts', value: '${community.postCount}'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                label: 'Projects',
                value: '${community.activeProjectCount}',
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.38,
          children: [
            _ModuleEntry(
              title: 'Feed',
              icon: Icons.dynamic_feed_rounded,
              onTap: () => context.go('/community/feed'),
            ),
            _ModuleEntry(
              title: 'Members',
              icon: Icons.groups_rounded,
              onTap: () => context.go('/community/members'),
            ),
            _ModuleEntry(
              title: 'QnA',
              icon: Icons.help_rounded,
              onTap: () => context.go('/community/qna'),
            ),
            _ModuleEntry(
              title: 'Projects',
              icon: Icons.handyman_rounded,
              onTap: () => context.go('/community/projects'),
            ),
          ],
        ),
        FkSectionTitle(
          title: 'Latest Feed',
          actionLabel: 'View all',
          onActionTap: () => context.go('/community/feed'),
        ),
        for (final post in community.posts.take(2))
          CommunityPostCard(post: post),
        FkCard(
          onTap: () => context.go('/community/guidelines'),
          child: const Row(
            children: [
              Icon(Icons.verified_user_rounded, color: AppColors.primary),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Community guidelines, moderation, and default guest mode.',
                ),
              ),
              Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return FkCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

class _ModuleEntry extends StatelessWidget {
  const _ModuleEntry({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FkCard(
      onTap: onTap,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: AppColors.primary),
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const FkStatusChip(label: 'Open'),
            ],
          ),
        ],
      ),
    );
  }
}
