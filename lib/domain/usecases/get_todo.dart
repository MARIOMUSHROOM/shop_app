import 'package:dartz/dartz.dart';
import 'package:shop_app/core/error/failure.dart';
import 'package:shop_app/domain/entities/todo_entity.dart';
import 'package:shop_app/domain/repositories/todo_repository.dart';

class TodoRequest {
  TodoRequest(
    this.status, {
    this.offset,
    this.limit,
    this.sort,
    this.asc,
  });
  String status;
  int? offset;
  int? limit;
  String? sort;
  bool? asc;
}

class GetTodoUseCase {
  final TodoRepository todoRepository;
  GetTodoUseCase(this.todoRepository);
  Future<Either<Failure, TodoEntity>> execute(TodoRequest params) {
    return todoRepository.getTodo(params);
  }
}

class GetLoadMoreUseCase {
  final TodoRepository todoRepository;
  GetLoadMoreUseCase(this.todoRepository);
  Future<Either<Failure, TodoEntity>> execute(TodoRequest params) {
    return todoRepository.getTodo(params);
  }
}