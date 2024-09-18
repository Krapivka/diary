import 'package:intl/intl.dart';
import 'package:diary/core/data/models/task.dart';
import 'package:diary/core/services/ads/yandex_ads/banner/banner_ad.dart';
import 'package:diary/core/utils/constants/Palette.dart';
import 'package:diary/features/todo_list/bloc/todo_list_bloc.dart';
import 'package:diary/features/calendar/bloc/bloc/calendar_bloc.dart';
import 'package:diary/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../core/utils/components/todo_card.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CalendarPageView();
  }
}

class CalendarPageView extends StatefulWidget {
  const CalendarPageView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarPageViewState createState() => _CalendarPageViewState();
}

class _CalendarPageViewState extends State<CalendarPageView> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    BlocProvider.of<CalendarBloc>(context).add(const LoadTasksCalendar());
    BlocProvider.of<CalendarBloc>(context).add(CalendarDateTap(_focusedDay));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final bloc = BlocProvider.of<CalendarBloc>(context);
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      bloc.add(CalendarDateTap(selectedDay));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksListBloc, TasksListState>(
      listener: (context, state) {
        if (state.taskListStatus == TasksListStatus.loaded) {
          BlocProvider.of<CalendarBloc>(context).add(const LoadTasksCalendar());
          BlocProvider.of<CalendarBloc>(context)
              .add(CalendarDateTap(_focusedDay));
        }
      },
      child:
          BlocBuilder<CalendarBloc, CalendarState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const BannerAdWidget(
                isSticky: true,
              ),
              TableCalendar<TaskModel>(
                firstDay: state.firstDay,
                lastDay: state.lastDay,
                focusedDay: _focusedDay,
                availableCalendarFormats: {
                  CalendarFormat.month: S.of(context).month,
                  CalendarFormat.twoWeeks: S.of(context).twoWeeks,
                  CalendarFormat.week: S.of(context).week
                },
                headerStyle: HeaderStyle(
                  titleTextFormatter: (date, locale) {
                    final title = DateFormat.yMMM(locale).format(date);
                    return title[0].toUpperCase() + title.substring(1);
                  },
                  formatButtonVisible: true,
                ),
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: (day) {
                  return state.tasks[day] ?? [];
                },
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                    markerDecoration: BoxDecoration(
                        color: Palette.markerColor, shape: BoxShape.circle),
                    outsideDaysVisible: false,
                    selectedDecoration: BoxDecoration(
                        color: Palette.primaryAccent, shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                        color: Palette.secondaryAccent,
                        shape: BoxShape.circle)),
                onDaySelected: _onDaySelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: BlocBuilder<CalendarBloc, CalendarState>(
                  builder: (context, state) {
                    if (state.tasksInSelectedDay.isEmpty) {
                      return Center(
                        child: Text(S.of(context).emptyDayCalendar),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.tasksInSelectedDay.length,
                      itemBuilder: (context, index) => TaskCard(
                          index: index, task: state.tasksInSelectedDay[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
