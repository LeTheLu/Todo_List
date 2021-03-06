import 'package:flutter/material.dart';
import 'package:todo_list/item_todo/item_todo.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/todo/cubit_todo.dart';
import 'package:todo_list/witget/item_alarm.dart';
import 'package:todo_list/witget/item_done.dart';
import 'package:todo_list/witget/item_title.dart';

class ListViewTodo extends StatelessWidget {
  final List<Todo> listItem;
  final TodoCubit cubit;
  final bool checkDone;
  final List<Todo>? listTodo;
  final bool pageFavorite;


  const ListViewTodo({Key? key, required this.listItem,required this.cubit,this.checkDone = false, this.listTodo,this.pageFavorite = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(listItem.isEmpty){
      if(checkDone){
        return listDoneNull();
      }else
        if(pageFavorite){
        return listFavoriteNull();
      }else {
          return listTodoNull();
        }
    }
      return ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            bool checkDone = listItem[index].done == 1 ? true : false;
            bool checkImportant = listItem[index].important == 1 ? true : false;
            bool checkClock = listItem[index].clock == 1 ? true : false;
            return checkDone ?
            ItemDone(cubit: cubit ,index: index,indexIdTodo: listItem[index].id,listDone: listItem,listTodo: listTodo ?? []) :
            checkClock ? ItemTitleAlarm(todo: listItem[index] , cubit: cubit, itemTodo: ItemTodo(todo: listItem[index],cubit: cubit,important:checkImportant,clock: checkClock,done: checkDone,)) : ItemTitle(todo: listItem[index] , cubit: cubit, itemTodo: ItemTodo(todo: listItem[index],cubit: cubit,important:checkImportant,clock: checkClock,done: checkDone,),
            );
          });
  }

  Widget listFavoriteNull (){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const  [
          Text(" Nh???n",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Icon(Icons.star, color: Colors.blueGrey,),
          Text("????? th??m v??o danh s??ch y??u th??ch nh??!" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blueGrey),),
        ],
      ),
    );
  }

  Widget listTodoNull (){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const  [
          Text(" H??y th??m c??ng vi???c ngay n??o!",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("(B???n c??ng c?? th??? ?????t b??o th???c cho ghi ch?? ?????y!)" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blueGrey),),
        ],
      ),
    );
  }

  Widget listDoneNull (){
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const  [
          Text("B???n ch??a ho??n th??nh vi???c h??m nay r???i!",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text(" H??y ho??n th??nh c??ng vi???c n??o!" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blueGrey),),
        ],
      ),
    );
  }
}

