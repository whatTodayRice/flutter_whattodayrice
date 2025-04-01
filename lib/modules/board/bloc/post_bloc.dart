import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/common/utils/event_bus.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';

part 'post_state.dart';
part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  final EventBus eventBus;

  late final StreamSubscription postCreatedSubscription;

  PostBloc({required this.postRepository, required this.eventBus}) : super(const PostInitial()) {
    postCreatedSubscription = eventBus.on<PostCreatedEvent>().listen((event) {
      add(FreePostCreateRequested(newPost: event.post));
    });

    /// 자유 게시판
    on<FreePostListLoadRequested>(_onFreePostListLoadRequested);
    on<FreePostListRefreshRequested>(_onFreePostListRefreshRequested);
    on<FreePostLoadRequested>(_onFreePostLoadRequested);
    on<FreePostDeleteRequested>(_onFreePostDeleteRequested);
    on<FreePostCreateRequested>(_onFreePostCreateRequested);

    /// 질문 게시판
    on<QuestionPostListLoadRequested>(_onQuestionPostListLoadRequested);
    on<QuestionPostListRefreshRequested>(_onQuestionPostListRefreshRequested);
    on<QuestionPostLoadRequested>(_onQuestionPostLoadRequested);
    on<QuestionPostDeleteRequested>(_onQuestionPostDeleteRequested);
    on<QuestionPostCreateRequested>(_onQuestionPostCreateRequested);
  }

  int? freePostNextPage = 1;
  int? questionPostNextPage = 1;

  List<Post> freePostList = [];
  List<Post> questionPostList = [];

  FutureOr<void> _onFreePostListLoadRequested(
    FreePostListLoadRequested event,
    Emitter<PostState> emit,
  ) async {
    emit(const PostLoading());

    if (freePostNextPage == null) {
      emit(FreePostLoaded(itemList: [...freePostList]));

      return;
    }

    // final response = await postRepository.getPosts(postType: PostType.free.name, page: freePostNextPage!);
    //
    // final dataList = response.succeedData ?? [];
    // freePostNextPage = (response.succeedData!.length >= 20) ? freePostNextPage! + 1 : null;
    //
    // freePostList = [...freePostList, ...dataList];

    emit(FreePostLoaded(itemList: [...freePostList]));
  }

  Future<void> _onFreePostListRefreshRequested(
    FreePostListRefreshRequested event,
    Emitter<PostState> emit,
  ) async {
    freePostNextPage = 1;

    freePostList.clear();

    add(const FreePostListLoadRequested());
  }

  Future<void> _onFreePostLoadRequested(
    FreePostLoadRequested event,
    Emitter<PostState> emit,
  ) async {
    final response = await postRepository.getPost(postId: freePostList[event.postIndex].postId);

    if (!response.isSucceed) {
      return;
    }

    freePostList[event.postIndex] = response.succeedData!;

    emit(FreePostLoaded(itemList: freePostList, nextPage: freePostNextPage));
  }

  Future<void> _onFreePostDeleteRequested(
    FreePostDeleteRequested event,
    Emitter<PostState> emit,
  ) async {
    final response = await postRepository.deletePost(postId: freePostList[event.postIndex].postId);

    if (!response.isSucceed) {
      return;
    }

    freePostList.removeAt(event.postIndex);

    emit(FreePostLoaded(itemList: freePostList, nextPage: freePostNextPage));
  }

  Future<void> _onFreePostCreateRequested(
    FreePostCreateRequested event,
    Emitter<PostState> emit,
  ) async {
    freePostList = [event.newPost, ...freePostList];

    emit(FreePostLoaded(itemList: freePostList, nextPage: freePostNextPage));
  }

  /// 질문 게시판
  FutureOr<void> _onQuestionPostListLoadRequested(
    QuestionPostListLoadRequested event,
    Emitter<PostState> emit,
  ) async {
    if (questionPostNextPage == null) {
      return;
    }

    // final response = await postRepository.getPosts(postType: PostType.question.name, page: questionPostNextPage!);
    //
    // final dataList = response.succeedData ?? [];
    // questionPostNextPage = (dataList.length >= 20) ? questionPostNextPage! + 1 : null;
    //
    // questionPostList = [...questionPostList, ...dataList];

    emit(QuestionPostLoaded(itemList: [...questionPostList], nextPage: questionPostNextPage));
  }

  Future<void> _onQuestionPostListRefreshRequested(
    QuestionPostListRefreshRequested event,
    Emitter<PostState> emit,
  ) async {
    questionPostNextPage = 1;

    questionPostList = [];

    add(const QuestionPostListLoadRequested());
  }

  Future<void> _onQuestionPostLoadRequested(
    QuestionPostLoadRequested event,
    Emitter<PostState> emit,
  ) async {
    final response = await postRepository.getPost(postId: questionPostList[event.postIndex].postId);

    if (!response.isSucceed) {
      return;
    }

    questionPostList[event.postIndex] = response.succeedData!;

    emit(QuestionPostLoaded(itemList: questionPostList, nextPage: questionPostNextPage));
  }

  Future<void> _onQuestionPostDeleteRequested(
    QuestionPostDeleteRequested event,
    Emitter<PostState> emit,
  ) async {
    final response = await postRepository.deletePost(postId: questionPostList[event.postIndex].postId);

    if (!response.isSucceed) {
      return;
    }

    questionPostList.removeAt(event.postIndex);

    emit(QuestionPostLoaded(itemList: questionPostList, nextPage: questionPostNextPage));
  }

  Future<void> _onQuestionPostCreateRequested(
    QuestionPostCreateRequested event,
    Emitter<PostState> emit,
  ) async {
    questionPostList = [event.newPost, ...questionPostList];

    emit(QuestionPostLoaded(itemList: questionPostList, nextPage: questionPostNextPage));
  }
}
