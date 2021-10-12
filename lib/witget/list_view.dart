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
          Text(" Nhấn",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Icon(Icons.star, color: Colors.blueGrey,),
          Text("để thêm vào danh sách yêu thích nhé!" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blueGrey),),
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
          Text(" Hãy thêm công việc ngay nào!",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text("(Bạn cũng có thể đặt báo thức cho ghi chú đấy!)" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blueGrey),),
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
          Text("Bạn chưa hoàn thành việc hôm nay rồi!",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.blueGrey)),
          Text(" Hãy hoàn thành công việc nào!" , style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.blueGrey),),
        ],
      ),
    );
  }
}

