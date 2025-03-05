import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/auth/presentation/view_model/artist/artist_bloc.dart';

class ArtistsView extends StatefulWidget {
  const ArtistsView({super.key});

  @override
  _ArtistsViewState createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  String? selectedArtistId;

  @override
  void initState() {
    super.initState();
    // Fetch all artists when the view is initialized
    context.read<ArtistBloc>().add(FetchAllArtists());
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Artists'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage != null) {
              return Center(
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (state.artists.isEmpty) {
              return const Center(child: Text('No artists found.'));
            } else {
              return Column(
                children: [
                  if (selectedArtistId == null)
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 0.9, // Adjust height proportionally
                        ),
                        itemCount: state.artists.length,
                        itemBuilder: (context, index) {
                          final artist = state.artists[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedArtistId = artist.userId;
                              });
                              context
                                  .read<ArtistBloc>()
                                  .add(FetchArtworksByUserId(artist.userId!));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.3),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 50,
                                    backgroundImage: artist.profilepic != null
                                        ? NetworkImage(artist.profilepic!)
                                        : null,
                                    child: artist.profilepic == null
                                        ? const Icon(Icons.person, size: 40)
                                        : null,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    artist.full_name ?? 'Unknown Artist',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    artist.email ?? 'No email provided',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  if (selectedArtistId != null)
                    Expanded(
                      child: Column(
                        children: [
                          // Back button to return to the artists grid
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              setState(() {
                                selectedArtistId = null;
                              });
                            },
                          ),
                          Expanded(
                            child: BlocBuilder<ArtistBloc, ArtistState>(
                              builder: (context, state) {
                                if (state.isLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state.errorMessage != null) {
                                  return Center(
                                    child: Text(
                                      state.errorMessage!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                } else if (state.artworks.isEmpty) {
                                  return const Center(
                                      child: Text(
                                          'No artworks found for this artist.'));
                                } else {
                                  return ListView.builder(
                                    itemCount: state.artworks.length,
                                    itemBuilder: (context, index) {
                                      final artwork = state.artworks[index];
                                      return ListTile(
                                        title:
                                            Text(artwork.title ?? 'Untitled'),
                                        leading: artwork.images != null
                                            ? Image.network(artwork.images!)
                                            : const Icon(Icons.image),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
