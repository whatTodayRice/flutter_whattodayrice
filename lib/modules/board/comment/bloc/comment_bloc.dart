import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_whattodayrice/data/models/comment.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final PostRepository postRepository;
  final AuthRepository authRepository;
  final String postId;

  CommentBloc({
    required this.postRepository,
    required this.postId,
    required this.authRepository,
  }) : super(const CommentInitial()) {
    on<CommentListLoadRequested>(_onCommentListLoadRequested);
    on<CommentDeleteRequested>(_onCommentDeleteRequested);
    on<CommentCreateRequested>(_onCommentCreateRequested);
    on<CommentContentChanged>(_onCommentContentChanged);
  }

  int? page = 1;

  String content = "";
  List<Comment> commentList = [];

  Future<void> _onCommentListLoadRequested(
    CommentListLoadRequested event,
    Emitter<CommentState> emit,
  ) async {
    emit(const CommentLoading());

    if (page == null) {
      emit(CommentListLoaded(comments: [...commentList]));

      return;
    }

    final response = await postRepository.getComments(page: page!, postId: postId);

    final dataList = response.succeedData ?? [];
    page = (response.succeedData!.length < 20) ? page = null : page! + 1;

    commentList = [...dataList, ...commentList];

    emit(CommentListLoaded(comments: [...commentList]));
  }

  Future<void> _onCommentDeleteRequested(
    CommentDeleteRequested event,
    Emitter<CommentState> emit,
  ) async {
    final response = await postRepository.deleteComment(
      commentId: commentList[event.commentIndex].id.toString(),
    );

    if (!response.isSucceed) {
      return;
    }

    commentList = [
      ...commentList.sublist(0, event.commentIndex),
      ...commentList.sublist(event.commentIndex + 1),
    ];

    emit(CommentListLoaded(comments: commentList));
  }

  Future<void> _onCommentCreateRequested(
    CommentCreateRequested event,
    Emitter<CommentState> emit,
  ) async {
    final response = await postRepository.addComment(
      // TODO
      userId: "",
      postId: postId,
      content: content,
    );

    commentList = [...commentList, response.succeedData!];

    emit(CommentListLoaded(comments: commentList));
  }

  Future<void> _onCommentContentChanged(
    CommentContentChanged event,
    Emitter<CommentState> emit,
  ) async {
    content = event.content;

    emit(CommentListLoaded(comments: commentList, isContentEmpty: content.isEmpty));
  }
}
