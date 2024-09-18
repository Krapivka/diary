import 'package:auto_route/auto_route.dart';
import 'package:diary/core/data/models/task.dart';

import 'package:diary/core/domain/repositories/task_repository.dart';
import 'package:diary/core/utils/components/action_button.dart';
import 'package:diary/core/utils/constants/Palette.dart';
import 'package:diary/core/utils/snack_bar/snack_bar.dart';
import 'package:diary/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:diary/features/todo_changes/update_task/bloc/update_task_bloc.dart';
import 'package:diary/features/todo_changes/widgets/text_field_todo_changes.dart';
import 'package:diary/generated/l10n.dart';
import 'package:diary/router/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class UpdateTaskPage extends StatelessWidget {
  const UpdateTaskPage({
    super.key,
    required this.taskmodel,
  });

  final TaskModel taskmodel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateTaskBloc(
          context.read<AbstractTaskRepository>(),
          taskmodel,
          context.read<AbstractSettingsRepository>()),
      child: UpdateTaskPageView(),
    );
  }
}

// ignore: must_be_immutable
class UpdateTaskPageView extends StatelessWidget {
  UpdateTaskPageView({
    super.key,
  });
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UpdateTaskBloc>(context).state;
    titleController.text = bloc.title;
    descriptionController.text = bloc.description;
    // dataController.text = bloc.dateTime.toString().split(' ')[0];
    return BlocConsumer<UpdateTaskBloc, UpdateTaskState>(
        listener: (context, state) {
      if (state.status == UpdateTaskStatus.validatorFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
            AppSnackBar.show(context, S.of(context).fillInTheRequiredFields));
      }
      if (state.status == UpdateTaskStatus.success) {
        AutoRouter.of(context).pushAndPopUntil(const HomeRoute(),
            predicate: (Route<dynamic> route) => false);
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).updateTask,
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  context
                      .read<UpdateTaskBloc>()
                      .add(UpdateTaskDelete(state.id));
                },
                icon: const Icon(Icons.delete_outline_outlined))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              //  const EditableAvatar(),
              TextFieldTaskChanges(
                controller: titleController,
                labelText: S.of(context).enterNameInTextField,
                hintText: S.of(context).hintTextNameInTextField,
                onChanged: (value) {
                  context
                      .read<UpdateTaskBloc>()
                      .add(UpdateTaskTitleChanged(value));
                },
                icon: const Icon(Icons.task_outlined),
              ),
              TextFieldTaskChanges(
                controller: descriptionController,
                hintText: S.of(context).descriptionForTask,
                onChanged: (value) {
                  context
                      .read<UpdateTaskBloc>()
                      .add(UpdateTaskDescriptionChanged(value));
                },
                icon: const Icon(Icons.description_outlined),
              ),
              Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(S.of(context).chooseDateTime),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 100,
                    child: DatePicker(onDateTimeChanged: (DateTime value) {
                      BlocProvider.of<UpdateTaskBloc>(context)
                          .add(UpdateTaskDateTap(value));
                    }),
                  ),
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              const _ButtonSaveTask(),
            ],
          ),
        ),
      );
    });
  }
}

// class EditableImage extends StatelessWidget {
//   const EditableImage();

//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.watch<UpdateTaskBloc>();
//     final width = MediaQuery.of(context).size.width / 3;
//     final avatarPath = bloc.state.file.absolute.path;
//     return Center(
//       child: Material(
//         child: InkWell(
//           onTap: () {
//             bloc.add(const UpdateTaskImageTap());
//           },
//           child: Ink(
//             child: Stack(children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image(
//                     fit: BoxFit.cover,
//                     width: double.infinity,
//                     height: MediaQuery.of(context).size.height / 3,
//                     image: avatarPath == '/'
//                         ? const AssetImage(
//                             "assets/images/default_task_image.png")
//                         : FileImage(bloc.state.file) as ImageProvider),
//               ),
//               Positioned(
//                 right: 5,
//                 bottom: 5,
//                 child: FloatingActionButton(
//                   mini: true,
//                   onPressed: () {
//                     bloc.add(const UpdateTaskImageTap());
//                   },
//                   child: const Icon(Icons.brush),
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _ButtonSaveTask extends StatelessWidget {
  const _ButtonSaveTask();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.read<UpdateTaskBloc>().add(const UpdateTaskSave());
        },
        child: ActionButton(
          text: S.of(context).save,
        ));
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.onDateTimeChanged});

  final void Function(DateTime) onDateTimeChanged;
  @override
  Widget build(BuildContext context) {
    final dateTimeNow = DateTime.now();
    return BlocBuilder<UpdateTaskBloc, UpdateTaskState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Palette.primaryDark,
              width: 1,
            ),
          ),
          child: CupertinoDatePicker(
              minimumDate: DateTime(1930),
              maximumDate: DateTime(
                dateTimeNow.year + 20,
                dateTimeNow.month,
                dateTimeNow.day,
              ),
              mode: CupertinoDatePickerMode.dateAndTime,
              use24hFormat: true,
              initialDateTime: state.dateTime,
              onDateTimeChanged: onDateTimeChanged),
        );
      },
    );
  }
}
