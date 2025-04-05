import 'package:flutter_whattodayrice/data/data_sources/remote/core/api_response.dart';
import 'package:flutter_whattodayrice/data/data_sources/remote/post_remote_data_source.dart';
import 'package:flutter_whattodayrice/data/models/post.dart';
import 'package:flutter_whattodayrice/data/models/requests/create_post_request.dart';
import 'package:flutter_whattodayrice/data/models/requests/report_post_request.dart';
import 'package:flutter_whattodayrice/data/repository/post_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;

  PostRepositoryImpl({required this.postRemoteDataSource});

  final int pageSize = 20;

  @override
  Future<ApiResponse> deleteComment({required String parentPostId, required String commentId}) =>
      postRemoteDataSource.deleteComment(parentPostId: parentPostId, commentId: commentId);

  @override
  Future<ApiResponse> deletePost({required String postId}) => postRemoteDataSource.deletePost(postId: postId);

  @override
  Future<ApiResponse<List<Post>>> getComments({required int page, required String postId}) {
    // TODO: implement getComments
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<Post>> getPost({required String postId}) => postRemoteDataSource.getPost(id: postId);

  @override
  Future<ApiResponse<List<Post>>> getPosts({int? perPage, int? page, String? lastDocId}) =>
      postRemoteDataSource.getPostList(perPage: page, page: page, lastDocId: lastDocId);

  @override
  Future<ApiResponse<bool?>> createPost({required CreatePostRequest request}) =>
      postRemoteDataSource.createPost(request: request);

  @override
  Future<ApiResponse> updatePostSellStatus({required String postId, required int sellStatus}) =>
      postRemoteDataSource.updatePostSellStatus(postId: postId, sellStatus: sellStatus);

  @override
  Future<ApiResponse> createComment({required CreatePostRequest request}) =>
      postRemoteDataSource.createComment(request: request);

  @override
  Future<ApiResponse> reportPost({required ReportPostRequest request}) =>
      postRemoteDataSource.reportPost(request: request);

  @override
  Future<ApiResponse<List<Post>>> getMyPostList({
    required int userId,
    int? perPage = 20,
    int? page = 1,
    String? lastDocId,
  }) =>
      postRemoteDataSource.getMyPostList(userId: userId, perPage: perPage, lastDocId: lastDocId);
}
