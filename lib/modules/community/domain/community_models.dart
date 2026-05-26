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
    required this.title,
    required this.tag,
    required this.answerCount,
    required this.status,
  });

  final String title;
  final String tag;
  final int answerCount;
  final String status;
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
  int get activeProjectCount =>
      projects.where((project) => project.status == 'Active').length;
}
