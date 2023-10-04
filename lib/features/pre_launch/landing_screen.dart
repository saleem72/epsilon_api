//

import 'package:epsilon_api/configuration/routing/app_screens.dart';
import 'package:epsilon_api/core/blocs/auth_bloc/auth_bloc.dart';
import 'package:epsilon_api/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helpers/safe.dart';
import 'splash_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool procced = false;
  AuthOption target = AuthOption.none;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthHome) {
          target = AuthOption.home;
          _handleNavigation(context);
        }
        if (state is AuthLogin) {
          target = AuthOption.login;
          _handleNavigation(context);
        }
      },
      child: SplashScreen(
        onFinish: () {
          setState(() {
            procced = true;
            _handleNavigation(context);
          });
        },
      ),
    );
  }

  _handleNavigation(BuildContext context) {
    if (!procced) {
      return;
    }
    if (target == AuthOption.home) {
      context.navigator.pushReplacementNamed(AppScreens.home);
    }
    if (target == AuthOption.login) {
      context.navigator.pushReplacementNamed(AppScreens.login);
    }
  }
}
