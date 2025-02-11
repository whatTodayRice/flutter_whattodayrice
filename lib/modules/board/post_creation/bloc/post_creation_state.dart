part of 'post_creation_bloc.dart';

abstract class PostCreationState extends Equatable {
  const PostCreationState({
    this.isImageUploaded,
    this.isTitleEmpty,
    this.isContentEmpty,
    this.isPriceEmpty,
    this.isTradeLocationEmpty,
    this.isShared,
    this.postType,
    this.errorMessage,
    this.createdPost,
  });

  final bool? isImageUploaded;
  final bool? isTitleEmpty;
  final bool? isContentEmpty;
  final bool? isPriceEmpty;
  final bool? isTradeLocationEmpty;
  final bool? isShared;
  final PostType? postType;
  final String? errorMessage;
  final Post? createdPost;

  @override
  List<Object?> get props => [
        isImageUploaded,
        isTitleEmpty,
        isContentEmpty,
        isPriceEmpty,
        isTradeLocationEmpty,
        isShared,
        postType,
        errorMessage,
        createdPost,
      ];
}

class PostCreationInitial extends PostCreationState {
  const PostCreationInitial();
}

class PostCreationLoading extends PostCreationState {
  const PostCreationLoading();
}

class PostCreationLoaded extends PostCreationState {
  const PostCreationLoaded({
    super.isImageUploaded,
    super.isTitleEmpty,
    super.isContentEmpty,
    super.isPriceEmpty,
    super.isTradeLocationEmpty,
    super.isShared,
    super.postType,
    super.createdPost,
  });
}

class PostCreationError extends PostCreationState {
  const PostCreationError({super.errorMessage});
}
