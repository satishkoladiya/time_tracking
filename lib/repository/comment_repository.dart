import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_tracking/config/constants.dart';
import 'package:time_tracking/data/comment.dart';
import 'package:time_tracking/service/http_client.dart';

final commentRepositoryProvider =
    Provider((ref) => CommentRepository(ref.watch(httpClientProvider)));

class CommentRepository {
  final Dio httpClient;

  CommentRepository(this.httpClient);
  Future<List<Comment>> getComments({
    required String taskId,
  }) async {
    final path = Uri(
      path: '${Constants.apiV2Path}/comments',
      queryParameters: {
        'task_id': taskId,
      },
    );

    final result = await httpClient.getUri<List>(path);

    return Comment.fromList(result.data!.cast<Map<String, dynamic>>());
  }

  Future<Comment> createComment({
    required String taskId,
    required String content,
  }) async {
    final path = Uri(
      path: '${Constants.apiV2Path}/comments',
      queryParameters: {
        'task_id': taskId,
        'content': content,
      },
    );

    final result = await httpClient.postUri<Map>(path);

    return Comment.fromMap(result.data!.cast<String, dynamic>());
  }
}
