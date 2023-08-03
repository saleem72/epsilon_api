//

import 'package:epsilon_api/configuration/routing/app_screens.dart';
import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/helpers/text_field_formmaters.dart';
import 'package:epsilon_api/core/widgets/app_decoration_image.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/core/widgets/app_text_field.dart';
import 'package:epsilon_api/core/widgets/error_view.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:epsilon_api/core/widgets/loading_view.dart';
import 'package:epsilon_api/features/login_screen/domain/failures/login_failure.dart';
import 'package:epsilon_api/features/login_screen/domain/models/validation_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependancy_injection.dart' as di;
import 'presentation/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => di.locator(),
      child: const LoginScreenContent(),
    );
  }
}

class LoginScreenContent extends StatelessWidget {
  const LoginScreenContent({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.neutral95,
        child: Column(
          children: [
            AppNavBar(title: context.translate.login),
            BlocConsumer<LoginBloc, LoginState>(
              listenWhen: (previous, current) =>
                  previous.loginSuccessfully != current.loginSuccessfully,
              listener: (context, state) {
                if (state.loginSuccessfully && state.token != null) {
                  context
                      .read<AuthBloc>()
                      .add(AuthEvent.authorized(token: state.token!));
                  Navigator.of(context).pushReplacementNamed(AppScreens.home);
                }
              },
              builder: (context, state) {
                return Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Transform.translate(
                          offset: const Offset(118, 157),
                          child: _decorationImage(),
                        ),
                      ),
                      _textFields(context, state),
                      LoadingView(isLoading: state.isLoading),
                      state.failure != null
                          ? GeneralErrorView(
                              onAction: () => context
                                  .read<LoginBloc>()
                                  .add(LoginClearFailure()),
                              failure:
                                  _getFailureMessage(context, state.failure!),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFields(BuildContext context, LoginState state) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const SizedBox(height: 30),
        _usernameTextField(context, state.usernameStatus),
        const SizedBox(height: 30),
        _passwordTextField(context, state.passwordStatus),
        const SizedBox(height: 30),
        _loginButton(context, state.isValid),
      ],
    ));
  }

  Widget _decorationImage() {
    // width: 177.63, height: 401.2
    return const AppDecorationImage();
  }

  Widget _loginButton(BuildContext context, bool isEnabled) {
    return GradientButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        context.read<LoginBloc>().add(LoginExecute());
      },
      isEnabled: isEnabled,
      label: context.translate.ok_button,
    );
  }

  Widget _passwordTextField(BuildContext context, ValidationStatus? valid) {
    final bloc = context.read<LoginBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LabledValidateTextFIeld(
        label: context.translate.password,
        hint: context.translate.password_hint,
        icon: AppIcons.lock,
        keyboard: TextInputType.visiblePassword,
        errorMessage: valid?.message(context),
        isSecure: true,
        onChange: (value) => bloc.add(LoginPasswordHasChanged(password: value)),
        onHasFocus: () => bloc.add(LoginClearPasswordError()),
        onLoseFocus: () => bloc.add(LoginPasswordLostFocus()),
      ),
    );
  }

  Widget _usernameTextField(BuildContext context, ValidationStatus? valid) {
    final bloc = context.read<LoginBloc>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LabledValidateTextFIeld(
        label: context.translate.user_name,
        hint: context.translate.user_name_hint,
        errorMessage: valid?.message(context),
        icon: AppIcons.user,
        keyboard: TextInputType.emailAddress,
        formmaters: TextFieldFormmaters.letterAndNumbersTextField,
        onChange: (value) => bloc.add(LoginUsernameHasChanged(username: value)),
        onHasFocus: () => bloc.add(LoginClearUsernameError()),
        onLoseFocus: () => bloc.add(LoginUsernameLostFocus()),
      ),
    );
  }

  _getFailureMessage(BuildContext context, HttpFailure failure) {
    if (failure is HttpNoInternetFailure) {
      return context.translate.no_internet_connection;
    }

    if (failure is HttpConnectionFailure) {
      return context.translate.connection_failure;
    }

    if (failure is HttpDecodingFailure) {
      return context.translate.decoding_failure;
    }

    if (failure is InvalidUsernameOrPasswordFailure) {
      return context.translate.invalid_username_or_password;
    }

    context.translate.unexpected_failure;
  }
}
