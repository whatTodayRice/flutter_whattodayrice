import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/models/dormitory.dart';
import 'package:flutter_whattodayrice/providers/dormitory_provider.dart';
import 'package:flutter_whattodayrice/view/components/vo_random_generated_user_name.dart';
import '../screens/home_screen.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class SaveUserInfoButton extends StatelessWidget {
  SaveUserInfoButton({super.key, required this.dormitoryType});

  DormitoryType dormitoryType;

  @override
  Widget build(BuildContext context) {
    final String randomGeneratedUserName = generateRandomNickname();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFFF833D),
      ),
      width: double.infinity,
      height: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(2),
        ),
        onPressed: () {
          final newUser = <String, dynamic>{
            "name": randomGeneratedUserName,
            "dormitoryType": dormitoryType.toString(),
          };

          db.collection("users").add(newUser).then((DocumentReference doc) =>
              print('DocumentSnapshot added with ID: ${doc.id}'));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
        child: Text(
          "다음",
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
