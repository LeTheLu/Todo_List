import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/item_todo/state_item.dart';
import 'package:todo_list/models/model_todo.dart';
import 'package:todo_list/notification/notification.dart';
import 'package:todo_list/todo/cubit_todo.dart';

class ItemCubit extends Cubit<StateItemTodo> {
  ItemCubit(StateItemTodo initialState) : super(const StateItemTodo());

  Future<void> updateTodo({required Todo todo, required bool clock,required DateTime selectedDate, required TimeOfDay time, required TextEditingController controller, required TodoCubit cubit}) async {
    try {
      todo.clock = clock ? 1 : 0;
      if(todo.dateTime == '' && clock == true) {
        todo.dateTime = '${DateTime.now().toLocal()}'.split(' ')[0] + '${time.hour}:${time.minute}';
        todo.clock = 1;
        setAlarm(todo: todo, selectedDate: selectedDate, time: time, clock: clock);
      }
      todo.title = controller.text;
      cubit.updateItemTodo(todo);
      emit(state.copyWith(enumStateItem: EnumStateItem.success));
    } catch (e) {
      emit(state.copyWith(enumStateItem: EnumStateItem.err));
    }
  }

 Future<void> setAlarm({required Todo todo, required DateTime selectedDate, required TimeOfDay time,required bool clock}) async {
   NotificationService.cancel(todo.id);

     DateTime date1 = DateTime.now();
     DateTime date2 = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,time.hour,time.minute,0);
     var seconds = date2.difference(date1).inSeconds;
     if(seconds.isNegative) {
       NotificationService.cancel(todo.id);
       print("qua khứ mất rồi");
     }
     else {
       if(clock){
         todo.dateTime = '${selectedDate.toLocal()}'.split(' ')[0] + '${time.hour}:${time.minute}';

         NotificationService.showNotification(
             id: todo.id,
             title: todo.content,
             body: todo.title,
             seconds : seconds);
       }else {
         todo.dateTime = '${DateTime.now().toLocal()}'.split(' ')[0] + '${time.hour}:${time.minute}';
         todo.dateTime = clock ? '${DateTime.now().toLocal()}'.split(' ')[0] + '${time.hour}:${time.minute}': todo.dateTime = '';
         NotificationService.cancel(todo.id);
       }
     }
     }
}


