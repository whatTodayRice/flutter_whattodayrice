import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/modules/splash/bloc/splash_bloc.dart';
import 'package:flutter_whattodayrice/config/router/route_config.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SplashBloc>().add(const SplashSessionRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded && state.routeName == AppRouteState.signIn.name) {
          context.goNamed(state.routeName);

          return;
        }

        if (state is SplashLoaded && state.routeName == AppRouteState.secondHand.name) {
          context.goNamed(state.routeName);

          return;
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: Center(
          child: Image.asset(
            "assets/images/splash/splash.png",
            width: 150,
            height: 150,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
