part of 'report_bloc.dart';

sealed class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object?> get props => [];
}

final class ReportInitial extends ReportState {
  const ReportInitial();
}

final class ReportLoading extends ReportState {
  const ReportLoading();
}

final class ReportError extends ReportState {
  const ReportError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}

final class ReportLoaded extends ReportState {
  const ReportLoaded({required this.reportReasonList, this.selectedIndex});

  final List<String> reportReasonList;
  final int? selectedIndex;

  @override
  List<Object?> get props => [reportReasonList, selectedIndex];
}

final class ReportSubmitValidationChecked extends ReportState {
  const ReportSubmitValidationChecked({required this.isValid});

  final bool isValid;

  @override
  List<Object?> get props => [isValid];
}

final class ReportSubmitSucceed extends ReportState {
  const ReportSubmitSucceed();
}
