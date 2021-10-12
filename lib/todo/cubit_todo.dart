import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/database/database_todo.dart';
import 'package:todo_list/models/model_todo.dart';
import 'dart:math';
import 'package:todo_list/todo/state_todo.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(TodoState initialState) : super(const TodoState());
  late Todo todo;
  final _ranDomIntId = Random();
  TodoDatabase todoDatabase = TodoDatabase.instance;

  Future<List<Todo>> loadData(List<Todo> list) async {
    try {
      emit(state.copyWith(statePageHome: StatePageHome.loadItem));
      list = await todoDatabase.Todos();
      emit(state.copyWith(statePageHome: StatePageHome.success));
    } catch (e) {
      emit(state.copyWith(statePageHome: StatePageHome.err));
    }
    return list;
  }

  Future<void> addList(String txt, List<Todo> list) async {
    emit(state.copyWith(statePageHome: StatePageHome.loadItem));
    todo = Todo(id: _ranDomIntId.nextInt(10000), content: txt);
    await todoDatabase.insertTodo(todo);
    list.add(todo);
    emit(state.copyWith(statePageHome: StatePageHome.success, list: list));
  }

  Future<void> deleteList(
      int indexItem, int indexId, List<Todo> listTodo) async {
    emit(state.copyWith(statePageHome: StatePageHome.loadItem));
    await todoDatabase.deleteTodo(indexId);
    listTodo.removeAt(indexItem);
    emit(state.copyWith(statePageHome: StatePageHome.success, list: listTodo));
  }

  Future<void> updateItemTodo(Todo todo) async {
    emit(state.copyWith(statePageHome: StatePageHome.loadItem));
    await todoDatabase.updateTodo(todo);
    emit(state.copyWith(statePageHome: StatePageHome.success));
  }
}
