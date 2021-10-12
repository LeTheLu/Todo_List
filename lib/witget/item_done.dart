import 'package:flutter/material.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/todo/cubit_todo.dart';

class ItemDone extends StatelessWidget {
  final List<Todo> listDone;
  final List<Todo> listTodo;
  final int index;
  final int indexIdTodo;
  final TodoCubit cubit;

  const ItemDone(
      {Key? key,
      required this.listDone,
      required this.listTodo,
      required this.index,
      required this.indexIdTodo,
      required this.cubit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: const Color(0x0ff23000),
            border: Border.all(color: Colors.green, width: 2)),
        child: ListTile(
          title: Text(
            listDone[index].content,
            style: const TextStyle(color: Colors.green, fontSize: 20),
          ),
          leading: InkWell(
            onTap: () {
              listDone[index].done = 0;
              cubit.updateItemTodo(listDone[index]);
            },
            child: const Icon(Icons.update, color: Colors.blueGrey),
          ),
          subtitle: Text(listDone[index].title.length < 30
              ? listDone[index].title
              : listDone[index].title.substring(0, 30) + "..."),
          trailing: InkWell(
            onTap: () {
              var i = 0;
              for (var element in listTodo) {
                i++;
                if (element.id == indexIdTodo) {
                  cubit.deleteList(i - 1, indexIdTodo, listTodo);
                }
              }
            },
            child: const Icon(Icons.close),
          ),
        ));
  }
}
