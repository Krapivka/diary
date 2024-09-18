import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diary/core/domain/enteties/note_entity.dart';

import 'package:diary/core/utils/date_utils/date_utils.dart';
import 'package:diary/features/note_list/bloc/note_list_bloc.dart';
import 'package:diary/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:diary/router/router.dart';

class NoteCard extends StatefulWidget {
  const NoteCard({
    super.key,
    required this.note,
  });
  final NoteEntity note;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
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
    // final file = File(widget.note.filePath);
    final settingsBloc = context.watch<SettingsBloc>();
    final noteListBloc = BlocProvider.of<NotesListBloc>(context);

    return BlocBuilder<NotesListBloc, NotesListState>(
      builder: (context, state) {
        //use animate when widget rebuild
        animateCard();
        return AnimatedOpacity(
          opacity: _visible ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                if (state.selectedNoteId.isEmpty) {
                  AutoRouter.of(context).push(NoteRoute(note: widget.note));
                } else {
                  noteListBloc.add(TapNoteCardEvent(id: widget.note.id));
                }
              },
              onLongPress: () {
                noteListBloc.add(LongPressNoteCardEvent(id: widget.note.id));
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: noteListBloc.state.selectedNoteId
                          .contains(widget.note.id)
                      ? const Color.fromARGB(255, 190, 190, 190)
                      : Color(int.parse(widget.note.color)).withOpacity(0.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.note.title == ""
                            ? (widget.note.description.split(" "))[0]
                            : widget.note.title,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        maxLines: 2,
                      ),
                      Text(
                        widget.note.description,
                        maxLines: 5,
                      ),
                      Text(DateTimeUtils.formatDate(
                          widget.note.dateTime, settingsBloc.state.dateFormat))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:diary/core/domain/enteties/note_entity.dart';
// import 'package:diary/core/utils/date_utils/date_utils.dart';
// import 'package:diary/features/settings/bloc/bloc/settings_bloc.dart';
// import 'package:diary/router/router.dart';

// class NoteCard extends StatelessWidget {
//   final NoteEntity note;

//   const NoteCard({
//     super.key,
//     required this.note,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final settingsBloc = BlocProvider.of<SettingsBloc>(context);
//     return Container(
//       decoration: BoxDecoration(
//           color: note.color != ""
//               ? Color(int.parse(note.color)).withOpacity(0.5)
//               : Color(0xFFF7F7F7),
//           borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               note.title == "" ? (note.description.split(" "))[0] : note.title,
//               style: const TextStyle(
//                 fontSize: 20,
//               ),
//               maxLines: 2,
//             ),
//             Text(
//               note.description,
//               maxLines: 5,
//             ),
//             Text(DateTimeUtils.formatDate(
//                 DateTime.now(), settingsBloc.state.dateFormat))
//           ],
//         ),
//       ),
//     );
//   }
// }
