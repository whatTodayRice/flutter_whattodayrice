part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

final class PostInitial extends PostState {
  const PostInitial();
}

final class PostLoading extends PostState {
  const PostLoading();
}

final class FreePostLoaded extends PostState {
  final List<Post> itemList;
  final int? nextPage;

  const FreePostLoaded({required this.itemList, this.nextPage});

  @override
  List<Object?> get props => [itemList, nextPage];
}

final class QuestionPostLoaded extends PostState {
  final List<Post> itemList;
  final int? nextPage;

  const QuestionPostLoaded({required this.itemList, this.nextPage});

  @override
  List<Object?> get props => [itemList, nextPage];
}

final class PostError extends PostState {
  final String? errorMessage;

  const PostError({this.errorMessage});
}
