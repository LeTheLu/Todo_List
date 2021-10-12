import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/item_todo/cubit_item.dart';
import 'package:todo_list/item_todo/state_item.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/todo/cubit_todo.dart';

class ItemTodo extends StatefulWidget {
  Todo todo;
  TodoCubit cubit;
  bool clock;
  bool important;
  bool done;

  ItemTodo(
      {Key? key,
      required this.todo,
      required this.cubit,
      this.clock = false,
      this.important = false,
      this.done = false})
      : super(key: key);

  @override
  State<ItemTodo> createState() => _ItemTodoState();
}

class _ItemTodoState extends State<ItemTodo> {
  final TextEditingController _controller = TextEditingController();
  ItemCubit itemCubit = ItemCubit(const StateItemTodo());
  DateTime selectedDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay? picked;

  _selectTime(BuildContext context) async {
    picked = await showTimePicker(
        helpText: "Todo List",
        context: context,
        initialTime: time,
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Colors.green,
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: const ColorScheme.light(primary: Colors.green)
                  .copyWith(secondary: Colors.green),
            ),
            child: child!,
          );
        });
    if (picked != null) {
        setState(() {
          time = picked!;

          itemCubit.setAlarm(
            todo: widget.todo,
            clock: widget.clock,
            selectedDate: selectedDate,
            time: time,
          );
        });
    }
  }

  _selectDate(BuildContext context) async {
    bool _decideWhichDayToEnable(DateTime day) {
      if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))))) {
        return true;
      }
      return false;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
      helpText: "Todo List",
      selectableDayPredicate: _decideWhichDayToEnable,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: const ColorScheme.light(primary: Colors.green)
                .copyWith(secondary: Colors.green),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        itemCubit.setAlarm(
            todo: widget.todo,
            clock: widget.clock,
            selectedDate: selectedDate,
            time: time,);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.todo.title;

    return BlocBuilder<ItemCubit, StateItemTodo>(
        bloc: itemCubit,
        buildWhen: (pre, cur) => pre.enumStateItem != cur.enumStateItem,
        builder: (context, state) {
          if (state.enumStateItem == EnumStateItem.err) {
            return const Center(child: Text("Err"));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                widget.todo.content,
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    itemCubit.updateTodo(
                        todo: widget.todo,
                        clock: widget.clock,
                        selectedDate: selectedDate,
                        time: time,
                        controller: _controller,
                        cubit: widget.cubit);
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
              actions: [
                Container(
                  padding: const EdgeInsets.only(right: 20, top: 7),
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        widget.clock = !widget.clock;
                      });
                    },
                    child: Icon(
                      Icons.access_alarm,
                      color: widget.clock ? Colors.green : Colors.blueGrey,
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                margin: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 500,
                      width: 400,
                      decoration: BoxDecoration(
                        color: const Color(0x0ff23000),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: Colors.green),
                      ),
                      child: TextField(
                        cursorColor: Colors.green,
                        controller: _controller,
                        maxLines: null,
                        decoration:
                            const InputDecoration.collapsed(hintText: "Note"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Visibility(
                        visible: widget.clock,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 50,
                                  width: 127,
                                  decoration: BoxDecoration(
                                      color: const Color(0x0ff23000),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.green, width: 2)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.access_alarm,
                                        color: Colors.green,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _selectTime(context);
                                        },
                                        child: Center(
                                          child: Text(
                                            widget.todo.dateTime == ''
                                                ? '${time.hour} : ${time.minute}'
                                                : widget.todo.dateTime
                                                    .substring(10),
                                            style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color: const Color(0x0ff23000),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.green, width: 2)),
                                  child: InkWell(
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Icon(
                                            Icons.event,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            widget.todo.dateTime == '' ? "${selectedDate.toLocal()}".split(' ')[0] : widget.todo.dateTime.substring(0, 10),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}
