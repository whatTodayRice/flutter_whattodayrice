import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/requests/create_post_request.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostRepository postRepository;
  final UserRepository userRepository;

  PostDetailBloc({required this.postRepository, required this.userRepository}) : super(const PostDetailInitial()) {
    on<PostDetailLoadRequested>(_onPostDetailLoadRequested);
    on<PostDetailSellStatusChangeRequested>(_onPostDetailSellStatusChangeRequested);
    on<PostDetailDeleteRequested>(_onPostDetailDeleteRequested);
    on<PostDetailWriterBlockRequested>(_onPostDetailWriterBlockRequested);
    on<PostDetailCommentContentChangeRequested>(_onPostDetailCommentContentChangeRequested);
    on<PostDetailCreateCommentRequested>(_onPostDetailCreateCommentRequested);
  }

  Post? post;
  String content = '';

  FutureOr<void> _onPostDetailLoadRequested(
    PostDetailLoadRequested event,
    Emitter<PostDetailState> emit,
  ) async {
    emit(const PostDetailLoading());

    final response = await postRepository.getPost(postId: event.postId);

    if (response.succeedData == null) {
      emit(const PostDetailError());

      return;
    }

    post = response.succeedData!;

    final curUserProfile = userRepository.getUserProfileFromCache();

    List<Post> filteredComments = [];

    for (int i = 0; i < post!.comments.length; i++) {
      final comment = post!.comments[i];

      if (curUserProfile?.blockedUserIds.contains(comment.userId) == true) {
        continue;
      }

      filteredComments.add(comment);
    }

    post = post!.copyWith(comments: [...filteredComments]);

    emit(PostDetailLoaded(post: post!));
  }

  FutureOr<void> _onPostDetailSellStatusChangeRequested(
    PostDetailSellStatusChangeRequested event,
    Emitter<PostDetailState> emit,
  ) async {
    if (post == null) {
      return;
    }

    emit(const PostDetailLoading());

    final result = await postRepository.updatePostSellStatus(postId: post!.id!, sellStatus: event.statusIndex);

    if (result.isSucceed != true) {
      emit(PostDetailError(errorMessage: result.errorMessage));

      return;
    }

    post = post!.copyWith(sellStatus: event.statusIndex);

    emit(PostDetailLoaded(post: post!));
  }

  FutureOr<void> _onPostDetailDeleteRequested(
    PostDetailDeleteRequested event,
    Emitter<PostDetailState> emit,
  ) async {
    emit(const PostDetailLoading());

    ApiResponse? response;

    if (event.commentId != null) {
      response = await postRepository.deleteComment(parentPostId: post!.id!, commentId: event.commentId!);
    } else {
      response = await postRepository.deletePost(postId: post!.id!);
    }

    if (response.isSucceed != true) {
      emit(PostDetailError(errorMessage: response.errorMessage));

      return;
    }

    emit(PostDetailDeleteSucceed(isPost: event.commentId == null));
  }

  FutureOr<void> _onPostDetailWriterBlockRequested(
    PostDetailWriterBlockRequested event,
    Emitter<PostDetailState> emit,
  ) async {
    emit(const PostDetailLoading());

    final curProfile = userRepository.getUserProfileFromCache();

    if (curProfile == null) {
      return;
    }

    List<int> updateBlockedIds = [];

    if (event.commentIndex == null) {
      updateBlockedIds = [...curProfile.blockedUserIds, post!.userId!];
    } else {
      updateBlockedIds = [...curProfile.blockedUserIds, post!.comments[event.commentIndex!].userId!];
    }

    final response = await userRepository.updateBlockedUsers(userId: curProfile.id, blockedUserIds: updateBlockedIds);

    if (response.isSucceed != true) {
      emit(PostDetailError(errorMessage: response.errorMessage));

      return;
    }

    if (updateBlockedIds.contains(post!.userId)) {
      final message = "${post!.nickname}님을 차단했어요.";

      emit(PostDetailUserBlockedSucceed(isPost: true, message: message));

      return;
    }

    final message = "${post!.comments[event.commentIndex!].nickname!}님을 차단했어요.";

    emit(PostDetailUserBlockedSucceed(message: message));
  }

  FutureOr<void> _onPostDetailCommentContentChangeRequested(
    PostDetailCommentContentChangeRequested event,
    Emitter<PostDetailState> emit,
  ) async {
    content = event.content;

    emit(PostDetailCommentValidationChecked(isValid: content.isNotEmpty));
  }

  FutureOr<void> _onPostDetailCreateCommentRequested(
    PostDetailCreateCommentRequested event,
    Emitter<PostDetailState> emit,
  ) async {
    final curUserProfile = userRepository.getUserProfileFromCache();

    if (curUserProfile == null) {
      return;
    }

    emit(const PostDetailLoading());

    final request = CreatePostRequest(
      parentPostId: post!.id,
      userId: curUserProfile.id,
      nickname: curUserProfile.nickname,
      content: content,
    );

    final response = await postRepository.createComment(request: request);

    if (response.isSucceed != true) {
      emit(PostDetailError(errorMessage: response.errorMessage));

      return;
    }

    add(PostDetailLoadRequested(postId: post!.id!));
  }
}
