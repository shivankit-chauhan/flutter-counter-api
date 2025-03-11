import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://letscountapi.com", 
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
  ));

  String _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      return "Connection Timeout. Please check your internet.";
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return "Server took too long to respond.";
    } else if (error.type == DioExceptionType.badResponse) {
      return "Invalid response from server.";
    } else {
      return "Something went wrong. Try again.";
    }
  }

  Future<void> createCounter(String namespace, String counterKey) async {
    try {
      await _dio.post('/$namespace/$counterKey');
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<int> getCounter(String namespace, String counterKey) async {
    try {
      final response = await _dio.get('/$namespace/$counterKey');
      return response.data['count'];
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<void> incrementCounter(String namespace, String counterKey) async {
    try {
      await _dio.post('/$namespace/$counterKey/increment');
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<void> decrementCounter(String namespace, String counterKey) async {
    try {
      await _dio.post('/$namespace/$counterKey/decrement');
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  Future<void> updateCounter(String namespace, String counterKey, int value) async {
    try {
      await _dio.post('/$namespace/$counterKey/update', data: {"value": value});
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }
}
