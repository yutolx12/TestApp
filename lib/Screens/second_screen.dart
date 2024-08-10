import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/blocs/user_bloc.dart';
import 'third_screen.dart';
import 'package:test_app/Theme.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> toThirdScreen() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<UserBloc>(context),
          child: ThirdScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Text('Second Screen',
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
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 13,
                ),
                Text(
                  'Welcome',
                  style:
                      blackTextStyle.copyWith(fontWeight: light, fontSize: 12),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  'John Doe',
                  style:
                      blackTextStyle.copyWith(fontWeight: bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 222,
                ),
                Center(
                  child: Text(
                    'Selected User Name',
                    style:
                        blackTextStyle.copyWith(fontWeight: bold, fontSize: 24),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 200,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: TextButton(
                onPressed: () async {
                  toThirdScreen();
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: blueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  'Next',
                  style: whitekTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
