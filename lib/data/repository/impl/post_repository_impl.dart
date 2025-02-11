import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/post_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/models/comment.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/requests/supabase_request.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;

  PostRepositoryImpl({
    required this.postRemoteDataSource,
  });

  final int pageSize = 20;

  /// 게시글
  @override
  Future<ApiResponse<List<Post>>> getPosts({required int page, required String postType}) =>
      postRemoteDataSource.getPosts(
        postType: postType,
        page: page,
      );

  @override
  Future<ApiResponse<Post>> getPost({required String postId}) async {
    final SupabaseRequest request = SupabaseRequest(
      table: "posts",
      columnValue: [postId],
    );

    return await postRemoteDataSource.getPost(request: request);
  }

  @override
  Future<ApiResponse<Post>> addPost({
    required String postType,
    required String title,
    required String content,
    required String userId,
  }) =>
      postRemoteDataSource.addPost(
        postType: postType,
        title: title,
        content: content,
        userId: userId,
      );

  @override
  Future<ApiResponse> deletePost({required String postId}) async {
    final SupabaseRequest request = SupabaseRequest(table: "posts", columnValue: [postId]);

    return await postRemoteDataSource.deletePost(request: request);
  }

  /// 댓글
  @override
  Future<ApiResponse<List<Comment>>> getComments({
    required int page,
    required String postId,
  }) =>
      postRemoteDataSource.getComments(postId: postId, page: page);

  @override
  Future<ApiResponse<Comment>> addComment({
    required String userId,
    required String postId,
    required String content,
  }) =>
      postRemoteDataSource.addComment(
        userId: userId,
        postId: postId,
        content: content,
      );

  @override
  Future<ApiResponse> deleteComment({required String commentId}) async {
    final SupabaseRequest request = SupabaseRequest(
      table: "comments",
      columns: ["id"],
      columnValue: [commentId],
    );

    return await postRemoteDataSource.deleteComment(request: request);
  }
}
