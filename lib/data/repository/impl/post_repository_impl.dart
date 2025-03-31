import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/post_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/models/comment.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/requests/create_post_request.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;

  PostRepositoryImpl({
    required this.postRemoteDataSource,
  });

  final int pageSize = 20;

  @override
  Future<ApiResponse<Comment>> addComment({required String userId, required String postId, required String content}) {
    // TODO: implement addComment
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> deleteComment({required String commentId}) {
    // TODO: implement deleteComment
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse> deletePost({required String postId}) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<List<Comment>>> getComments({required int page, required String postId}) {
    // TODO: implement getComments
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<Post>> getPost({required String postId}) {
    // TODO: implement getPost
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<List<Post>>> getPosts({required int page, required String postType}) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<bool?>> createPost({required CreatePostRequest request}) =>
      postRemoteDataSource.createPost(request: request);
}
