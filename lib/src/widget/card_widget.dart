import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/src/provider/service_provider.dart';

class CardWidget extends ConsumerWidget {
  const CardWidget({
    super.key,
    required this.getIndex,
  });

  final int getIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoData = ref.watch(fetchStreamProvider);
    return todoData.when(
        data: (todoData) {
          Color categoryColor = Colors.white;

          final getCategory = todoData[getIndex].category;

          switch (getCategory) {
            case 'Study':
              categoryColor = const Color(0xFF4166F5);
              break;

            case 'Work':
              categoryColor = Colors.amber.shade700;
              break;

            case 'General':
              categoryColor = Colors.grey.shade800;
              break;
          }

          return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        )),
                    width: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: IconButton(icon: const Icon(CupertinoIcons.delete), onPressed: () => ref.read(serviceProvider).deleteTask(todoData[getIndex].docID),),
                            title: Text(
                              todoData[getIndex].taskTitle,
                              maxLines: 1,
                              style: TextStyle(
                                decoration: todoData[getIndex].isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Text(
                              todoData[getIndex].taskDescription,
                              maxLines: 1,
                              style: TextStyle(
                                decoration: todoData[getIndex].isDone
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                activeColor: Colors.blue.shade700,
                                shape: const CircleBorder(),
                                value: todoData[getIndex].isDone,
                                onChanged: (value) => ref
                                    .read(serviceProvider)
                                    .updateTask(
                                        todoData[getIndex].docID, value),
                              ),
                            ),
                            
                          ),
                          Transform.translate(
                            offset: const Offset(0, -12),
                            child: Container(
                              child: Column(
                                children: [
                                  Divider(
                                    thickness: 1,
                                    color: Colors.grey.shade200,
                                  ),
                                  Row(
                                    children: [
                                      Text('Today'),
                                      Gap(12),
                                      Text(todoData[getIndex].taskTime)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        },
        error: (error, stackTrace) => Center(
              child: Text(stackTrace.toString()),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}

// 2:41:51