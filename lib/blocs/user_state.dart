part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}
class UserLoading extends UserState {}


class UserLoaded extends UserState {
  final List<dynamic> users;
  final bool hasReachedMax;

  const UserLoaded({required this.users, this.hasReachedMax = false});

  @override
  List<Object?> get props => [users, hasReachedMax];
}


class UserEmpty extends UserState {}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
