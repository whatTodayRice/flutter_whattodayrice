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

  Future<ApiResponse<List<Post>>> getPostList({
    int? perPage = 20,
    int? page = 1,
    String? lastDocId,
  }) async {
    try {
      Query<Map<String, dynamic>> query =
          db.collection('posts').orderBy('created_at', descending: true).limit(perPage ?? 20);

      QuerySnapshot<Map<String, dynamic>> querySnapshot;

      List<Post> postList = [];

      if (lastDocId == null) {
        querySnapshot = await query.get();
      } else {
        querySnapshot = await query.startAfter([lastDocId]).get();
      }

      for (int i = 0; i < querySnapshot.docs.length; i++) {
        final documentSnapShot = querySnapshot.docs[i];

        postList.add(Post.fromFireStore(documentSnapShot));
      }

      return SucceedResponse(postList);
    } catch (e) {
      Log.i('getPostList 실패 $e');

      return const UnknownException();
    }
  }

  Future<ApiResponse<Post>> getPost({required String id}) async {
    try {
      final docSnap = await db.collection('posts').doc(id).get();

      return SucceedResponse(Post.fromFireStore(docSnap));
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
