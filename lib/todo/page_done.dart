import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/todo/cubit_todo.dart';
import 'package:todo_list/todo/state_todo.dart';
import 'package:todo_list/witget/list_view.dart';
import 'package:todo_list/witget/title.dart';

class Done extends StatefulWidget {
  final TodoCubit cubit;
  final List<Todo> listTodo;
  final List<Todo> listTodoDone;


  const Done({Key? key, required this.cubit,required this.listTodo,required this.listTodoDone}) : super(key: key);

  @override
  _Done createState() => _Done();
}

class _Done extends State<Done> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          titleTodo("Done", Icons.check_circle),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:
                BlocBuilder<TodoCubit, TodoState>(
                  bloc: widget.cubit,
                  buildWhen: (pre, cur) =>
                  pre.statePageHome != cur.statePageHome,
                  builder: (context, state) {
                    if (state.statePageHome == StatePageHome.success) {
                      return ListViewTodo(cubit: widget.cubit,listItem : widget.listTodoDone,checkDone: true, listTodo: widget.listTodo,);
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
