import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_whattodayrice/presentation/providers/dto_user_info.dart';
import 'package:flutter_whattodayrice/presentation/view/components/vo_random_generated_user_name.dart';
import '../../../data/models/m_user.dart';
import '../../providers/dormitory_provider.dart';
import '../../providers/dto_user_id.dart';
import '../screens/s_completed.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class SaveUserInfoButton extends ConsumerStatefulWidget {
  const SaveUserInfoButton({super.key});

  @override
  ConsumerState<SaveUserInfoButton> createState() => _SaveUserInfoButtonState();
}

class _SaveUserInfoButtonState extends ConsumerState<SaveUserInfoButton> {
  @override
  Widget build(BuildContext context) {
    final String randomGeneratedUserName = generateRandomNickname();
    final dormitoryType = ref.watch(dormitoryProvider);

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
        onPressed: () async {
          ref.watch(userNickNameProvider.notifier).state =
              randomGeneratedUserName;

          final newUser = User(
              name: randomGeneratedUserName,
              dormitoryType: dormitoryType.toString());

          db
              .collection("users")
              .withConverter(
                  fromFirestore: User.fromFirestore,
                  toFirestore: (User user, options) => user.toFirestore())
              .add(newUser)
              .then((DocumentReference doc) async {
            final newUserId = doc.id;
            ref.read(userIdProvider.notifier).state = newUserId;
            saveUserIdToSharedPreferences(newUserId);
            readUserIdSharedPreferencesData();
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CompletedScreen(),
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
