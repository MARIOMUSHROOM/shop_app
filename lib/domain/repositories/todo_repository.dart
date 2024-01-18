import 'package:dartz/dartz.dart';
import 'package:shop_app/core/error/failure.dart';
import 'package:shop_app/domain/entities/todo_entity.dart';
import 'package:shop_app/domain/usecases/get_todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, TodoEntity>> getTodo(TodoRequest params);
  Future<Either<Failure, TodoEntity>> getLoadMore(TodoRequest params);
}
