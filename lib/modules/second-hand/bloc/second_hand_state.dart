part of 'second_hand_bloc.dart';

sealed class SecondHandState extends Equatable {
  const SecondHandState();

  @override
  List<Object?> get props => [];
}

final class SecondHandInitial extends SecondHandState {
  const SecondHandInitial();
}

final class SecondHandError extends SecondHandState {
  const SecondHandError();
}

final class SecondHandLoading extends SecondHandState {
  const SecondHandLoading();
}

final class SecondHandLoaded extends SecondHandState {
  const SecondHandLoaded({required this.itemList, required this.nextPageKey});

  final List<Post> itemList;
  final String? nextPageKey;

  @override
  List<Object?> get props => [itemList, nextPageKey];
}
