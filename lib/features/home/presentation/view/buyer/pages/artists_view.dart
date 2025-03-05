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
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: artist.profilepic != null
                                        ? NetworkImage(artist.profilepic!)
                                        : null,
                                    child: artist.profilepic == null
                                        ? const Icon(Icons.person, size: 40)
                                        : null,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    artist.full_name ?? 'Unknown Artist',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 0),
                                  Text(
                                    artist.email ?? 'No email provided',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
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
                      child: GestureDetector(
                        onTap: () {
                          // Close the artworks container when tapped
                          setState(() {
                            selectedArtistId = null;
                          });
                        },
                        child: Container(
                          color: Colors
                              .transparent, // Make the background transparent
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
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // Two artworks per row
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio:
                                        0.7, // Adjust height proportionally
                                  ),
                                  itemCount: state.artworks.length,
                                  itemBuilder: (context, index) {
                                    final artwork = state.artworks[index];
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(1),
                                              child: artwork.images != null
                                                  ? Image.network(
                                                      artwork.images!,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : const Icon(Icons.image,
                                                      size: 50),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              artwork.title ?? 'Untitled',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
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
