import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kanpur_ui_kit/flutter_kanpur_ui_kit.dart';
import 'package:flutter_knp_mobile_app_v2/app/router/route_names.dart';
import 'package:flutter_knp_mobile_app_v2/app/theme/app_colors.dart';
import 'package:flutter_knp_mobile_app_v2/app/theme/app_text_styles.dart';
import 'package:flutter_knp_mobile_app_v2/core/constants/app_assets.dart';
import 'package:flutter_knp_mobile_app_v2/shared/screens/app_feedback_screen.dart';

import 'package:flutter_knp_mobile_app_v2/shared/widgets/custom_textfield.dart';
import 'package:flutter_knp_mobile_app_v2/shared/widgets/gradient_background.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  final _usernameFieldKey = GlobalKey();
  final _emailFieldKey = GlobalKey();
  final _passwordFieldKey = GlobalKey();
  final _confirmPasswordFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    for (final node in [
      _usernameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode,
    ]) {
      node.addListener(_scrollToFocusedField);
    }
  }

  void _scrollToFocusedField() {
    final nodes = [
      _usernameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode,
    ];

    final keys = [
      _usernameFieldKey,
      _emailFieldKey,
      _passwordFieldKey,
      _confirmPasswordFieldKey,
    ];

    for (int i = 0; i < nodes.length; i++) {
      if (nodes[i].hasFocus && keys[i].currentContext != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Scrollable.ensureVisible(
            keys[i].currentContext!,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });

        break;
      }
    }
  }

  @override
  void dispose() {
    for (final node in [
      _usernameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _confirmPasswordFocusNode,
    ]) {
      node.removeListener(_scrollToFocusedField);
      node.dispose();
    }

    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24.sp,
                right: 24.sp,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      110.verticalSpace,

                      _buildSignUpForm(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildMascot(),
          18.verticalSpace,
          _buildHeaderText(),
          35.verticalSpace,
          _buildUsernameField(),
          12.verticalSpace,
          _buildEmailField(),
          12.verticalSpace,
          _buildPasswordField(),
          12.verticalSpace,
          _buildConfirmPasswordField(),
          35.verticalSpace,
          _buildContinueButton(),
          20.verticalSpace,
          _buildFooterText(),
          8.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildMascot() {
    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: Image.asset(AppAssets.dashIcon, fit: BoxFit.contain),
    );
  }

  Widget _buildHeaderText() {
    return Column(
      children: [
        Text(
          'auth.signUpTitle'.tr(),
          style: textStyle_18MediumBlack().copyWith(fontSize: 24.sp),
        ),

        18.verticalSpace,

        Text(
          'auth.signUpSubTitle'.tr(),
          textAlign: TextAlign.center,
          style: textStyle_16RegularBlack().copyWith(
            color: AppColors.subtitleTextDarkGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return Container(
      key: _usernameFieldKey,
      child: CustomTextField(
        text: 'auth.username'.tr(),

        controller: _usernameController,

        focusNode: _usernameFocusNode,

        showBorder:
            _usernameFocusNode.hasFocus || _usernameController.text.isNotEmpty,

        fillColor:
            _usernameFocusNode.hasFocus || _usernameController.text.isNotEmpty
            ? Colors.transparent
            : const Color(0xFFF6F6F6),

        borderColor: _usernameFocusNode.hasFocus
            ? AppColors.selectedNavBarIconColor
            : _usernameController.text.isNotEmpty
            ? AppColors.communityBorderColor
            : const Color(0xFFF6F6F6),

        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'auth.usernameRequired'.tr();
          }

          return null;
        },
      ),
    );
  }

  Widget _buildEmailField() {
    return Container(
      key: _emailFieldKey,
      child: CustomTextField(
        text: 'auth.emailAddress'.tr(),

        controller: _emailController,

        focusNode: _emailFocusNode,

        keyboardType: TextInputType.emailAddress,

        showBorder:
            _emailFocusNode.hasFocus || _emailController.text.isNotEmpty,

        borderColor: _emailFocusNode.hasFocus
            ? AppColors.selectedNavBarIconColor
            : _emailController.text.isNotEmpty
            ? AppColors.communityBorderColor
            : const Color(0xFFF6F6F6),

        fillColor: _emailFocusNode.hasFocus || _emailController.text.isNotEmpty
            ? Colors.transparent
            : const Color(0xFFF6F6F6),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'auth.emailRequired'.tr();
          }

          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      key: _passwordFieldKey,
      child: CustomTextField(
        text: 'auth.createPassword'.tr(),

        controller: _passwordController,

        focusNode: _passwordFocusNode,

        isPassword: true,

        showBorder:
            _passwordFocusNode.hasFocus || _passwordController.text.isNotEmpty,

        fillColor:
            _passwordFocusNode.hasFocus || _passwordController.text.isNotEmpty
            ? Colors.transparent
            : const Color(0xFFF6F6F6),

        borderColor: _passwordFocusNode.hasFocus
            ? AppColors.selectedNavBarIconColor
            : _passwordController.text.isNotEmpty
            ? AppColors.communityBorderColor
            : const Color(0xFFF6F6F6),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'auth.passwordRequired'.tr();
          }

          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return Container(
      key: _confirmPasswordFieldKey,
      child: CustomTextField(
        text: 'auth.confirmPassword'.tr(),

        controller: _confirmPasswordController,

        focusNode: _confirmPasswordFocusNode,

        isPassword: true,

        showBorder:
            _confirmPasswordFocusNode.hasFocus ||
            _confirmPasswordController.text.isNotEmpty,

        fillColor:
            _confirmPasswordFocusNode.hasFocus ||
                _confirmPasswordController.text.isNotEmpty
            ? Colors.transparent
            : const Color(0xFFF6F6F6),

        borderColor: _confirmPasswordFocusNode.hasFocus
            ? AppColors.selectedNavBarIconColor
            : _confirmPasswordController.text.isNotEmpty
            ? AppColors.communityBorderColor
            : const Color(0xFFF6F6F6),

        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'auth.confirmPasswordRequired'.tr();
          }

          if (value != _passwordController.text) {
            return 'auth.passwordsDoNotMatch'.tr();
          }

          return null;
        },
      ),
    );
  }

  Widget _buildContinueButton() {
    return GradientButton(
      height: 45.h,

      text: 'auth.createAccount'.tr(),

      textStyle: textStyle_16RegularBlack().copyWith(color: Colors.white),

        onTap: () {

          if (_formKey.currentState!.validate()) {

            /// SUCCESS SCREEN
            context.push(
              RouteNames.feedback,

              extra: AppFeedbackScreen(
                image: AppAssets.successIcon,

                title: 'auth.emailVerifiedTitle'.tr(),

                subtitle:
                'auth.emailVerifiedSubTitle'.tr(),

                buttonText: 'auth.login'.tr(),

                onPressed: () {
                  context.go(RouteNames.signIn);
                },
              ),
            );

          } else {

            /// FAILURE SCREEN
            context.push(
              RouteNames.feedback,

              extra: AppFeedbackScreen(
                image: AppAssets.successIcon,

                title:
                'auth.verificationFailedTitle'.tr(),

                subtitle:
                'auth.verificationFailedSubTitle'.tr(),

                buttonText: 'auth.retry'.tr(),

                onPressed: () {
                  context.pop();
                },
              ),
            );
          }
        },
    );
  }

  Widget _buildFooterText() {
    return Center(
      child: Text.rich(
        TextSpan(
          text: '${'auth.alreadyHaveAccount'.tr()} ',

          style: textStyle_14RegularBlack(),

          children: [
            TextSpan(
              text: 'auth.login'.tr(),

              style: textStyle_14RegularBlack().copyWith(
                color: AppColors.selectedNavBarIconColor,
              ),

              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.go(RouteNames.signIn);
                },
            ),
          ],
        ),
      ),
    );
  }
}
