part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

/// 자유 게시판
final class FreePostListLoadRequested extends PostEvent {
  const FreePostListLoadRequested();
}

final class FreePostListRefreshRequested extends PostEvent {
  const FreePostListRefreshRequested();
}

/// 게시글 상세
final class FreePostLoadRequested extends PostEvent {
  const FreePostLoadRequested({required this.postIndex});

  final int postIndex;

  @override
  List<Object?> get props => [postIndex];
}

final class FreePostDeleteRequested extends PostEvent {
  const FreePostDeleteRequested({required this.postIndex});

  final int postIndex;

  @override
  List<Object?> get props => [postIndex];
}

/// 게시글 등록
final class FreePostCreateRequested extends PostEvent {
  const FreePostCreateRequested({required this.newPost});

  final Post newPost;

  @override
  List<Object?> get props => [newPost];
}

/// 질문 게시판
final class QuestionPostListLoadRequested extends PostEvent {
  const QuestionPostListLoadRequested();
}

final class QuestionPostListRefreshRequested extends PostEvent {
  const QuestionPostListRefreshRequested();
}

/// 게시글 상세
final class QuestionPostLoadRequested extends PostEvent {
  const QuestionPostLoadRequested({required this.postIndex});

  final int postIndex;

  @override
  List<Object?> get props => [postIndex];
}

final class QuestionPostDeleteRequested extends PostEvent {
  const QuestionPostDeleteRequested({required this.postIndex});

  final int postIndex;

  @override
  List<Object?> get props => [postIndex];
}

/// 게시글 등록
final class QuestionPostCreateRequested extends PostEvent {
  const QuestionPostCreateRequested({required this.newPost});

  final Post newPost;

  @override
  List<Object?> get props => [newPost];
}
