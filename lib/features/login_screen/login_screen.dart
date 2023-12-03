//

import 'package:epsilon_api/configuration/routing/app_screens.dart';
import 'package:epsilon_api/configuration/styling/assets/app_icons.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:epsilon_api/core/domian/models/login_validation_status.dart';
import 'package:epsilon_api/core/errors/failure.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:epsilon_api/core/helpers/text_field_formmaters.dart';
import 'package:epsilon_api/core/widgets/app_decoration_image.dart';
import 'package:epsilon_api/core/widgets/app_nav_bar.dart';
import 'package:epsilon_api/core/widgets/app_text_field.dart';
import 'package:epsilon_api/core/widgets/error_view.dart';
import 'package:epsilon_api/core/widgets/general_loading_view.dart';
import 'package:epsilon_api/core/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dependancy_injection.dart' as di;
import 'presentation/login_bloc/login_bloc.dart';
import 'presentation/widgets/companies_dropdown.dart';

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

class LoginScreenContent extends StatefulWidget {
  const LoginScreenContent({
    super.key,
  });

  @override
  State<LoginScreenContent> createState() => _LoginScreenContentState();
}

class _LoginScreenContentState extends State<LoginScreenContent> {
  final TextEditingController _host = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _host.text = context.read<LoginBloc>().state.host;
    });
  }

  @override
  void dispose() {
    _host.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
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
        return Scaffold(
          // appBar: AppBar(),
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              _decorationImage(),
              _content(context, state),
              if (state.isLoading) const GeneralLoadingView(),
              _errorView(context, state.failure),
            ],
          ),
        );
      },
    );
  }

  Scaffold _content(BuildContext context, LoginState state) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: AppColors.neutral95,
        child: Column(
          children: [
            AppNavBar(
              title: context.translate.login,
              showBackButton: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: _textFields(context, state),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _decorationImage() {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Transform.translate(
        offset: const Offset(118, 157),
        child: const AppDecorationImage(),
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
        _databaseURl(context),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CompaniesDropDown(
            intialValue: context.read<LoginBloc>().state.company,
            onChange: (company) {
              context
                  .read<LoginBloc>()
                  .add(LoginCompanyHasChanged(company: company));
            },
          ),
        ),
        const SizedBox(height: 30),
        _loginButton(context, state.isValid),
      ],
    ));
  }

  Widget _databaseURl(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LabledValidateTextFIeld(
        controller: _host,
        label: context.translate.database_url,
        hint: context.translate.database_url_hint,
        icon: AppIcons.database,
        iconSize: 26,
        onChange: (value) {
          context.read<LoginBloc>().add(LoginHostHasChanged(host: value));
        },
        onHasFocus: () {},
        onLoseFocus: () {},
      ),
    );
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

  Widget _passwordTextField(
      BuildContext context, LoginValidationStatus? valid) {
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

  Widget _usernameTextField(
      BuildContext context, LoginValidationStatus? valid) {
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

  Widget _errorView(BuildContext context, Failure? failure) {
    return failure != null
        ? GeneralErrorView(
            onAction: () => context.read<LoginBloc>().add(LoginClearFailure()),
            failure: failure,
          )
        : const SizedBox.shrink();
  }
}
