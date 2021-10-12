import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/notification/notification.dart';
import 'package:todo_list/todo/page_done.dart';
import 'package:todo_list/todo/page_favorite.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/todo/cubit_todo.dart';
import 'package:todo_list/todo/page_todo.dart';
import 'package:todo_list/todo/state_todo.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _page = 1;
  late TodoCubit cubitTodo;
  List<Todo> listTodo = [];

  @override
  void initState() {
    super.initState();
    cubitTodo = TodoCubit(const TodoState());
    tz.initializeTimeZones();
    initData();
  }

  void initData() async {
    var list1 = await cubitTodo.loadData(listTodo);
    listTodo = List.from(list1.reversed);
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: _page);
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          index: _page,
          height: 60.0,
          items: const [
            Icon(
              Icons.star,
              color: Colors.white,
            ),
            Icon(Icons.event, color: Colors.white),
            Icon(Icons.check, color: Colors.white),
          ],
          color: Colors.green,
          buttonBackgroundColor: Colors.green,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: BlocBuilder<TodoCubit , TodoState>(
            bloc: cubitTodo,
            buildWhen: (pre, cur) => pre.statePageHome != cur.statePageHome,
            builder: (context, state) {

              List<Todo> listDone = [];
              for (var element in listTodo) {
                if (element.done == 1) {
                  listDone.add(element);
                }
              }
              List<Todo> listFavorite = [];
              for (var element in listTodo) {
                if (element.important == 1 && element.done == 0 ) {
                  listFavorite.add(element);
                }
              }
              List<Todo> listHome = [];
              for (var element in listTodo) {
                if(element.done == 0){
                  listHome.add(element);
                }
              }

              return PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    _page = index;
                  });
                },
                children: [
                  Favorite(cubit: cubitTodo,list: listFavorite,pageFavorite: true),
                  ToDoList(cubit: cubitTodo,list: listHome,listTodo: listTodo),
                  Done(cubit: cubitTodo,listTodo: listTodo,listTodoDone: listDone,)
                ],
              );
            }
            ),
    );
  }
}
