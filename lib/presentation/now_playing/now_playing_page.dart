import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix/data/models/movie.dart';
import 'package:movieflix/presentation/now_playing/bloc/now_playing_bloc.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({Key? key}) : super(key: key);

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage> {
  final NowPlayingBloc nowPlayingBloc = NowPlayingBloc();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nowPlayingBloc.add(FetchNowPlayingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NowPlayingBloc, NowPlayingState>(
      bloc: nowPlayingBloc,
      listenWhen: (previous, current) => current is NowPlayingActionState,
      buildWhen: (previous, current) => current is! NowPlayingActionState,
      listener: (BuildContext context, NowPlayingState state) {},
      builder: (context, state) {
        List<Movie> displayedMovies = [];

        if (state is NowPlayingSuccess) {
          displayedMovies = _getDisplayedMovies(state, searchController.text);
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Search for movies...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    displayedMovies = _getDisplayedMovies(state, value);
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: displayedMovies.length,
                itemBuilder: (context, index) {
                  final movie = displayedMovies[index];
                  return Dismissible(
                    key: Key(movie.id.toString()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        displayedMovies.removeAt(index);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 16),
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/movieInfo',
                            arguments: movie);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      movie.overview,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  List<Movie> _getDisplayedMovies(NowPlayingState state, String searchQuery) {
    if (state is NowPlayingSuccess) {
      if (searchQuery.isEmpty) {
        return state.nowPlayingMovies;
      } else {
        return state.nowPlayingMovies
            .where((movie) =>
                movie.title.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
      }
    }
    return [];
  }
}
