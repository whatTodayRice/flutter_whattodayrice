import 'package:flutter/material.dart';
import 'constants.dart';

class ReusableNextButton extends StatelessWidget {
  const ReusableNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.pushNamed(context, '/main');
      // },
      child: Container(
        height: 50.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(child: kStartText),
      ),
    );
  }
}
