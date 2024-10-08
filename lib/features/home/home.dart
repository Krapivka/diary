import 'package:auto_route/auto_route.dart';
import 'package:diary/core/domain/repositories/note_repository.dart';
import 'package:diary/core/domain/repositories/task_repository.dart';
import 'package:diary/core/services/ads/yandex_ads/open_ad/bloc/app_open_ad_bloc.dart';
import 'package:diary/features/calendar/bloc/bloc/calendar_bloc.dart';
import 'package:diary/features/home/widgets/custom_nav_bar.dart';
import 'package:diary/features/note_list/bloc/note_list_bloc.dart';
import 'package:diary/features/note_list/note_list.dart';

import 'package:diary/features/settings/screens/settings_list.dart';
import 'package:diary/features/todo_list/todo_list.dart';
import 'package:diary/features/todo_list/bloc/todo_list_bloc.dart';
import 'package:diary/features/calendar/calendar.dart';
import 'package:diary/features/home/cubit/home_cubit.dart';
import 'package:diary/generated/l10n.dart';
import 'package:diary/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../settings/data/repository/abstract_settings_repository.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => TasksListBloc(
            RepositoryProvider.of<AbstractTaskRepository>(context),
            RepositoryProvider.of<AbstractSettingsRepository>(context)),
      ),
      BlocProvider(
        create: (context) => NotesListBloc(
          RepositoryProvider.of<AbstractNoteRepository>(context),
        ),
      ),
      BlocProvider(
        create: (context) => CalendarBloc(
            RepositoryProvider.of<AbstractTaskRepository>(context)),
      ),
    ], child: HomeView());
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeCubit cubit) => cubit.state.tab);
    final notesListBloc = BlocProvider.of<NotesListBloc>(context);
    const double? sizeIcon = 30;

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedTab.index == 0
              ? S.of(context).notes
              : selectedTab.index == 1
                  ? S.of(context).tasks
                  : selectedTab.index == 2
                      ? S.of(context).calendar
                      : S.of(context).settings),
          centerTitle: true,
          actions: [
            BlocBuilder<NotesListBloc, NotesListState>(
              builder: (context, state) {
                return BlocBuilder<TasksListBloc, TasksListState>(
                  builder: (context, state) {
                    bool isDelTask = (state.selectedTaskId.isNotEmpty &&
                        (selectedTab.index == 1 || selectedTab.index == 2));
                    bool isDelNote =
                        ((notesListBloc.state.selectedNoteId.isNotEmpty &&
                            selectedTab.index == 0));
                    return Visibility(
                      visible: isDelTask || isDelNote,
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          if (isDelNote) {
                            BlocProvider.of<NotesListBloc>(context)
                                .add(const DeleteNoteNotesListEvent());
                          }
                          if (isDelTask) {
                            BlocProvider.of<TasksListBloc>(context)
                                .add(const DeleteTaskTasksListEvent());
                          }
                        },
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        bottomNavigationBar:
            CustomNavigationBar(selectedTab: selectedTab, sizeIcon: sizeIcon),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: selectedTab.index == 0
            ? FloatingActionButton(
                onPressed: () {
                  AutoRouter.of(context).push(NoteRoute());
                },
                child: const Icon(
                  Icons.add,
                ))
            : selectedTab.index == 1
                ? FloatingActionButton(
                    onPressed: () {
                      AutoRouter.of(context).push(AddingTaskRoute());
                    },
                    child: const Icon(
                      Icons.add,
                    ))
                : FloatingActionButton(
                    onPressed: () {
                      final selDay = BlocProvider.of<CalendarBloc>(context)
                          .state
                          .selectedDay;
                      print(selDay);
                      AutoRouter.of(context)
                          .push(AddingTaskRoute(dateTimeCalendar: selDay));
                    },
                    child: const Icon(
                      Icons.add,
                    )),
        body: IndexedStack(
          index: selectedTab.index,
          children: const [
            NotesListPage(),
            TasksListPage(),
            CalendarPage(),
            SettingsPage(),
          ],
        ));
  }
}
