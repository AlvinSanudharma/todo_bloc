import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial([])) {
    on<OnAddTodo>(addTodo);

    on<OnUpdateTodo>((event, emit) async {
      emit(TodoLoading(state.todos));

      await Future.delayed(const Duration(milliseconds: 1500));

      Todo newTodo = event.newTodo;
      int index = event.index;

      List<Todo> todosUpdated = state.todos;

      todosUpdated[index] = newTodo;

      emit(TodoUpdated(todosUpdated));
    });

    on<OnRemoveTodo>((event, emit) async {
      emit(TodoLoading(state.todos));

      await Future.delayed(const Duration(milliseconds: 1500));

      int index = event.index;

      List<Todo> todosRemoved = state.todos;

      todosRemoved.removeAt(index);

      emit(TodoRemoved(todosRemoved));
    });
  }

  FutureOr<void> addTodo(OnAddTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading(state.todos));

    await Future.delayed(const Duration(milliseconds: 1500));

    Todo newTodo = event.newTodo;

    emit(TodoAdded([...state.todos, newTodo]));
  }
}
