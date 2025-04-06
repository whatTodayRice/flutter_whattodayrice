import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/profile.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'my_post_event.dart';
part 'my_post_state.dart';

class MyPostBloc extends Bloc<MyPostEvent, MyPostState> {
  final PostRepository postRepository;
  final UserRepository userRepository;

  MyPostBloc({required this.postRepository, required this.userRepository}) : super(const MyPostInitial()) {
    on<MyPostLoadRequested>(_onMyPostLoadRequested);
  }

  Profile? profile;

  List<Post> myPostList = [];
  String? lastDocId;

  FutureOr<void> _onMyPostLoadRequested(
    MyPostLoadRequested event,
    Emitter<MyPostState> emit,
  ) async {
    profile = userRepository.getUserProfileFromCache();

    if (profile == null) {
      return;
    }

    emit(const MyPostLoading());

    final response = await postRepository.getMyPostList(userId: profile!.id, lastDocId: lastDocId);

    if (response.isSucceed != true) {
      emit(MyPostError(message: response.errorMessage));

      return;
    }

    myPostList = [...myPostList, ...response.succeedData ?? []];
    lastDocId = (response.succeedData ?? []).length >= 20 ? response.succeedData!.last.id : null;

    emit(MyPostLoaded(nickname: profile?.nickname, myPostList: [...myPostList], lastDocId: lastDocId));
  }
}
