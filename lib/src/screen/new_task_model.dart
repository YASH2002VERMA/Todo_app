import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/constants/app_style.dart';
import 'package:todo_app/src/model/todo_model.dart';
import 'package:todo_app/src/provider/date_time_provider.dart';
import 'package:todo_app/src/provider/radio_provider.dart';
import 'package:todo_app/src/provider/service_provider.dart';
import 'package:todo_app/src/widget/date_time_widget.dart';
import 'package:todo_app/src/widget/radio_widget.dart';
import 'package:todo_app/src/widget/textfield_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
  const AddNewTaskModel({super.key});

  static TextEditingController titleController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datePro = ref.watch(dateProvider);
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Text(
              'New Task Todo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            thickness: 1.2,
            color: Colors.grey.shade200,
          ),
          const Gap(12),
          const Text(
            'Title Task',
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(
            hintText: 'Task name',
            maxLine: 1,
            txtController: titleController,
          ),
          const Gap(12),
          const Text(
            'description',
            style: AppStyle.headingOne,
          ),
          const Gap(6),
          TextFieldWidget(
            maxLine: 5,
            hintText: 'add description',
            txtController: descriptionController,
          ),
          const Gap(12),
          const Text(
            'category',
            style: AppStyle.headingOne,
          ),
          Row(
            children: [
              Expanded(
                child: RadioWidget(
                  categoryColor: const Color(0xFF4166F5),
                  titleRadio: 'Study',
                  valueInput: 1,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 1),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  categoryColor: Colors.amber.shade700,
                  titleRadio: 'Work',
                  valueInput: 2,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 2),
                ),
              ),
              Expanded(
                child: RadioWidget(
                  categoryColor: Colors.grey.shade800,
                  titleRadio: 'General',
                  valueInput: 3,
                  onChangeValue: () =>
                      ref.read(radioProvider.notifier).update((state) => 3),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DateTimeWidget(
                titleText: 'Date',
                valueText: datePro,
                icon: CupertinoIcons.calendar,
                ontap: () async {
                  final getDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2026),
                  );
                  if (getDate != null) {
                    final format = DateFormat.yMMMd();
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getDate));
                  }
                },
              ),
              const Gap(20),
              DateTimeWidget(
                titleText: 'Time',
                valueText: ref.watch(timeProvider),
                icon: CupertinoIcons.clock,
                ontap: () async {
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (getTime != null) {
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }
                },
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(color: Colors.blue.shade800),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cancel'),
                ),
              ),
              const Gap(20),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {
                    final getRadioValue = ref.read(radioProvider);
                    String category = '';

                    switch (getRadioValue) {
                      case 1:
                        category = 'Study';
                        break;
                      case 2:
                        category = 'Work';
                        break;
                      case 3:
                        category = 'General';
                        break;
                    }
                    ref.read(serviceProvider).addNewTask(
                          TodoModel(
                            taskTitle: titleController.text,
                            taskDescription: descriptionController.text,
                            category: category,
                            taskDate: ref.read(dateProvider),
                            taskTime: ref.read(timeProvider),
                            isDone: false
                          ),
                        );
                    print('data is save');

                    titleController.clear();
                    descriptionController.clear();
                    ref.read(radioProvider.notifier).update((state) => 0);
                    Navigator.pop(context);
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
// 2:25:42