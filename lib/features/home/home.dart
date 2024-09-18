import 'package:auto_route/auto_route.dart';
import 'package:diary/core/domain/repositories/note_repository.dart';
import 'package:diary/core/domain/repositories/task_repository.dart';
import 'package:diary/features/calendar/bloc/bloc/calendar_bloc.dart';
import 'package:diary/features/note_list/bloc/note_list_bloc.dart';
import 'package:diary/features/note_list/note_list.dart';
import 'package:diary/features/secret_entry_code/bloc/password_bloc.dart';
import 'package:diary/features/secret_entry_code/bloc/password_event.dart';
import 'package:diary/features/secret_entry_code/bloc/password_state.dart';
import 'package:diary/features/secret_entry_code/data/repositories/secret_code_repository.dart';
import 'package:diary/features/secret_entry_code/screens/secret_code.dart';
import 'package:diary/features/todo_list/todo_list.dart';
import 'package:diary/features/todo_list/bloc/todo_list_bloc.dart';
import 'package:diary/features/calendar/calendar.dart';
import 'package:diary/features/home/cubit/home_cubit.dart';
import 'package:diary/generated/l10n.dart';
import 'package:diary/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/content/v2_1.dart';

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
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                AutoRouter.of(context).push(const SettingsRoute());
              },
              icon: const Icon(Icons.menu)),
          title: Text(selectedTab.index == 0
              ? S.of(context).notes
              : selectedTab.index == 1
                  ? S.of(context).tasks
                  : S.of(context).calendar),
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
        bottomNavigationBar: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          selectedIndex: selectedTab.index,
          onDestinationSelected: (index) {
            context.read<HomeCubit>().setTab(index);
          },
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: const Icon(Icons.note_add),
              icon: const Icon(Icons.note_add_outlined),
              label: S.of(context).notes,
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.task),
              icon: const Icon(Icons.task_outlined),
              label: S.of(context).tasks,
            ),
            NavigationDestination(
              selectedIcon: const Icon(Icons.calendar_month),
              icon: const Icon(Icons.calendar_month_outlined),
              label: S.of(context).calendar,
            ),
            const NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              label: "",
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
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
          ],
        ));
  }
}
