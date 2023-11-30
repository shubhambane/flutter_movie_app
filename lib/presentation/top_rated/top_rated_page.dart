import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix/data/models/movie.dart';
import 'package:movieflix/presentation/top_rated/bloc/top_rated_bloc.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({Key? key}) : super(key: key);

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  final TopRatedBloc topRatedBloc = TopRatedBloc();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    topRatedBloc.add(FetchTopRatedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopRatedBloc, TopRatedState>(
      bloc: topRatedBloc,
      listenWhen: (previous, current) => current is TopRatedActionState,
      buildWhen: (previous, current) => current is! TopRatedActionState,
      listener: (BuildContext context, TopRatedState state) {},
      builder: (context, state) {
        List<Movie> displayedMovies = [];

        if (state is TopRatedSuccess) {
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
                  prefixIcon: Icon(Icons.search),
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
                  return GestureDetector(
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
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  List<Movie> _getDisplayedMovies(TopRatedState state, String searchQuery) {
    if (state is TopRatedSuccess) {
      if (searchQuery.isEmpty) {
        return state.topRatedMovies;
      } else {
        return state.topRatedMovies
            .where((movie) =>
                movie.title.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
      }
    }
    return [];
  }
}
