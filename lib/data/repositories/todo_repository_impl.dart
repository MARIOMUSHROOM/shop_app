import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:shop_app/core/error/exception.dart';
import 'package:shop_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_app/data/data_source/todo_data_source.dart';
import 'package:shop_app/data/model/todo_model.dart';
import 'package:shop_app/domain/entities/todo_entity.dart';
import 'package:shop_app/domain/repositories/todo_repository.dart';
import 'package:shop_app/domain/usecases/get_todo.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoDataSource todoDataSource;
  TodoRepositoryImpl({required this.todoDataSource});

  @override
  Future<Either<Failure, TodoModel>> getTodo(TodoRequest params) async {
    try {
      final result = await todoDataSource.getTodo(params);
      if (result.statusCode == 200) {
        var only = TodoModel.fromJson(json.decode(result.body));
        return Right(only);
      } else {
        throw ServerException();
      }
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TodoModel>> getLoadMore(TodoRequest params) async {
    try {
      final result = await todoDataSource.getTodo(params);
      if (result.statusCode == 200) {
        var only = TodoModel.fromJson(json.decode(result.body));
        return Right(only);
      } else {
        throw ServerException();
      }
    } on ServerException {
      return const Left(ServerFailure('An error has occurred'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
