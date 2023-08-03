//

import 'package:epsilon_api/configuration/styling/assets/assets.dart';
import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onFinish});

  final Function onFinish;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _titleAnimation;
  late Animation<double> _forAnimation;
  late Animation<double> _bussinessAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onFinish();
        }
      });

    _titleAnimation = Tween<double>(begin: 400, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.3,
          0.5,
          curve: Curves.easeIn,
        ),
      ),
    );

    _forAnimation = Tween<double>(begin: 400, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.4,
          0.6,
          curve: Curves.easeIn,
        ),
      ),
    );

    _bussinessAnimation = Tween<double>(begin: 400, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.5,
          0.7,
          curve: Curves.easeIn,
        ),
      ),
    );

    // if (SchedulerBinding.instance.schedulerPhase ==
    //     SchedulerPhase.persistentCallbacks) {

    // }

    // SchedulerBinding.instance
    //     .addPostFrameCallback((_) => _animationController.forward());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Image(
            image: AssetImage(Assets.background),
            fit: BoxFit.cover,
          ),
          loggo(),
          Center(
            // 246 × 247 219 × 220
            child: Transform.translate(
              offset: const Offset(0, 230),
              child: SizedBox(
                width: 219,
                height: 220,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Column(
                      children: [
                        _title(),
                        const SizedBox(height: 20),
                        _for(),
                        const SizedBox(height: 20),
                        _bussiness()
                      ],
                    );
                  },
                ),
                // child: ,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bussiness() {
    return Transform.translate(
      offset: Offset(0, _bussinessAnimation.value),
      child: Text('Business Solutious',
          style: Topology.smallTitle.copyWith(
            color: AppColors.primaryDark,
          )),
    );
  }

  Widget _for() {
    return Transform.translate(
      offset: Offset(0, _forAnimation.value),
      child: Text('for',
          style: Topology.smallTitle.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.primaryDark,
          )),
    );
  }

  Widget _title() {
    return Transform.translate(
      offset: Offset(0, _titleAnimation.value),
      child: Text(
        'Epsilon soft',
        style: Topology.smallTitle.copyWith(
          color: AppColors.primaryDark,
        ),
      ),
    );
  }

  Center loggo() {
    return const Center(
      child: SizedBox(
        width: 219,
        height: 220,
        child: Image(
          fit: BoxFit.fill,
          image: AssetImage(Assets.splashScreen),
        ),
      ),
    );
  }
}
