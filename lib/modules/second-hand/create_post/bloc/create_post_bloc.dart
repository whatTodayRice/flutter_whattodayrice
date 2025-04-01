import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_whattodayrice/data/models/requests/create_post_request.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final UserRepository userRepository;
  final PostRepository postRepository;

  CreatePostBloc({
    required this.userRepository,
    required this.postRepository,
  }) : super(const CreatePostInitial()) {
    on<CreatePostTitleChangeRequested>(_onCreatePostTitleChangeRequested);
    on<CreatePostPriceTypeChangeRequested>(_onCreatePostPriceTypeChangeRequested);
    on<CreatePostPriceChangeRequested>(_onCreatePostPriceChangeRequested);
    on<CreatePostContentChangeRequested>(_onCreatePostContentChangeRequested);
    on<CreatePostTradeLocationChangeRequested>(_onCreatePostTradeLocationChangeRequested);
    on<CreatePostImageUrlChangeRequested>(_onCreatePostImageUrlChangeRequested);
    on<CreatePostSubmitRequested>(_onCreatePostSubmitRequested);
  }

  String title = '';
  int? price;
  int productTypeIndex = ProductPriceType.sell.index;
  String content = '';
  String location = '';
  String imageUrl = '';

  FutureOr<void> _onCreatePostTitleChangeRequested(
    CreatePostTitleChangeRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    title = event.title;

    emit(CreatePostSubmitValidationChecked(isValid: isSubmitConditionValid()));
  }

  FutureOr<void> _onCreatePostPriceTypeChangeRequested(
    CreatePostPriceTypeChangeRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    productTypeIndex = event.typeIndex;

    emit(CreatePostSelectedSellTypeChecked(index: productTypeIndex));
  }

  FutureOr<void> _onCreatePostPriceChangeRequested(
    CreatePostPriceChangeRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    final value = int.tryParse(event.price.replaceAll(',', ''));

    if (value == null) {
      return;
    }

    price = value;

    emit(CreatePostSubmitValidationChecked(isValid: isSubmitConditionValid()));
  }

  FutureOr<void> _onCreatePostContentChangeRequested(
    CreatePostContentChangeRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    content = event.content;

    emit(CreatePostSubmitValidationChecked(isValid: isSubmitConditionValid()));
  }

  FutureOr<void> _onCreatePostTradeLocationChangeRequested(
    CreatePostTradeLocationChangeRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    location = event.location;

    emit(CreatePostSubmitValidationChecked(isValid: isSubmitConditionValid()));
  }

  FutureOr<void> _onCreatePostImageUrlChangeRequested(
    CreatePostImageUrlChangeRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    imageUrl = event.imageUrl;

    emit(CreatePostImageUploadChecked(imageUrl: imageUrl));
  }

  FutureOr<void> _onCreatePostSubmitRequested(
    CreatePostSubmitRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    emit(const CreatePostLoading());

    final userProfile = userRepository.getUserProfileFromCache();

    if (userProfile == null) {
      return;
    }

    final request = CreatePostRequest(
      userId: userProfile.id,
      nickname: userProfile.nickname,
      imageUrl: imageUrl.isEmpty ? null : imageUrl,
      title: title,
      price: price,
      isShared: productTypeIndex == ProductPriceType.share.index,
      location: location,
    );

    final result = await postRepository.createPost(request: request);

    if (result.isSucceed != true) {
      emit(CreatePostError(errorMessage: result.errorMessage));

      return;
    }

    emit(const CreatePostSucceed());
  }

  bool isSubmitConditionValid() {
    if (title.isNotEmpty != true) {
      return false;
    }

    if (productTypeIndex == ProductPriceType.sell.index && price == null) {
      return false;
    }

    if (content.isNotEmpty != true) {
      return false;
    }

    if (location.isNotEmpty != true) {
      return false;
    }

    return true;
  }
}
