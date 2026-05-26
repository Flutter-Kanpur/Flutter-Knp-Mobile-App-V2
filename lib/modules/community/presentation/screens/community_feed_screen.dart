import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/application/community_provider.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/presentation/widgets/community_post_card.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_back_button.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_header.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CommunityFeedScreen extends ConsumerWidget {
  const CommunityFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(communityDashboardProvider).posts;

    return FkScreen(
      children: [
        const FkHeader(
          title: 'Community Feed',
          subtitle:
              'Announcements, discussions, QnA prompts, and project updates.',
          leading: FkBackButton(),
        ),
        const SizedBox(height: 18),
        for (final post in posts)
          CommunityPostCard(
            post: post,
            onTap: () => context.go('/community/discussion'),
          ),
      ],
    );
  }
}
