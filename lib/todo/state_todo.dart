import 'package:equatable/equatable.dart';
import 'package:todo_list/models/model_todo.dart';

enum StatePageHome{
  initData,
  loadItem,
  success,
  err
}

class TodoState extends Equatable{
  final StatePageHome statePageHome;
  final List<Todo>? list;

  const TodoState({this.statePageHome = StatePageHome.initData,this.list});

  TodoState copyWith({List<Todo>? list,required StatePageHome statePageHome}) {
    return TodoState(
        list: list ?? this.list,
        statePageHome: statePageHome
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [statePageHome];

}
