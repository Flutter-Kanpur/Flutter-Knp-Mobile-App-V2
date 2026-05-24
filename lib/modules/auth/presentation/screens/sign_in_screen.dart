import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kanpur_ui_kit/flutter_kanpur_ui_kit.dart';
import 'package:flutter_knp_mobile_app_v2/app/router/route_names.dart';
import 'package:flutter_knp_mobile_app_v2/app/theme/app_colors.dart';
import 'package:flutter_knp_mobile_app_v2/app/theme/app_text_styles.dart';
import 'package:flutter_knp_mobile_app_v2/core/constants/app_assets.dart';
import 'package:flutter_knp_mobile_app_v2/shared/widgets/custom_textfield.dart';
import 'package:flutter_knp_mobile_app_v2/shared/widgets/gradient_background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _emailFieldKey = GlobalKey();
  final _passwordFieldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(_scrollToFocusedField);
    _passwordFocusNode.addListener(_scrollToFocusedField);
  }

  void _scrollToFocusedField() {
    final node = _emailFocusNode.hasFocus
        ? _emailFocusNode
        : _passwordFocusNode;

    final key = _emailFocusNode.hasFocus ? _emailFieldKey : _passwordFieldKey;

    if (node.hasFocus && key.currentContext != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_scrollToFocusedField);
    _passwordFocusNode.removeListener(_scrollToFocusedField);

    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    _emailController.dispose();
    _passwordController.dispose();

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
                    children: [210.verticalSpace, _buildSignInForm()],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildMascot(),
          20.verticalSpace,
          _buildHeaderText(),
          35.verticalSpace,
          _buildEmailField(),
          10.verticalSpace,
          _buildPasswordField(),
          90.verticalSpace,
          _buildSignInButton(),
          15.verticalSpace,
          _buildSignUpText(),
          20.verticalSpace,
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
          'auth.welcomeBack'.tr(),
          style: textStyle_18MediumBlack().copyWith(fontSize: 24.sp),
        ),
        18.verticalSpace,
        Text(
          'auth.welcomeBackSubTitle'.tr(),
          textAlign: TextAlign.center,
          style: textStyle_16RegularBlack().copyWith(
            color: AppColors.subtitleTextDarkGrey,
          ),
        ),
      ],
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
        text: 'auth.password'.tr(),
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        isPassword: true,

        showBorder:
            _passwordFocusNode.hasFocus || _passwordController.text.isNotEmpty,

        borderColor: _passwordFocusNode.hasFocus
            ? AppColors.selectedNavBarIconColor
            : _passwordController.text.isNotEmpty
            ? AppColors.communityBorderColor
            : const Color(0xFFF6F6F6),

        fillColor:
            _passwordFocusNode.hasFocus || _passwordController.text.isNotEmpty
            ? Colors.transparent
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

  Widget _buildSignInButton() {
    return GradientButton(
      height: 45.h,

      text: 'auth.login'.tr(),

      textStyle: textStyle_16RegularBlack().copyWith(color: Colors.white),

      onTap: () {},
    );
  }

  Widget _buildSignUpText() {
    return Center(
      child: Text.rich(
        TextSpan(
          text: '${'auth.dontHaveAccount'.tr()} ',
          style: textStyle_14RegularBlack(),
          children: [
            TextSpan(
              text: 'auth.createAccountNow'.tr(),
              style: textStyle_14RegularBlack().copyWith(
                color: AppColors.selectedNavBarIconColor,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.go(RouteNames.signUp);
                },
            ),
          ],
        ),
      ),
    );
  }
}
