import 'package:diary/core/data/models/task.dart';
import 'package:diary/core/services/ads/yandex_ads/banner/banner_ad.dart';
import 'package:diary/core/utils/components/todo_card.dart';
import 'package:diary/features/todo_list/bloc/todo_list_bloc.dart';
import 'package:diary/features/todo_list/widgets/todo_search.dart';
import 'package:diary/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class TasksListPage extends StatelessWidget {
  const TasksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TasksListView();
  }
}

class TasksListView extends StatefulWidget {
  const TasksListView({
    super.key,
  });

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TasksListBloc>(context);
    bloc.add(const LoadTasksListEvent());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: [
            const BannerAdWidget(
              isSticky: true,
            ),
            const TaskSearch(),
            SizedBox(
              height: 50,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: BlocBuilder<TasksListBloc, TasksListState>(
                      builder: (context, state) {
                    return ListView.builder(
                      scrollDirection:
                          Axis.horizontal, // Горизонтальная прокрутка
                      itemCount: 3, // Количество кнопок (в данном примере 3)
                      itemBuilder: (context, index) {
                        // Определяем фильтры и тексты для каждой кнопки
                        final filter = [
                          TaskFilter.all,
                          TaskFilter.uncompleted,
                          TaskFilter.completed,
                        ][index];

                        final filterText = [
                          S.of(context).all,
                          S.of(context).uncompleted,
                          S.of(context).completed,
                        ][index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ElevatedButton(
                            onPressed: () {
                              bloc.add(ChangeFilterEvent(filter: filter));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: state.taskFilter == filter
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(filterText),
                          ),
                        );
                      },
                    );
                  })),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: BlocBuilder<TasksListBloc, TasksListState>(
                    builder: (context, state) {
                  if (state.taskListStatus == TasksListStatus.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state.taskListStatus == TasksListStatus.loaded) {
                    final List<TaskModel> tasks = state.listTaskModel;
                    if (tasks.isNotEmpty) {
                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) =>
                            TaskCard(index: index, task: tasks[index]),
                      );
                    } else {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.all(50.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/todo.svg',
                                semanticsLabel: 'ToDo'),
                            Text(
                              S.of(context).emptyTasksList,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ));
                    }
                  }
                  if (state.taskListStatus == TasksListStatus.searchLoaded) {
                    final List<TaskModel> tasks = state.sortedListTaskModel;

                    if (tasks.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) =>
                            TaskCard(index: index, task: tasks[index]),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/todo.svg',
                                semanticsLabel: 'ToDo'),
                            Text(
                              S.of(context).tasksNotFound,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                  }
                  return const SizedBox();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
