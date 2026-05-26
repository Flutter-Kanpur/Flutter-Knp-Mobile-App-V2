import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/utils/assets_path.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/application/community_provider.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/presentation/widgets/community_post_card.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_card.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_header.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_screen.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_section_title.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_status_chip.dart';
import 'package:flutter_knp_mobile_app_v2/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        GestureDetector(
          onTap: () => context.go('/community/qna'),
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: SvgPicture.asset(
              AssetsPath.communityTopContainer,
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const FkSectionTitle(title: 'Flutter Kanpur Stats'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.communityGuidelinesContainerBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(label: 'Members', value: '${community.memberCount}'),
              _StatItem(label: 'Posts', value: '${community.postCount}'),
              _StatItem(
                label: 'Projects',
                value: '${community.activeProjectCount}',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const FkSectionTitle(title: 'Contribute to Flutter Kanpur'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _ContributeCard(
                label: 'Open to all',
                title: 'Upload Projects',
                body:
                    'Share useful projects, app ideas, templates, and learning resources with the community.',
                onTap: () => context.go('/community/projects'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  _ContributeCard(
                    label: 'Write for us',
                    body: 'Publish Flutter, Dart, UI, and backend learnings.',
                    onTap: () => context.go('/blogs'),
                    compact: true,
                  ),
                  const SizedBox(height: 12),
                  _ContributeCard(
                    label: 'Get involved',
                    body: 'Join as contributor after auth/profile is ready.',
                    onTap: () => context.go('/profile'),
                    compact: true,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const FkSectionTitle(title: 'Community Workspace'),
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
        const SizedBox(height: 20),
        Text(
          'Built for builders',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: AppColors.lightGrayText,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 10),
        const Text('Crafted by Flutter Kanpur community.'),
      ],
    );
  }
}

class _ContributeCard extends StatelessWidget {
  const _ContributeCard({
    required this.label,
    required this.body,
    required this.onTap,
    this.title,
    this.compact = false,
  });

  final String label;
  final String? title;
  final String body;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return FkCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: SizedBox(
        height: compact ? 88 : 204,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.selectedNavBarIconColor,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (title != null) ...[
              const SizedBox(height: 12),
              Text(
                title!,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
            const SizedBox(height: 10),
            Expanded(
              child: Text(
                body,
                maxLines: compact ? 2 : 5,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.subtitleTextDarkGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FittedBox(
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.subtitleTextDarkGrey,
            ),
          ),
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
