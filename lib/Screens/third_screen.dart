import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/Theme.dart';
import 'package:test_app/blocs/user_bloc.dart';
import 'package:test_app/models/user_model.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() {
    final userBloc = BlocProvider.of<UserBloc>(context);
    userBloc.add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text('Third Screen',
            style: blackTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: blueColor,
          ),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            if (state.users.isEmpty) {
              return Center(
                child: Text('No users found.'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: state.hasReachedMax
                  ? state.users.length
                  : state.users.length + 1,
              itemBuilder: (context, index) {
                if (index >= state.users.length) {
                  _fetchUsers(); // Load next page
                  return Center(child: CircularProgressIndicator());
                }
                final user = state.users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  title: Text(
                    '${user.firstName} ${user.lastName}',
                    style:
                        blackTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                  ),
                  subtitle: Text(
                    user.email,
                    style: blackTextStyle.copyWith(fontSize: 12),
                  ),
                  onTap: () {
                    Navigator.pop(context, user);
                  },
                );
              },
            );
          } else if (state is UserError) {
            return Center(
              child: Text('Failed to load users: ${state.message}'),
            );
          }
          return Center(child: Text('Something went wrong.'));
        },
      ),
    );
  }
}
