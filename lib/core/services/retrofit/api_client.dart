import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:test_android_flutter/core/constants/constants.dart';
import 'package:test_android_flutter/core/models/post.dart';
import 'package:test_android_flutter/core/models/user.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  @GET("/users")
  Future<List<User>> getUsers();

  @GET("/posts")
  Future<List<Post>> getPosts();
}
