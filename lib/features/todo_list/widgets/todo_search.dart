import 'package:diary/features/todo_list/bloc/todo_list_bloc.dart';
import 'package:diary/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskSearch extends StatelessWidget {
  const TaskSearch({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    final bloc = BlocProvider.of<TasksListBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        // readOnly: readOnly,
        // showCursor: showCursor,
        // enableInteractiveSelection: false,
        onChanged: (value) {
          bloc.add(SearchTasksListEvent(query: value));
        },
        controller: controller,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          suffixIcon: BlocConsumer<TasksListBloc, TasksListState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state.taskListStatus == TasksListStatus.searchLoaded) {
                return IconButton(
                    onPressed: () {
                      controller.clear();
                      bloc.add(const LoadTasksListEvent());
                    },
                    icon: const Icon(Icons.clear));
              }
              return const SizedBox();
            },
          ),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          //     labelText: labelText,
          hintText: S.of(context).search,
          //   ),
          //   onTap: onTap,
          // ),
        ),
      ),
    );
  }
}
