import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_whattodayrice/data/models/enum/enum_post_type.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/repository/auth_repository.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'post_creation_event.dart';
part 'post_creation_state.dart';

class PostCreationBloc extends Bloc<PostCreationEvent, PostCreationState> {
  final PostRepository postRepository;
  final AuthRepository authRepository;
  PostType postType;

  PostCreationBloc({
    required this.postRepository,
    required this.authRepository,
    required this.postType,
  }) : super(const PostCreationInitial()) {
    on<PostCreationPostTypeChanged>(_onPostCreationPostTypeChanged);
    on<PostCreationTitleChanged>(_onPostCreationTitleChanged);
    on<PostCreationContentChanged>(_onPostCreationContentChanged);
    on<PostCreationPriceChanged>(_onPostCreationPriceChanged);
    on<PostCreationTradeLocationChanged>(_onPostCreationTradeLocationChanged);
    on<PostCreationTradeTypeChanged>(_onPostCreationTradeStatusChanged);
    on<PostCreationImageUploadRequested>(_onPostCreationImageUploadRequested);
    on<PostCreationRegisterRequested>(_onPostCreationRegisterRequested);
  }

  XFile? imageFile;
  String title = "";
  String content = "";
  String price = "";
  String tradeLocation = "";
  TradeType tradeType = TradeType.sell;

  Future<void> _onPostCreationPostTypeChanged(
    PostCreationPostTypeChanged event,
    Emitter<PostCreationState> emit,
  ) async {
    postType = event.postType;

    emit(PostCreationLoaded(postType: postType));
  }

  Future<void> _onPostCreationTitleChanged(
    PostCreationTitleChanged event,
    Emitter<PostCreationState> emit,
  ) async {
    title = event.title;

    emit(PostCreationLoaded(isTitleEmpty: title.isEmpty, isContentEmpty: content.isEmpty));
  }

  Future<void> _onPostCreationContentChanged(
    PostCreationContentChanged event,
    Emitter<PostCreationState> emit,
  ) async {
    content = event.content;

    emit(PostCreationLoaded(isTitleEmpty: title.isEmpty, isContentEmpty: content.isEmpty));
  }

  Future<void> _onPostCreationPriceChanged(
    PostCreationPriceChanged event,
    Emitter<PostCreationState> emit,
  ) async {
    price = event.price;

    emit(PostCreationLoaded(isPriceEmpty: price.isEmpty));
  }

  Future<void> _onPostCreationTradeLocationChanged(
    PostCreationTradeLocationChanged event,
    Emitter<PostCreationState> emit,
  ) async {
    tradeLocation = event.tradeLocation;

    emit(PostCreationLoaded(isTradeLocationEmpty: tradeLocation.isEmpty));
  }

  Future<void> _onPostCreationTradeStatusChanged(
    PostCreationTradeTypeChanged event,
    Emitter<PostCreationState> emit,
  ) async {
    tradeType = event.tradeType;

    emit(PostCreationLoaded(isShared: tradeType == TradeType.shared));
  }

  Future<void> _onPostCreationImageUploadRequested(
    PostCreationImageUploadRequested event,
    Emitter<PostCreationState> emit,
  ) async {
    imageFile = event.imageFile;

    emit(PostCreationLoaded(isImageUploaded: imageFile != null));
  }

  Future<void> _onPostCreationRegisterRequested(
    PostCreationRegisterRequested event,
    Emitter<PostCreationState> emit,
  ) async {
    final response = await postRepository.addPost(
      postType: postType.name,
      userId: authRepository.userProfile!.id.toString(),
      title: title,
      content: content,
    );

    if (!response.isSucceed) {
      return;
    }

    emit(PostCreationLoaded(createdPost: response.succeedData!));
  }
}
