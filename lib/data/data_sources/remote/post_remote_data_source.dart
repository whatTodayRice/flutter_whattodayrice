import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/services/supabase_service.dart';
import 'package:flutter_whattodayrice/data/models/comment.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/requests/supabase_request.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class PostRemoteDataSource {
  final SupabaseService supabaseService;

  PostRemoteDataSource({required this.supabaseService});

  final int pageSize = 20;

  /// 게시글
  Future<ApiResponse<List<Post>>> getPosts({
    required int page,
    required String postType,
  }) async {
    final offset = (page - 1) * pageSize;

    final SupabaseRequest request = SupabaseRequest(
      function: "get_posts_with_user_info_and_comment_count",
      params: {
        "p_post_type": postType,
        "p_limit": pageSize,
        "p_offset": offset,
      },
    );

    return await supabaseService.callListFunction(
      request: request,
      fromJson: Post.fromJson,
    );
  }

  Future<ApiResponse<Post>> getPost({required SupabaseRequest request}) => supabaseService.getRecord(
        request: request,
        fromJson: Post.fromJson,
      );

  Future<ApiResponse<Post>> addPost({
    required String postType,
    required String userId,
    required String title,
    required String content,
  }) async {
    final SupabaseRequest request = SupabaseRequest(
      table: "posts",
      data: {"user_id": userId, "type": postType, "title": title, "content": content},
    );

    return await supabaseService.insertRecord(
      request: request,
      fromJson: Post.fromJson,
    );
  }

  Future<ApiResponse> deletePost({required SupabaseRequest request}) => supabaseService.deleteRecord(
        request: request,
      );

  /// 댓글 get_comments_with_replies
  Future<ApiResponse<List<Comment>>> getComments({
    required String postId,
    required int page,
  }) async {
    final offset = (page - 1) * pageSize;

    final SupabaseRequest request = SupabaseRequest(
      function: "get_comments_with_replies",
      params: {
        "p_post_id": postId,
        "p_offset": offset,
        "p_limit": pageSize,
      },
    );

    final response = await supabaseService.callListFunction(
      request: request,
      fromJson: Comment.fromJson,
    );

    return response;
  }

  Future<ApiResponse<Comment>> addComment({
    required String userId,
    required String postId,
    required String content,
  }) async {
    final SupabaseRequest request = SupabaseRequest(
      function: "add_comment_with_user_info",
      params: {
        "p_user_id": userId,
        "p_post_id": postId,
        "p_content": content,
      },
    );

    return await supabaseService.callSingleFunction(
      request: request,
      fromJson: Comment.fromJson,
    );
  }

  Future<ApiResponse> deleteComment({required SupabaseRequest request}) => supabaseService.deleteRecord(
        request: request,
      );
}
