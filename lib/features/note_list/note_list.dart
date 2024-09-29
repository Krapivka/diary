import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:diary/core/domain/enteties/note_entity.dart';
import 'package:diary/core/services/ads/yandex_ads/banner/banner_ad.dart';
import 'package:diary/features/note_list/bloc/note_list_bloc.dart';
import 'package:diary/features/note_list/widgets/note_card.dart';
import 'package:diary/features/note_list/widgets/note_search.dart';
import 'package:diary/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NotesListPage extends StatelessWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotesListView();
  }
}

class NotesListView extends StatefulWidget {
  const NotesListView({
    super.key,
  });

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotesListBloc>(context);
    bloc.add(const LoadNotesListEvent());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: [
            const BannerAdWidget(
              isSticky: true,
            ),
            const NoteSearch(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: BlocBuilder<NotesListBloc, NotesListState>(
                      builder: (context, state) {
                    if (state.noteListStatus == NotesListStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state.noteListStatus == NotesListStatus.loaded) {
                      final List<NoteEntity> notes = state.listNoteModel;
                      if (notes.isNotEmpty) {
                        return MasonryGridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 7,
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return NoteCard(note: notes[index]);
                          },
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/notes.svg',
                                  semanticsLabel: 'ToDo'),
                              Text(
                                S.of(context).emptyNoteList,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                    }
                    if (state.noteListStatus == NotesListStatus.searchLoaded) {
                      final List<NoteEntity> notes = state.sortedListNoteModel;

                      if (notes.isNotEmpty) {
                        return MasonryGridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 7,
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            return NoteCard(note: notes[index]);
                          },
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/notes.svg',
                                  semanticsLabel: 'ToDo'),
                              Text(
                                S.of(context).theNoteWasNotFound,
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
            ),
          ],
        ),
      ),
    );
  }
}
