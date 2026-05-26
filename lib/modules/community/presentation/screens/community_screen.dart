import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/utils/colors.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Community',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Build feed, members, roles, QnA, and contribution flows here.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.subtitleTextDarkGrey,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Icons.add_rounded),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _CommunityStats(),
          const SizedBox(height: 20),
          Text(
            'Module Backlog',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          const _ModuleTask(
            title: 'Community Feed',
            body:
                'Posts, announcements, pinned content, pagination, cached feed.',
            status: 'UI Ready',
          ),
          const _ModuleTask(
            title: 'Members Directory',
            body: 'Profiles, skills, role badges, search, filters.',
            status: 'Next',
          ),
          const _ModuleTask(
            title: 'QnA',
            body: 'Questions, answers, accepted answer, tags, moderation.',
            status: 'Planned',
          ),
          const _ModuleTask(
            title: 'Contribution System',
            body: 'Projects, project members, tech stack, contribution status.',
            status: 'Planned',
          ),
        ],
      ),
    );
  }
}

class _CommunityStats extends StatelessWidget {
  const _CommunityStats();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _StatCard(label: 'Members', value: '0'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StatCard(label: 'Posts', value: '0'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StatCard(label: 'Projects', value: '0'),
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
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(label),
        ],
      ),
    );
  }
}

class _ModuleTask extends StatelessWidget {
  const _ModuleTask({
    required this.title,
    required this.body,
    required this.status,
  });

  final String title;
  final String body;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.borderSecondary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Chip(label: Text(status)),
              ],
            ),
            const SizedBox(height: 8),
            Text(body),
          ],
        ),
      ),
    );
  }
}
