import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/requests/create_post_request.dart';
import 'package:flutter_whattodayrice/data/models/requests/report_post_request.dart';
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

      return const ServerException();
    }
  }

  Future<ApiResponse<Post>> getPost({required String id}) async {
    try {
      final postDoc = await db.collection('posts').doc(id).get();
      final commentsDocs = await db.collection('posts').doc(id).collection('comments').orderBy('created_at').get();

      return SucceedResponse(Post.fromFireStore(postDoc, querySnapshot: commentsDocs));
    } catch (e) {
      Log.i('getPost 실패 $e');

      return const UnknownException();
    }
  }

  Future<ApiResponse<bool?>> createPost({required CreatePostRequest request}) async {
    try {
      Map<String, dynamic> requestJson = request.toJson();

      final postDocRef = db.collection('posts');

      final generatedDocId = postDocRef.doc().id;

      requestJson['id'] = generatedDocId;
      requestJson['created_at'] = FieldValue.serverTimestamp();

      await postDocRef.doc(generatedDocId).set(requestJson);

      Log.i('중고 거래 글 등록 성공 $requestJson');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('중고 거래 글 등록 실패 $e');

      return const ServerException();
    }
  }

  Future<ApiResponse> updatePostSellStatus({required String postId, required int sellStatus}) async {
    try {
      await db.collection('posts').doc(postId).update({'sell_status': sellStatus});

      Log.i('중고 거래 판매 상태 변경 성공 $postId: $sellStatus');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('중고 거래 판매 상태 변경 실패 $postId: $sellStatus');

      return const ServerException();
    }
  }

  Future<ApiResponse> deletePost({required String postId}) async {
    try {
      await db.collection('posts').doc(postId).delete();

      Log.i('중고 거래 글 $postId 삭제 성공');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('중고 거래 글 $postId 삭제 성공');

      return const ServerException();
    }
  }

  Future<ApiResponse> createComment({required CreatePostRequest request}) async {
    try {
      Map<String, dynamic> requestJson = request.toJson();

      final commentsRef = db.collection('posts').doc(request.parentPostId).collection('comments');
      final generatedDocId = commentsRef.doc().id;
      final createdAt = FieldValue.serverTimestamp();

      requestJson['id'] = generatedDocId;
      requestJson['created_at'] = createdAt;

      await commentsRef.doc(generatedDocId).set(requestJson);

      Log.i('중고 거래 댓글 등록 성공\n게시글 Id: ${request.parentPostId}, 댓글 documentId: $generatedDocId');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('중고 거래 댓글 등록 실패\n게시글 Id: ${request.parentPostId}');

      return const ServerException();
    }
  }

  Future<ApiResponse> deleteComment({required String parentPostId, required String commentId}) async {
    try {
      await db.collection('posts').doc(parentPostId).collection('comments').doc(commentId).delete();

      Log.i('중고 거래 댓글 삭제 성공: 게시글 $parentPostId / 댓글 $commentId');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('중고 거래 댓글 삭제 실패: 게시글 $parentPostId / 댓글 $commentId');

      return const ServerException();
    }
  }

  Future<ApiResponse> reportPost({required ReportPostRequest request}) async {
    try {
      await db.collection('reports').doc().set(request.toJson());

      Log.i('중고 거래 글 신고 성공: 게시글 ${request.postId} / 댓글 ${request.commentId}');

      return const SucceedResponse(true);
    } catch (e) {
      Log.i('중고 거래 글 신고 실패: 게시글 ${request.postId} / 댓글 ${request.commentId}');

      return const ServerException();
    }
  }
}
