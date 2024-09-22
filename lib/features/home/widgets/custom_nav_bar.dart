import 'package:diary/features/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
    required this.selectedTab,
    required this.sizeIcon,
  });

  final HomeTab selectedTab;
  final double? sizeIcon;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 70,
      // backgroundColor: Theme.of(context).colorScheme.surface,
      indicatorColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      selectedIndex: selectedTab.index,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      onDestinationSelected: (index) {
        context.read<HomeCubit>().setTab(index);
      },
      destinations: <Widget>[
        //NOTES
        NavigationDestination(
          selectedIcon: FaIcon(
            FontAwesomeIcons.solidNoteSticky,
            size: sizeIcon,
          ),
          icon: FaIcon(
            FontAwesomeIcons.noteSticky,
            size: sizeIcon,
          ),
          label: "",
          // label: S.of(context).notes,
        ),
        // TASKS
        NavigationDestination(
          selectedIcon: Icon(
            Icons.task,
            size: sizeIcon,
          ),
          icon: Icon(
            Icons.task_outlined,
            size: sizeIcon,
          ),
          label: "",
          // label: S.of(context).tasks,
        ),
        //CALENDAR
        NavigationDestination(
          selectedIcon: FaIcon(
            FontAwesomeIcons.solidCalendar,
            size: sizeIcon,
          ),
          icon: FaIcon(
            FontAwesomeIcons.calendar,
            size: sizeIcon,
          ),
          label: "",
          // label: S.of(context).calendar,
        ),
        //SETTINGS
        NavigationDestination(
          selectedIcon: FaIcon(
            FontAwesomeIcons.solidUser,
            size: sizeIcon,
          ),
          icon: FaIcon(
            FontAwesomeIcons.user,
            size: sizeIcon,
          ),
          label: "",
          // label: S.of(context).settings,
        ),
      ],
    );
  }
}
