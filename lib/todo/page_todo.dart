import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/todo/cubit_todo.dart';
import 'package:todo_list/todo/state_todo.dart';
import 'package:todo_list/witget/list_view.dart';
import 'package:todo_list/witget/search.dart';
import 'package:todo_list/witget/title.dart';

class ToDoList extends StatefulWidget {
  final TodoCubit cubit;
  final List<Todo> list;
  final List<Todo> listTodo;


  const ToDoList({Key? key, required this.cubit,required this.list,required this.listTodo}) : super(key: key);

  @override
  _ToDoList createState() => _ToDoList();
}

class _ToDoList extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          titleTodo("Todo List", Icons.event),
          Expanded(
            child: Column(
              children: [
                Search(cubit: widget.cubit,listTodo: widget.listTodo,),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: BlocBuilder<TodoCubit, TodoState>(
                        bloc: widget.cubit,
                        buildWhen: (pre, cur) =>
                            pre.statePageHome != cur.statePageHome,
                        builder: (context, state) {
                          if (state.statePageHome == StatePageHome.success) {
                            return ListViewTodo(
                                cubit: widget.cubit, listItem: widget.list, listTodo: widget.listTodo,);
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
