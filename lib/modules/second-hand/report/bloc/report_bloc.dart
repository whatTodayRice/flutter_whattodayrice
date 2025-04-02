import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_whattodayrice/data/models/requests/report_post_request.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:flutter_whattodayrice/data/repository/user_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

enum ReportType {
  prohibit('거래 금지 물품으로 판단돼요.'),
  fraud('사기가 의심돼요.'),
  professional('전문 업자 같아요.'),
  inAccurate('상품정보가 부정확해요.'),
  ad('광고성 콘텐츠예요.'),
  etc('기타');

  final String displayValue;

  const ReportType(this.displayValue);
}

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final PostRepository postRepository;
  final UserRepository userRepository;

  final String postId;
  final String? commentId;

  ReportBloc({required this.postRepository, required this.userRepository, required this.postId, this.commentId})
      : super(const ReportInitial()) {
    on<ReportLoadRequested>(_onReportLoadRequested);
    on<ReportReasonSelectRequested>(_onReportReasonSelectRequested);
    on<ReportReasonContentChangeRequested>(_onReportReasonContentChangeRequested);
    on<ReportSubmitRequested>(_onReportSubmitRequested);
  }

  int? selectedIndex;
  String content = '';

  FutureOr<void> _onReportLoadRequested(
    ReportLoadRequested event,
    Emitter<ReportState> emit,
  ) async {
    emit(const ReportLoading());

    emit(ReportLoaded(
      reportReasonList: [...ReportType.values.map((type) => type.displayValue)],
      selectedIndex: selectedIndex,
    ));
  }

  FutureOr<void> _onReportReasonSelectRequested(
    ReportReasonSelectRequested event,
    Emitter<ReportState> emit,
  ) async {
    emit(const ReportLoading());

    if (selectedIndex == event.index) {
      selectedIndex = null;
    } else {
      selectedIndex = event.index;
    }

    emit(ReportLoaded(
      reportReasonList: [...ReportType.values.map((type) => type.displayValue)],
      selectedIndex: selectedIndex,
    ));

    emit(ReportSubmitValidationChecked(isValid: selectedIndex != null));
  }

  FutureOr<void> _onReportReasonContentChangeRequested(
    ReportReasonContentChangeRequested event,
    Emitter<ReportState> emit,
  ) async {
    content = event.content;
  }

  FutureOr<void> _onReportSubmitRequested(
    ReportSubmitRequested event,
    Emitter<ReportState> emit,
  ) async {
    if (postId.isNotEmpty != true) {
      return;
    }

    final userId = userRepository.getUserProfileFromCache()?.id;

    if (userId == null) {
      return;
    }

    emit(const ReportLoading());

    final request = ReportPostRequest(
      writerId: userId,
      postId: postId,
      commentId: commentId,
      reasonTypeIndex: selectedIndex,
      detailReason: content,
    );

    final response = await postRepository.reportPost(request: request);

    if (response.isSucceed != true) {
      emit(ReportError(message: response.errorMessage));

      return;
    }

    emit(const ReportSubmitSucceed());
  }
}
