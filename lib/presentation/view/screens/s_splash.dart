import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/splash/splash_bloc.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const routeName = '/splash';

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
          Navigator.of(context).popAndPushNamed("/${AppRouteState.signIn.name}");

          return;
        }

        if (state is SplashLoaded && state.routeName == AppRouteState.home.name) {
          Navigator.of(context).popAndPushNamed("/${AppRouteState.home.name}");

          return;
        }
      },
      child: Scaffold(
        backgroundColor: ColorConstant.primary,
        body: Center(
          child: Image.asset(
            "assets/images/splash/splash.png",
            width: 65,
            height: 78,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
