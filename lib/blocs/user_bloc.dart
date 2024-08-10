import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:test_app/Services/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository; // Add this line
  int currentPage = 1;
  bool isFetching = false;

  // Modify the constructor to accept UserRepository
  UserBloc({required this.userRepository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
    on<RefreshUsers>(_onRefreshUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    if (isFetching) return;
    isFetching = true;

    try {
      // Use the userRepository to fetch users
      final response = await userRepository.fetchUsers(page: currentPage);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> users = data['data'];

        if (users.isEmpty && currentPage == 1) {
          emit(UserEmpty());
        } else {
          emit(UserLoaded(
              users:
                  event.append ? (state as UserLoaded).users + users : users));
          currentPage++;
        }
      } else {
        emit(UserError('Failed to load users'));
      }
    } catch (e) {
      emit(UserError('An error occurred while fetching users.'));
    } finally {
      isFetching = false;
    }
  }

  Future<void> _onRefreshUsers(
      RefreshUsers event, Emitter<UserState> emit) async {
    currentPage = 1;
    add(FetchUsers(append: false));
  }
}
