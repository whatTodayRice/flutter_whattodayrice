import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/presentation/providers/initial_page_index_provider.dart';
import 'package:riverpod/riverpod.dart';

@immutable
class PageNavigationState {
  const PageNavigationState({required this.pageController});
  final PageController pageController;

  PageNavigationState copyWith({PageController? pageController}) {
    return PageNavigationState(
        pageController: pageController ?? this.pageController);
  }
}

class PageNavigationStateNotifier extends StateNotifier<PageNavigationState> {
  PageNavigationStateNotifier({required this.initialpage})
      : super(
          PageNavigationState(
            pageController: PageController(
              initialPage: initialpage,
            ),
          ),
        );
  int initialpage;

  void moveToTodayMenu(int pageIndex) {
    state = state.copyWith(
      pageController: state.pageController
        ..animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        ),
    );
  }

  void moveToYesterdayMenu() {
    state = state.copyWith(
      pageController: state.pageController
        ..previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        ),
    );
  }

  void moveToTommorrowMenu() {
    state = state.copyWith(
      pageController: state.pageController
        ..nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        ),
    );
  }

  void moveToSelectedMenu(int pageIndex) {
    state = state.copyWith(
      pageController: state.pageController
        ..animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        ),
    );
  }
}

final pageNavigationStateProvider =
    StateNotifierProvider<PageNavigationStateNotifier, PageNavigationState>(
  (ref) {
    final initialPage = ref.read(initialPageIndexProvider);
    return PageNavigationStateNotifier(initialpage: initialPage);
  },
);
