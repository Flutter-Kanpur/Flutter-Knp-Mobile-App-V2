import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/utils/colors.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Flutter Kanpur',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Developer ecosystem workspace',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.subtitleTextDarkGrey,
            ),
          ),
          const SizedBox(height: 24),
          _FeatureTile(
            title: 'Community Feed',
            subtitle: 'Start building posts, discussions, members, and roles.',
            icon: Icons.groups_rounded,
            onTap: () => context.go('/community'),
          ),
          _FeatureTile(
            title: 'Events',
            subtitle: 'Meetups, workshops, registration, tickets, QR check-in.',
            icon: Icons.event_rounded,
            onTap: () => context.go('/events'),
          ),
          _FeatureTile(
            title: 'Blogs',
            subtitle: 'Integrated blog module connected with shared profiles.',
            icon: Icons.article_rounded,
            onTap: () => context.go('/blogs'),
          ),
          _FeatureTile(
            title: 'Profile',
            subtitle: 'Temporary guest profile until auth flow is connected.',
            icon: Icons.person_rounded,
            onTap: () => context.go('/profile'),
          ),
        ],
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
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
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.borderSecondary),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
