import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo_api/models/todo_model.dart';

class TodoApiServices {
  final url = 'https://65603d6483aba11d99d0722c.mockapi.io/Notes';
  final Dio dio = Dio();

  Future<List<TodoModel>> getTodo() async {
    final Response<List<dynamic>> res = await dio.get(url);

    try {
      if (res.statusCode == 200) {
        final List<dynamic> data = res.data ?? [];
        return data.map((item) {
          return TodoModel.fromJson(item);
        }).toList();
      } else {
        throw Exception('failed');
      }
    } catch (e) {
      throw Exception('failed $e');
    }
  }

  Future<TodoModel> createTodo(TodoModel value) async {
    try {
      final result = await dio.post(url, data: value.toJson());
      if (result.statusCode == 201) {
        final response = result.data;
        return TodoModel.fromJson(response);
      } else {
        throw Exception('data error ');
      }
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
