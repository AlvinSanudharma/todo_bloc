part of 'todo_bloc.dart';

@immutable
sealed class TodoState {
  final List<Todo> todos;

  TodoState(this.todos);
}

final class TodoInitial extends TodoState {
  TodoInitial(super.todos);
}

final class TodoLoading extends TodoState {
  TodoLoading(super.todos);
}

final class TodoAdded extends TodoState {
  TodoAdded(super.todos);
}

final class TodoRemoved extends TodoState {
  TodoRemoved(super.todos);
}

final class TodoUpdated extends TodoState {
  TodoUpdated(super.todos);
}
