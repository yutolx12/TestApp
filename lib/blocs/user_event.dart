part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent {
  final bool append;

  FetchUsers({this.append = false});

  @override
  List<Object?> get props => [append];
}

class RefreshUsers extends UserEvent {}
