import 'package:auto_route/auto_route.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diary/core/data/models/task.dart';
import 'package:diary/core/utils/animations/show_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:diary/core/utils/date_utils/date_utils.dart';
import 'package:diary/features/todo_list/bloc/todo_list_bloc.dart';
import 'package:diary/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:diary/router/router.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.index,
  });
  final TaskModel task;
  final int index;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _visible = false;

  void animateCard() async {
    await Future.delayed(const Duration(milliseconds: 100)).then((value) {
      if (mounted) {
        _visible = false;
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final file = File(widget.task.filePath);
    final settingsBloc = context.watch<SettingsBloc>();
    final taskListBloc = BlocProvider.of<TasksListBloc>(context);

    return BlocBuilder<TasksListBloc, TasksListState>(
      builder: (context, state) {
        //use animate when widget rebuild
        animateCard();
        return AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  if (state.selectedTaskId.isEmpty) {
                    AutoRouter.of(context)
                        .push(UpdateTaskRoute(taskmodel: widget.task));
                  } else {
                    taskListBloc.add(TapTaskCardEvent(id: widget.task.id));
                  }
                },
                onLongPress: () {
                  taskListBloc.add(LongPressTaskCardEvent(id: widget.task.id));
                },
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: taskListBloc.state.selectedTaskId
                            .contains(widget.task.id)
                        ? const Color.fromARGB(255, 223, 223, 223)
                        : Theme.of(context).colorScheme.primary,
                  ),
                  child: ListTile(

                      // leading: CircleAvatar(
                      //   radius: 28,
                      //   backgroundImage: widget.task.filePath == "/"
                      //       ? const AssetImage("assets/images/avatar.png")
                      //       : FileImage(file) as ImageProvider,
                      // ),
                      title: ShowUp(
                        delay: 100,
                        child: Text(
                          widget.task.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          // style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: ShowUp(
                          delay: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.task.description ?? ''),
                              Text(DateTimeUtils.formatDate(
                                  widget.task.dateTime,
                                  settingsBloc.state.dateFormat)),
                            ],
                          )),
                      trailing: IconButton(
                        onPressed: () {
                          taskListBloc.add(
                              ChangeTaskCompleteListEvent(task: widget.task));
                        },
                        icon: widget.task.isCompleted
                            ? const FaIcon(FontAwesomeIcons.solidCircleCheck,
                                size: 25,
                                color: Color.fromARGB(255, 58, 230, 149))
                            : const FaIcon(FontAwesomeIcons.circle,
                                size: 25, color: Colors.redAccent),
                      )),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
