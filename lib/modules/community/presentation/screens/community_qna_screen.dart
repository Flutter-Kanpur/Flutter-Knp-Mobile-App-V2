import 'package:flutter/material.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/application/community_provider.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_back_button.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_card.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_header.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_screen.dart';
import 'package:flutter_knp_mobile_app_v2/common_widgets/fk_status_chip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunityQnaScreen extends ConsumerWidget {
  const CommunityQnaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(communityDashboardProvider).questions;

    return FkScreen(
      children: [
        const FkHeader(
          title: 'QnA',
          subtitle:
              'Questions, answers, accepted answer, tags, and moderation.',
          leading: FkBackButton(),
        ),
        const SizedBox(height: 18),
        for (final question in questions)
          FkCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        question.title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    FkStatusChip(label: question.status),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    FkStatusChip(label: '#${question.tag}'),
                    FkStatusChip(label: '${question.answerCount} answers'),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
