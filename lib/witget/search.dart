import 'package:flutter/material.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/todo/cubit_todo.dart';

class Search extends StatefulWidget {
  final List<Todo> listTodo;
  final TodoCubit cubit;
  const Search({Key? key, required this.listTodo, required this.cubit})
      : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _txtTodoController = TextEditingController();
    return Container(
      margin: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            controller: _txtTodoController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
          )),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0,1), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: TextButton(
                style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(20)),
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.white)))),
                onPressed: () {
                  setState(() {
                    if (_txtTodoController.text != '') {
                      widget.cubit
                          .addList(_txtTodoController.text, widget.listTodo);
                    }
                  });
                },
                child: const Text(
                  "+ Add",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
