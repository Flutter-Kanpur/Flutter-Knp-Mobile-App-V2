import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/data/repositories/community_repository.dart';
import 'package:flutter_knp_mobile_app_v2/modules/community/domain/community_models.dart';

final communityRepositoryProvider = Provider<CommunityRepository>((ref) {
  return const CommunityRepository();
});

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
        id: 'state-management',
        title: 'How do we cache home feed sections?',
        body:
            'I am building a medium-scale Flutter app and deciding how to cache home sections without overcomplicating the state layer.',
        tag: 'performance',
        answerCount: 2,
        status: 'Open',
        authorName: 'Angelica Singh',
        createdLabel: '6h ago',
      ),
      CommunityQuestion(
        id: 'tags-model',
        title: 'Should QnA and feed share tags?',
        body:
            'Should blogs, QnA, resources, and posts use one normalized tags system or separate tables?',
        tag: 'database',
        answerCount: 1,
        status: 'Open',
        authorName: 'John doe',
        createdLabel: 'Feb 21, 2026',
      ),
    ],
  );
});

final communityRepliesProvider = Provider<List<CommunityReply>>((ref) {
  return const [
    CommunityReply(
      authorName: 'Angelica Singh',
      createdLabel: '2h ago',
      body:
          'AI is taking the joy out of doing simple tasks, killing the planet in the process and we are the ones to blame for it. We project such an image of these tools like an image/video generation tool is going to give me a better quality of life.',
      likeCount: 45,
      replyCount: 7,
    ),
    CommunityReply(
      authorName: 'John doe',
      createdLabel: 'Feb 21, 2026',
      body:
          "Interesting take on the design process. Mockups are a reflection of thinking through a design brief. That's investing time, not wasting it.",
      likeCount: 14500,
      replyCount: 7,
    ),
    CommunityReply(
      authorName: 'John doe',
      createdLabel: 'Feb 21, 2026',
      body:
          "Interesting take on the design process. Mockups are a reflection of thinking through a design brief. That's investing time, not wasting it.",
      likeCount: 14500,
      replyCount: 7,
    ),
  ];
});

class CommunityActionController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<bool> submitQuestion(CommunityQuestionDraft draft) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).submitQuestion(draft),
    );
    return !state.hasError;
  }

  Future<bool> submitProject(CommunityProjectSubmission submission) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(communityRepositoryProvider).submitProject(submission),
    );
    return !state.hasError;
  }
}

final communityActionControllerProvider =
    AsyncNotifierProvider<CommunityActionController, void>(
      CommunityActionController.new,
    );
