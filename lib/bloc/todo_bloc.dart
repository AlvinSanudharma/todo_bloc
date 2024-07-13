import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState([], TodoStatus.init)) {
    on<OnAddTodo>(addTodo);

    on<OnUpdateTodo>((event, emit) async {
      Todo newTodo = event.newTodo;
      int index = event.index;

      List<Todo> todosUpdated = state.todos;

      todosUpdated[index] = newTodo;

      emit(TodoState(todosUpdated, TodoStatus.success));
    });

    on<OnRemoveTodo>((event, emit) async {
      int index = event.index;

      List<Todo> todosRemoved = state.todos;

      todosRemoved.removeAt(index);

      emit(TodoState(todosRemoved, TodoStatus.success));
    });

    on<OnFetchTodo>((event, emit) async {
      emit(TodoState(state.todos, TodoStatus.loading));

      await Future.delayed(
        const Duration(milliseconds: 1500),
      );

      emit(TodoState(
          [Todo(title: 'Senin', description: 'Kerja')], TodoStatus.success));
    });
  }

  FutureOr<void> addTodo(OnAddTodo event, Emitter<TodoState> emit) async {
    Todo newTodo = event.newTodo;

    emit(TodoState([...state.todos, newTodo], TodoStatus.success));
  }
}
