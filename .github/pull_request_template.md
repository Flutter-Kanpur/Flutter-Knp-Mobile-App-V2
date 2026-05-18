### Checklist for Flutter PR:

#### 🔄 **Git & Branch Management**
- [ ] **Branch Naming**: Follows convention (`feature/FKP-123-description`, `bugfix/FKP-456-fix`)
- [ ] **Commit Messages**: Follows format (`FKP-123 #comment Description`)
- [ ] **Auto-Sync**: Branch is up to date with base branch
- [ ] **Clean History**: No unnecessary merge commits or rebase conflicts
- [ ] **File Changes**: Only necessary files modified like pubspec.lock, ios/stylinotificationservice/Info.plist, environment_variable.dart
- [ ] **Title of PR**: should also follow the commit messgae format. 

#### 🔍 **Code Quality & Standards**
- [ ] **Dart Analysis**: All linting rules pass (`flutter analyze`)
- [ ] **Code Formatting**: Code is properly formatted (`dart format`)
- [ ] **Dart Code Metrics**: No anti-patterns detected (long-method, long-parameter-list)
- [ ] **No Hard-coded Values**: All constants properly parameterized
- [ ] **Type Safety**: All variables properly typed, no implicit dynamic types

#### 📱 **Flutter-Specific Checks**
- [ ] **State Management**: Proper state management patterns used (BLoC for New Feature and GetX for existing feature)

#### ✅ **Final Checks**
- [ ] **Gemini Review**: Resolve Gemini reviewed critical and High Priprity issue
- [ ] **Peer Review**: At least one team member has reviewed the code

#### 🚨 **Production Readiness** (for production PRs)
- [ ] **Feature Flags**: Feature flags update in QA Config Panel
- [ ] **UAT Testing**: Before User Acceptance Testing update prod Config Panel
- [ ] **Release Notes**: Release notes update before release
