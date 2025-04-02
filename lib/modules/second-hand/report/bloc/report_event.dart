part of 'report_bloc.dart';

sealed class ReportEvent extends Equatable {
  const ReportEvent();

  @override
  List<Object?> get props => [];
}

final class ReportLoadRequested extends ReportEvent {
  const ReportLoadRequested();
}

final class ReportReasonSelectRequested extends ReportEvent {
  const ReportReasonSelectRequested({required this.index});

  final int index;

  @override
  List<Object?> get props => [index];
}

final class ReportReasonContentChangeRequested extends ReportEvent {
  const ReportReasonContentChangeRequested({required this.content});

  final String content;

  @override
  List<Object?> get props => [content];
}

final class ReportSubmitRequested extends ReportEvent {
  const ReportSubmitRequested();
}
