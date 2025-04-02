import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/requests/create_post_request.dart';

abstract interface class PostRepository {
  /// 게시글
  Future<ApiResponse<List<Post>>> getPosts({int? perPage, int? page, String? lastDocId});

  Future<ApiResponse<Post>> getPost({required String postId});

  Future<ApiResponse<bool?>> createPost({required CreatePostRequest request});

  Future<ApiResponse> deletePost({required String postId});

  Future<ApiResponse> updatePostSellStatus({required String postId, required int sellStatus});

  /// 댓글
  Future<ApiResponse<List<Post>>> getComments({required int page, required String postId});

  Future<ApiResponse> createComment({required CreatePostRequest request});

  Future<ApiResponse> deleteComment({required String parentPostId, required String commentId});
}
