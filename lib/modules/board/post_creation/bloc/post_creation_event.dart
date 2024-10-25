part of 'post_creation_bloc.dart';

sealed class PostCreationEvent extends Equatable {
  const PostCreationEvent();

  @override
  List<Object?> get props => [];
}

final class PostCreationPostTypeChanged extends PostCreationEvent {
  const PostCreationPostTypeChanged({required this.postType});

  final PostType postType;
}

final class PostCreationTitleChanged extends PostCreationEvent {
  const PostCreationTitleChanged({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}

final class PostCreationContentChanged extends PostCreationEvent {
  const PostCreationContentChanged({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}

final class PostCreationPriceChanged extends PostCreationEvent {
  const PostCreationPriceChanged({required this.price});

  final String price;
}

final class PostCreationTradeLocationChanged extends PostCreationEvent {
  const PostCreationTradeLocationChanged({required this.tradeLocation});

  final String tradeLocation;
}

final class PostCreationTradeTypeChanged extends PostCreationEvent {
  const PostCreationTradeTypeChanged({required this.tradeType});

  final TradeType tradeType;
}

final class PostCreationImageUploadRequested extends PostCreationEvent {
  const PostCreationImageUploadRequested({this.imageFile});

  final XFile? imageFile;
}

final class PostCreationRegisterRequested extends PostCreationEvent {
  const PostCreationRegisterRequested();
}
