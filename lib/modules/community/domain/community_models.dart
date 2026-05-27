enum CommunityPostType { announcement, discussion, question, project }

class CommunityPost {
  const CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorRole,
    required this.title,
    required this.body,
    required this.type,
    required this.tags,
    required this.replyCount,
    required this.likeCount,
    required this.createdLabel,
  });

  final String id;
  final String authorName;
  final String authorRole;
  final String title;
  final String body;
  final CommunityPostType type;
  final List<String> tags;
  final int replyCount;
  final int likeCount;
  final String createdLabel;
}

class CommunityMember {
  const CommunityMember({
    required this.name,
    required this.role,
    required this.skills,
    required this.status,
  });

  final String name;
  final String role;
  final List<String> skills;
  final String status;
}

class CommunityProject {
  const CommunityProject({
    required this.title,
    required this.summary,
    required this.status,
    required this.techStack,
  });

  final String title;
  final String summary;
  final String status;
  final List<String> techStack;
}

class CommunityQuestion {
  const CommunityQuestion({
    required this.id,
    required this.title,
    required this.body,
    required this.tag,
    required this.answerCount,
    required this.status,
    required this.authorName,
    required this.createdLabel,
  });

  final String id;
  final String title;
  final String body;
  final String tag;
  final int answerCount;
  final String status;
  final String authorName;
  final String createdLabel;
}

class CommunityReply {
  const CommunityReply({
    required this.authorName,
    required this.createdLabel,
    required this.body,
    required this.likeCount,
    required this.replyCount,
  });

  final String authorName;
  final String createdLabel;
  final String body;
  final int likeCount;
  final int replyCount;
}

class CommunityProjectSubmission {
  const CommunityProjectSubmission({
    required this.name,
    required this.description,
    required this.techStack,
    required this.links,
  });

  final String name;
  final String description;
  final List<String> techStack;
  final List<String> links;
}

class CommunityQuestionDraft {
  const CommunityQuestionDraft({
    required this.title,
    required this.details,
    required this.category,
    required this.tags,
  });

  final String title;
  final String details;
  final String category;
  final List<String> tags;
}

class CommunityDashboardState {
  const CommunityDashboardState({
    required this.posts,
    required this.members,
    required this.projects,
    required this.questions,
  });

  final List<CommunityPost> posts;
  final List<CommunityMember> members;
  final List<CommunityProject> projects;
  final List<CommunityQuestion> questions;

  int get memberCount => members.length;
  int get postCount => posts.length;
  int get contributionCount => projects.length + posts.length;
  int get eventsHostedCount => 25;
  int get activeProjectCount =>
      projects.where((project) => project.status == 'Active').length;
}
