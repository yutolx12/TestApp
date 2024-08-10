import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/Screens/first_screen.dart';
import 'package:test_app/blocs/user_bloc.dart';
import 'package:test_app/Services/user_repository.dart';
import 'Screens/second_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(userRepository: userRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Test App',
        home: FirstScreen(),
      ),
    );
  }
}
