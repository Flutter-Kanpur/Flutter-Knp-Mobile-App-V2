import 'package:flutter_knp_mobile_app_v2/modules/community/domain/community_models.dart';
import 'package:flutter_knp_mobile_app_v2/core/database/database_tables.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommunityRepository {
  CommunityRepository({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Future<void> submitProject(CommunityProjectSubmission submission) async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      return;
    }

    await _client.from(DatabaseTables.projects).insert({
      'slug': _slugFrom(submission.name),
      'title': submission.name,
      'summary': submission.description,
      'description': submission.description,
      'status': 'pending_review',
      'owner_uid': userId,
      'github_url': submission.links.isEmpty ? null : submission.links.first,
      'created_by': userId,
      'updated_by': userId,
    });
  }

  Future<void> submitQuestion(CommunityQuestionDraft draft) async {
    final userId = _client.auth.currentUser?.id;

    if (userId == null) {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      return;
    }

    await _client.from(DatabaseTables.questions).insert({
      'title': draft.title,
      'body': draft.details,
      'author_uid': userId,
      'status': 'open',
    });
  }

  String _slugFrom(String value) {
    final slug = value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    return slug.isEmpty ? 'community-project' : slug;
  }
}
