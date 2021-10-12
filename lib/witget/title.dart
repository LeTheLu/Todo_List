import 'package:flutter/material.dart';

Widget titleTodo(String title, IconData? icon){
  return Container(
    padding: const EdgeInsets.only(top: 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
        const SizedBox(width: 10),
        Icon(icon, color: Colors.green,)
      ],
    ),
  );
}