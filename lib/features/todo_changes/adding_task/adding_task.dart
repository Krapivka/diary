import 'package:auto_route/auto_route.dart';
import 'package:diary/core/domain/repositories/task_repository.dart';
import 'package:diary/core/utils/components/action_button.dart';
import 'package:diary/core/utils/constants/Palette.dart';
import 'package:diary/core/utils/date_utils/date_utils.dart';
import 'package:diary/core/utils/snack_bar/snack_bar.dart';
import 'package:diary/features/todo_changes/adding_task/bloc/adding_task_bloc.dart';
import 'package:diary/features/settings/data/repository/abstract_settings_repository.dart';
import 'package:diary/features/todo_changes/widgets/text_field_todo_changes.dart';
import 'package:diary/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diary/router/router.dart';

@RoutePage()
class AddingTaskPage extends StatelessWidget {
  const AddingTaskPage({super.key, this.dateTimeCalendar});
  final DateTime? dateTimeCalendar;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddingTaskBloc(
        context.read<AbstractTaskRepository>(),
        context.read<AbstractSettingsRepository>(),
        dateTimeCalendar,
      ),
      child: const AddingTaskView(),
    );
  }
}

class AddingTaskView extends StatelessWidget {
  const AddingTaskView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddingTaskBloc, AddingTaskState>(
      listener: (context, state) {
        if (state.status == AddingTaskStatus.validatorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBar.show(context, S.of(context).fillInTheRequiredFields));
        }
        if (state.status == AddingTaskStatus.success) {
          AutoRouter.of(context).pushAndPopUntil(const HomeRoute(),
              predicate: (Route<dynamic> route) => false);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                S.of(context).addTask,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //  const EditableAvatar(),
                    TextFieldTaskChanges(
                      labelText: S.of(context).enterNameInTextField,
                      hintText: S.of(context).hintTextNameInTextField,
                      onChanged: (value) {
                        context
                            .read<AddingTaskBloc>()
                            .add(AddingTaskTitleChanged(value));
                      },
                      icon: const Icon(Icons.task_outlined),
                    ),
                    TextFieldTaskChanges(
                      hintText: S.of(context).descriptionForTask,
                      onChanged: (value) {
                        context
                            .read<AddingTaskBloc>()
                            .add(AddingTaskDescriptionChanged(value));
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
                          child: DatePicker(
                            onDateTimeChanged: (DateTime value) {
                              BlocProvider.of<AddingTaskBloc>(context)
                                  .add(AddingTaskDateChanged(value));
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    const _ButtonAddTask(),
                  ],
                ),
              ),
            ));
      },
    );
  }
}

class _ButtonAddTask extends StatelessWidget {
  const _ButtonAddTask();

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.read<AddingTaskBloc>().add(const AddingTaskSubmitted());
        },
        child: ActionButton(
          text: S.of(context).addTaskButton,
        ));
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.onDateTimeChanged});

  final void Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddingTaskBloc, AddingTaskState>(
      builder: (context, state) {
        DateTime? dateTimeNow = DateTime.now();
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
              initialDateTime:
                  DateTimeUtils.combineDateAndTime(state.dateTime, dateTimeNow),
              onDateTimeChanged: onDateTimeChanged),
        );
      },
    );
  }
}
