import 'package:flutter/material.dart';
import 'package:todo_list/item_todo/item_todo.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/todo/cubit_todo.dart';

class ItemTitleAlarm extends StatelessWidget {
  final Todo todo;
  final ItemTodo itemTodo;
  final TodoCubit cubit;

  const ItemTitleAlarm({
    Key? key,
    required this.cubit,
    required this.todo,
    required this.itemTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => itemTodo));
      },
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.green,
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.white, width: 2)),
            height: 78,
            width: 78,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(todo.dateTime.substring(10), style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
                Text(todo.dateTime.substring(5,7)+'/' + todo.dateTime.substring(8,10), style: const TextStyle(color: Colors.white70, fontSize: 15, fontWeight: FontWeight.bold)),
              ],
            ),

          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal:5),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  border: Border.all(color: Colors.green, width: 2)),
              child: ListTile(
                title: Text(
                  todo.content,
                  style: const TextStyle(color: Colors.green, fontSize: 20),
                ),
                leading: InkWell(
                  onTap: () {
                    itemTodo.important = !itemTodo.important;
                    todo.important = itemTodo.important ? 1 : 0;
                    cubit.updateItemTodo(todo);
                  },
                  child: Icon(
                    Icons.star,
                    color: itemTodo.important ? Colors.green : Colors.blueGrey,
                  ),
                ),
                subtitle: Text(todo.title.length < 30
                    ? todo.title
                    : todo.title.substring(0, 30) + "..."),
                trailing: InkWell(
                  onTap: () {
                    todo.done = 1;
                    cubit.updateItemTodo(todo);
                  },
                  child: const Icon(Icons.check),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
