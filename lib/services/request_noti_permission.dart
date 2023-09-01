// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<void> requestNotificationPermission(BuildContext context) async {
//   final PermissionStatus status = await Permission.notification.request();

//   if (status.isGranted) {
//   } else if (status.isDenied) {
//     if (context.mounted) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('알림 권한이 필요합니다.'),
//           content: const Text('알림을 사용하려면 권한을 부여해야합니다. '),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               // child: const Text('닫기
//             )
//           ],
//         ),
//       );
//     }
//   } else if (status.isPermanentlyDenied) {
//     if (context.mounted) {
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('알림권한이 필요합니다'),
//           content: const Text('알림을 사용하려면 권한을 부여해야합니다. 설정으로 이동하시겠습니다? '),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 openAppSettings();
//               },
//               child: const Text('설정으로 이동'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('닫기'),
//             )
//           ],
//         ),
//       );
//     }
//   }
// }
