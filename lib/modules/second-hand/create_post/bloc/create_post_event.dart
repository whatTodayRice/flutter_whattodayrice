part of 'create_post_bloc.dart';

sealed class CreatePostEvent extends Equatable {
  const CreatePostEvent();

  @override
  List<Object?> get props => [];
}

/// 제목 변경
final class CreatePostTitleChangeRequested extends CreatePostEvent {
  const CreatePostTitleChangeRequested({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}

/// 판매 유형 변경
enum ProductPriceType { sell, share }

final class CreatePostPriceTypeChangeRequested extends CreatePostEvent {
  const CreatePostPriceTypeChangeRequested({required this.typeIndex});

  final int typeIndex;

  @override
  List<Object?> get props => [typeIndex];
}

/// 가격 변경
final class CreatePostPriceChangeRequested extends CreatePostEvent {
  const CreatePostPriceChangeRequested({required this.price});

  final String price;

  @override
  List<Object?> get props => [price];
}

/// 상품 설명
final class CreatePostContentChangeRequested extends CreatePostEvent {
  const CreatePostContentChangeRequested({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}

/// 거래 희망 장소 변경
final class CreatePostTradeLocationChangeRequested extends CreatePostEvent {
  const CreatePostTradeLocationChangeRequested({required this.location});

  final String location;

  @override
  List<Object?> get props => [location];
}

/// 이미지 추가
final class CreatePostImageUrlChangeRequested extends CreatePostEvent {
  const CreatePostImageUrlChangeRequested({required this.imageUrl});

  final String imageUrl;

  @override
  List<Object?> get props => [imageUrl];
}

/// 글 작성 완료
final class CreatePostSubmitRequested extends CreatePostEvent {
  const CreatePostSubmitRequested();
}
