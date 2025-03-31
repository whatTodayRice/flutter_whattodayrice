// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_whattodayrice/modules/board/bloc/post_bloc.dart';
import 'package:flutter_whattodayrice/modules/board/board_screen.dart';
import 'package:flutter_whattodayrice/config/themes/app_color.dart';
import 'package:flutter_whattodayrice/modules/home/bloc/home_bloc.dart';

import 'package:flutter_whattodayrice/modules/my_profile/w_my_option.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/adaptive_scaffold.dart';
import 'package:flutter_whattodayrice/presentation/view/components/common/w_appbar_title.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    homeBloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset("assets/images/식단_active.svg"),
                icon: SvgPicture.asset("assets/images/식단_inactive.svg"),
                label: '홈',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset("assets/images/MY_active.svg"),
                icon: SvgPicture.asset("assets/images/MY_inactive.svg"),
                label: '중고거래',
              ),
            ],
            currentIndex: widget.navigationShell.currentIndex,
            selectedItemColor: AppColor.primary,
            onTap: (index) => widget.navigationShell.goBranch(
              index,
              initialLocation: index == widget.navigationShell.currentIndex,
            ),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ],
      ),
    );
  }
}
