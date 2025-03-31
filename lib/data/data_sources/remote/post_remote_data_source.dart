import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/requests/create_post_request.dart';
import 'package:flutter_whattodayrice/utils/log/logger.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class PostRemoteDataSource {
  final db = FirebaseFirestore.instance;

  PostRemoteDataSource();

  Future<ApiResponse<Post>> getPost({required String id}) async {
    try {
      final docSnap = await db.collection('posts').doc(id).get();

      final postDoc = docSnap.data();

      return SucceedResponse(
        Post(
          postId: id,
          title: postDoc?['title'],
          content: postDoc?['content'],
          price: postDoc?['price'],
          isShared: postDoc?['isShared'],
          location: postDoc?['location'],
          createdAt: postDoc?['created_at'],
        ),
      );
    } catch (e) {
      Log.i('getPost 실패 $e');

      return const UnknownException();
    }
  }

  Future<ApiResponse<bool?>> createPost({required CreatePostRequest request}) async {
    try {
      Map<String, dynamic> requestJson = request.toJson();
      requestJson['created_at'] = FieldValue.serverTimestamp();

      await db.collection('posts').doc().set(requestJson);

      Log.i('중고 거래 글 등록 성공 $requestJson');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('중고 거래 글 등록 실패 $e');

      return const ServerException(message: '일시적으로 문제가 생겼어요.\n잠시 후 다시 시도해주세요.');
    }
  }
}
