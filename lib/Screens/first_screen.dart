import 'package:flutter/material.dart';
import 'package:test_app/Screens/second_screen.dart';
import 'package:test_app/Theme.dart';
import 'package:test_app/Widgets/custom_textFormField.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController palindromeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  bool isPalindrome(String text) {
    String sanitizedText = text.replaceAll(RegExp(r'\s+'), '').toLowerCase();
    String reversedText = sanitizedText.split('').reversed.join('');
    return sanitizedText == reversedText;
  }

  void showPalindromeDialog(bool isPalindrome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isPalindrome ? 'isPalindrome' : 'not palindrome'),
          // content: Text(isPalindrome
          //     ? 'isPalindrome'
          //     : 'not   palindrome'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> toSecondScreen() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              Container(
                width: 116,
                height: 116,
                margin: const EdgeInsets.only(
                  top: 142,
                  bottom: 50,
                ),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/addIcon.png'))),
              ),
              CustomInputField(
                controller: nameController,
                isLoading: false,
                hint: 'Name',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomInputField(
                controller: palindromeController,
                isLoading: false,
                hint: 'Palindrome',
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: TextButton(
                  onPressed: () {
                    bool result = isPalindrome(palindromeController.text);
                    showPalindromeDialog(result);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: blueColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    'Check',
                    style: whitekTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: TextButton(
                  onPressed: () async {
                    toSecondScreen();
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
          ),
        )
      ],
    );
  }
}
