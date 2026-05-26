import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/application/community_provider.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/presentation/widgets/community_project_card.dart';
import 'package:flutter_knp_mobile_app_v2/shared/v2/fk_header.dart';
import 'package:flutter_knp_mobile_app_v2/shared/v2/fk_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityProjectsScreen extends ConsumerWidget {
  const CommunityProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(communityDashboardProvider).projects;

    return FkScreen(
      children: [
        const FkHeader(
          title: 'Projects',
          subtitle: 'Contribution projects, members, tech stack, and status.',
        ),
        const SizedBox(height: 18),
        for (final project in projects) CommunityProjectCard(project: project),
      ],
    );
  }
}
