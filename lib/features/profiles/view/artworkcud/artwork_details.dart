import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/profiles/view_model/profile_bloc.dart';

class ArtworkDetailView extends StatefulWidget {
  final String artworkId;
  final VoidCallback onBack;

  const ArtworkDetailView(
      {super.key, required this.artworkId, required this.onBack});

  @override
  _ArtworkDetailViewState createState() => _ArtworkDetailViewState();
}

class _ArtworkDetailViewState extends State<ArtworkDetailView> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchArtworkById(widget.artworkId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  final artwork = state.selectedArtwork;

                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    );
                  } else if (artwork == null) {
                    return const Center(child: Text('Artwork not found.'));
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          artwork.images != null
                              ? Image.network(artwork.images!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 300)
                              : const Icon(Icons.image_not_supported,
                                  size: 100),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: GestureDetector(
                              onTap: widget.onBack,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black54,
                                ),
                                child: const Icon(Icons.close_rounded,
                                    color: Color.fromARGB(255, 252, 252, 252)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                            ),
                            const Icon(Icons.remove_red_eye,
                                color: Colors.grey), // Views Icon Placeholder
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to edit page
                              },
                              child: const Text("Edit"),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        artwork.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Medium: ${artwork.medium_used}'),
                      Text('Price: ${artwork.price}'),
                      Text('Archive Status: ${artwork.archive}'),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Toggle between private and public
                          },
                          child: Text(artwork.archive == 'public'
                              ? 'Make Private'
                              : 'Make Public'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
