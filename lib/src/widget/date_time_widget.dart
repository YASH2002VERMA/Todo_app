import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/src/constants/app_style.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.titleText,
    required this.valueText,
    required this.icon,
    required this.ontap,
  });

  final String titleText;
  final String valueText;
  final IconData icon;
  final Function() ontap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          titleText,
          style: AppStyle.headingOne,
        ),
        const Gap(6),
        Material(
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: ontap,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                    ),
                    const Gap(2),
                    Text(valueText),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
