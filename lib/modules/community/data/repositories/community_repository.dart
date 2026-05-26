import 'package:flutter_knp_mobile_app_v2/modules/community/domain/community_models.dart';

class CommunityRepository {
  const CommunityRepository();

  Future<void> submitProject(CommunityProjectSubmission submission) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
  }

  Future<void> submitQuestion(CommunityQuestionDraft draft) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
  }
}
