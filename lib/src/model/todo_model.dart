// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  TodoModel({
    this.docID,
    required this.taskTitle,
    required this.taskDescription,
    required this.category,
    required this.taskDate,
    required this.taskTime,
    required this.isDone,
  });

  String? docID;
  final String taskTitle;
  final String taskDescription;
  final String category;
  final String taskDate;
  final String taskTime;
  final bool isDone;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'category': category,
      'taskDate': taskDate,
      'taskTime': taskTime,
      'isDone': isDone,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      taskTitle: map['taskTitle'] as String,
      taskDescription: map['taskDescription'] as String,
      category: map['category'] as String,
      taskDate: map['taskDate'] as String,
      taskTime: map['taskTime'] as String, 
      isDone: map['isDone'] as bool,
    );
  }

  factory TodoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TodoModel(
      docID: doc.id,
      taskTitle: doc['taskTitle'],
      taskDescription: doc['taskDescription'],
      category: doc['category'],
      taskDate: doc['taskDate'],
      taskTime: doc['taskTime'],
      isDone: doc['isDone'],
    );
  }
}
