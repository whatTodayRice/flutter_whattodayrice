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
  const CreatePostError();
}

final class CreatePostLoading extends CreatePostState {
  const CreatePostLoading();
}

final class CreatePostLoaded extends CreatePostState {
  const CreatePostLoaded();
}
