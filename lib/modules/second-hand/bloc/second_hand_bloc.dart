import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:flutter_whattodayrice/modules/second-hand/util/post_filter_util.dart';

part 'second_hand_event.dart';
part 'second_hand_state.dart';

class SecondHandBloc extends Bloc<SecondHandEvent, SecondHandState> {
  final PostRepository postRepository;

  SecondHandBloc({required this.postRepository}) : super(const SecondHandInitial()) {
    on<SecondHandLoadRequested>(_onSecondHandLoadRequested);
    on<SecondHandRefreshRequested>(_onSecondHandRefreshRequested);
  }

  List<Post> postList = [];
  String? lastDocId;

  FutureOr<void> _onSecondHandLoadRequested(
    SecondHandLoadRequested event,
    Emitter<SecondHandState> emit,
  ) async {
    emit(const SecondHandLoading());

    final response = await postRepository.getPosts(lastDocId: lastDocId);

    final filteredPosts = PostBlockedUserFilterUtil.getFilteredPosts(response.succeedData ?? []);

    postList = [...postList, ...filteredPosts];
    lastDocId = (response.succeedData ?? []).length >= 20 ? response.succeedData!.last.id : null;

    emit(SecondHandLoaded(itemList: [...postList], nextPageKey: lastDocId));
  }

  FutureOr<void> _onSecondHandRefreshRequested(
    SecondHandRefreshRequested event,
    Emitter<SecondHandState> emit,
  ) async {
    postList = [];
    lastDocId = null;
  }
}
