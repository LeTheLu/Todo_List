import 'package:equatable/equatable.dart';
import 'package:todo_list/models/model_todo.dart';

enum EnumStateItem {
  success,
  intiItem,
  err,
}

class StateItemTodo extends Equatable {
  final EnumStateItem enumStateItem;
  final List<Todo>? list;

  const StateItemTodo({this.enumStateItem = EnumStateItem.intiItem, this.list});

  StateItemTodo copyWith(
      {List<Todo>? list, required EnumStateItem enumStateItem}) {
    return StateItemTodo(enumStateItem: enumStateItem, list: list ?? this.list);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [enumStateItem];
}
