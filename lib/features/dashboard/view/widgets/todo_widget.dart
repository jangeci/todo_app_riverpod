import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/common/services/share_service.dart';
import 'package:todo_app/common/widgets/text_widgets.dart';
import 'package:todo_app/models/todo.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;
  final bool isFirst;
  final bool showOwner;
  final Function() delete;
  final Function() toggle;

  const TodoWidget({
    super.key,
    required this.todo,
    required this.delete,
    required this.toggle,
    this.isFirst = false,
    this.showOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w, top: isFirst ? 10.w : 0),
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.grey.shade50,
          border: Border.all(color: Colors.grey.withAlpha(50)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(50),
              offset: Offset(0, 2.w),
              blurRadius: 3.w,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text16Normal(
                    todo.title,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                PopupMenuButton(
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.more_horiz,
                        size: 24.w,
                      ),
                    ),
                  ),
                  itemBuilder: (context) => [
                    _popupMenuItem('Share', 0, () {
                      ShareService.share(context, id: todo.id);
                    }),
                    _popupMenuItem('Delete', 1, () {
                      delete();
                    }),
                  ],
                ),
              ],
            ),
            if (showOwner)
              Text11Normal(
                'Owner: ${todo.owner}',
              ),
            Text11Normal(
              'Created at: ${DateFormat('dd.MM.yyy hh:mm').format(todo.createdAt)}',
            ),
            Row(
              children: [
                Text11Normal('Is done: '),
                Checkbox(
                  checkColor: Colors.green,
                  fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return Colors.grey.shade300;
                    }
                    return Colors.white;
                  }),
                  side: BorderSide(color: Colors.grey.shade300, width: 1),
                  value: todo.done,
                  onChanged: (val) {
                    toggle();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  PopupMenuItem _popupMenuItem(String text, int value, Function() onTap) {
    return PopupMenuItem(
      value: value,
      onTap: onTap,
      child: Text13Normal(text),
    );
  }
}
