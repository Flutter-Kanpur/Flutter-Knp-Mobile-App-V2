import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/domain/community_models.dart';

final communityDashboardProvider = Provider<CommunityDashboardState>((ref) {
  return const CommunityDashboardState(
    posts: [
      CommunityPost(
        id: 'welcome-thread',
        authorName: 'Flutter Kanpur Team',
        authorRole: 'Core Team',
        title: 'Welcome to the community workspace',
        body:
            'Auth is bypassed for now. Use this area to build the feed, member discovery, QnA, and contribution flows.',
        type: CommunityPostType.announcement,
        tags: ['announcement', 'setup'],
        replyCount: 4,
        likeCount: 18,
        createdLabel: 'Today',
      ),
      CommunityPost(
        id: 'riverpod-architecture',
        authorName: 'Aman Verma',
        authorRole: 'Mobile Contributor',
        title: 'Riverpod feature state structure',
        body:
            'Each module should own providers, repositories, and UI state. Shared logic stays in core or shared.',
        type: CommunityPostType.discussion,
        tags: ['riverpod', 'architecture'],
        replyCount: 7,
        likeCount: 23,
        createdLabel: '2h ago',
      ),
      CommunityPost(
        id: 'supabase-qna',
        authorName: 'Priya Singh',
        authorRole: 'Backend Contributor',
        title: 'How should community posts map to Supabase?',
        body:
            'We can start with questions, answers, projects, and community_memberships, then add a dedicated posts table if feed grows.',
        type: CommunityPostType.question,
        tags: ['supabase', 'qna'],
        replyCount: 3,
        likeCount: 11,
        createdLabel: 'Yesterday',
      ),
    ],
    members: [
      CommunityMember(
        name: 'Flutter Kanpur Team',
        role: 'Core Team',
        skills: ['Flutter', 'Community', 'Events'],
        status: 'Active',
      ),
      CommunityMember(
        name: 'Aman Verma',
        role: 'Mobile Contributor',
        skills: ['Riverpod', 'UI', 'Supabase'],
        status: 'Active',
      ),
      CommunityMember(
        name: 'Priya Singh',
        role: 'Backend Contributor',
        skills: ['PostgreSQL', 'RLS', 'APIs'],
        status: 'Active',
      ),
    ],
    projects: [
      CommunityProject(
        title: 'Flutter Kanpur Mobile App V2',
        summary:
            'Feature-first app shell, community module, and Supabase flow.',
        status: 'Active',
        techStack: ['Flutter', 'Riverpod', 'Supabase'],
      ),
      CommunityProject(
        title: 'Community Blog Integration',
        summary: 'Shared profile identity with modular blog feed and editor.',
        status: 'Planned',
        techStack: ['Flutter Web', 'PostgreSQL'],
      ),
    ],
    questions: [
      CommunityQuestion(
        title: 'How do we cache home feed sections?',
        tag: 'performance',
        answerCount: 2,
        status: 'Open',
      ),
      CommunityQuestion(
        title: 'Should QnA and feed share tags?',
        tag: 'database',
        answerCount: 1,
        status: 'Open',
      ),
    ],
  );
});
