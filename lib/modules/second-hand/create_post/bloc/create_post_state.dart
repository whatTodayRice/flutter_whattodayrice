part of 'create_post_bloc.dart';

sealed class CreatePostState extends Equatable {
  const CreatePostState();

  @override
  List<Object?> get props => [];
}

final class CreatePostInitial extends CreatePostState {
  const CreatePostInitial();
}

final class CreatePostError extends CreatePostState {
  const CreatePostError({this.errorMessage});

  final String? errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}

final class CreatePostLoading extends CreatePostState {
  const CreatePostLoading();
}

final class CreatePostSucceed extends CreatePostState {
  const CreatePostSucceed();
}

final class CreatePostSelectedSellTypeChecked extends CreatePostState {
  const CreatePostSelectedSellTypeChecked({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}

final class CreatePostSubmitValidationChecked extends CreatePostState {
  const CreatePostSubmitValidationChecked({required this.isValid});

  final bool isValid;

  @override
  List<Object?> get props => [isValid];
}

final class CreatePostImageUploadChecked extends CreatePostState {
  const CreatePostImageUploadChecked({required this.imageUrl});

  final String imageUrl;

  @override
  List<Object?> get props => [imageUrl];
}
