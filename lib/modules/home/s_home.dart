import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_whattodayrice/business-logic/bloc/dormitory/dormitory_bloc.dart';
import 'package:flutter_whattodayrice/data/models/meal.dart';
import 'package:flutter_whattodayrice/common/theme/colors.dart';
import 'package:flutter_whattodayrice/modules/board/w_board_option.dart';
import 'package:flutter_whattodayrice/modules/home/widget/home_option.dart';
import 'package:flutter_whattodayrice/modules/my_profile/w_my_option.dart';
import 'package:flutter_whattodayrice/presentation/view/components/w_menu_fragment.dart';
import 'package:flutter_whattodayrice/router/app_router_state.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final DormitoryBloc _dormitoryBloc;
  late final List<Widget> widgetOptions;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    _dormitoryBloc = context.read<DormitoryBloc>();
    _dormitoryBloc.add(const DormitoryMealLoadRequested());

    widgetOptions = [
      HomeOption(dormitoryBloc: _dormitoryBloc),
      const BoardOption(),
      const MyOption(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.primary,
        centerTitle: true,
        title: Text("행복기숙사", style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => context.pushNamed(AppRouteState.setting.name),
          ),
        ],
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/images/식단_active.svg"),
            icon: SvgPicture.asset("assets/images/식단_inactive.svg"),
            label: '홈',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/images/중고거래_active.svg"),
            icon: SvgPicture.asset("assets/images/중고거래_inactive.svg"),
            label: '게시판',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset("assets/images/MY_active.svg"),
            icon: SvgPicture.asset("assets/images/MY_inactive.svg"),
            label: 'MY',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
