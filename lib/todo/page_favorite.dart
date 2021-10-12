import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/todo/cubit_todo.dart';
import 'package:todo_list/todo/state_todo.dart';
import 'package:todo_list/witget/list_view.dart';
import 'package:todo_list/witget/title.dart';

class Favorite extends StatefulWidget {
  final TodoCubit cubit;
  final List<Todo> list;
  final bool pageFavorite;


  const Favorite({Key? key, required this.cubit,required this.list,required this.pageFavorite}) : super(key: key);

  @override
  _Favorite createState() => _Favorite();
}

class _Favorite extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
          children: [
            titleTodo("Favorite", Icons.star),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<TodoCubit, TodoState>(
                    bloc: widget.cubit,
                    buildWhen: (pre, cur) => pre.statePageHome != cur.statePageHome,
                    builder: (context, state) {
                      if (state.statePageHome == StatePageHome.success) {
                        return ListViewTodo(cubit: widget.cubit,listItem: widget.list,pageFavorite:  widget.pageFavorite,);
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
