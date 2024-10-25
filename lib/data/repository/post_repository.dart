import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/models/comment.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';

abstract interface class PostRepository {
  /// 게시글
  Future<ApiResponse<List<Post>>> getPosts({
    required int page,
    required String postType,
  });

  Future<ApiResponse<Post>> getPost({required String postId});

  Future<ApiResponse<Post>> addPost({
    required String userId,
    required String postType,
    required String title,
    required String content,
  });

  Future<ApiResponse> deletePost({required String postId});

  /// 댓글
  Future<ApiResponse<List<Comment>>> getComments({required int page, required String postId});

  Future<ApiResponse<Comment>> addComment({
    required String userId,
    required String postId,
    required String content,
  });

  Future<ApiResponse> deleteComment({required String commentId});
}
