import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:diary/core/domain/enteties/note_entity.dart';
import 'package:diary/core/domain/repositories/note_repository.dart';
import 'package:diary/core/utils/components/action_button.dart';
import 'package:diary/core/utils/date_utils/date_utils.dart';
import 'package:diary/features/note/bloc/note_bloc.dart';
import 'package:diary/features/settings/bloc/bloc/settings_bloc.dart';
import 'package:diary/generated/l10n.dart';

import '../../core/services/ads/yandex_ads/banner/banner_ad.dart';

@RoutePage()
class NotePage extends StatelessWidget {
  const NotePage({
    super.key,
    this.note,
  });
  final NoteEntity? note;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NoteBloc(
          RepositoryProvider.of<AbstractNoteRepository>(context), note),
      child: NoteView(),
    );
  }
}

// ignore: must_be_immutable
class NoteView extends StatelessWidget {
  NoteView({super.key});
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteDescController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NoteBloc>(context);
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    bloc.add(NoteLoadEvent());
    return BlocConsumer<NoteBloc, NoteState>(listener: (context, state) {
      if (state.noteStatus == NoteStatus.saved) {
        AutoRouter.of(context).pushNamed("/");
      }
      if (state.noteStatus == NoteStatus.loading) {
        noteTitleController.text = bloc.state.title;
        noteDescController.text = bloc.state.note;
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            actions: [
              state.isUpdate
                  ? IconButton(
                      onPressed: () async {
                        bloc.add(NoteClearEvent());
                        AutoRouter.of(context).pushNamed("/");
                      },
                      icon: const Icon(
                        Icons.delete,
                      ))
                  : const SizedBox(),
              IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text(S.of(context).selectColor),
                              content: SingleChildScrollView(
                                child: BlockPicker(
                                  pickerColor: state.color,
                                  onColorChanged: (color) {
                                    bloc.add(ColorChangedEvent(color: color));
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ));
                  },
                  icon: Icon(
                    Icons.color_lens_rounded,
                    color: state.color,
                  ))
            ],
          ),
          body: (state.noteStatus == NoteStatus.loaded)
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                  child: Column(
                    children: [
                      const BannerAdWidget(
                        isSticky: true,
                      ),
                      TextField(
                        controller: noteTitleController,
                        onChanged: (title) {
                          BlocProvider.of<NoteBloc>(context)
                              .add(TitleChangedEvent(title: title));
                        },
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          hintText: S.of(context).titleNote,
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 28),
                      ),
                      Row(
                        children: [
                          Text(DateTimeUtils.formatDate(
                              DateTime.now(), settingsBloc.state.dateFormat)),
                          const Text("  |  "),
                          Text(state.note.length.toString())
                        ],
                      ),
                      Expanded(
                        child: TextField(
                          controller: noteDescController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (value) {
                            BlocProvider.of<NoteBloc>(context)
                                .add(NoteChangedEvent(note: value));
                          },
                          enableInteractiveSelection: true,
                          decoration: InputDecoration(
                            hintText: S.of(context).startTyping,
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: state.isUpdate
                            ? _ButtonAddNote(title: S.of(context).save)
                            : _ButtonAddNote(
                                title: S.of(context).addTaskButton),
                      ),
                    ],
                  ),
                )
              : const SizedBox());
    });
  }
}

class _ButtonAddNote extends StatelessWidget {
  const _ButtonAddNote({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          context.read<NoteBloc>().add(const NoteSaveEvent());
        },
        child: ActionButton(
          text: title,
        ));
  }
}
