import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/profiles/view_model/profile_bloc.dart';

class ArtworkDetailView extends StatefulWidget {
  final String artworkId;
  final VoidCallback onBack;

  const ArtworkDetailView({
    super.key,
    required this.artworkId,
    required this.onBack,
  });

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

  void _showDeleteConfirmationDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text("Are you sure you want to delete this artwork?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext), // Cancel button
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext); // Close dialog
                // Use the parentContext that has access to the ProfileBloc
                parentContext
                    .read<ProfileBloc>()
                    .add(DeleteArtworkById(widget.artworkId));
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (!state.isLoading &&
                      !state.artworks
                          .any((art) => art.artworkId == widget.artworkId)) {
                    // If the artwork is deleted, go back
                    widget.onBack();
                  }
                },
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
                              ? Image.network(
                                  artwork.images!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 300,
                                )
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
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Positioned(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorite ? Colors.red : Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite;
                                    });
                                  },
                                ),
                                const Icon(Icons.remove_red_eye,
                                    color: Colors.grey),
                              ],
                            ),
                            IconButton(
                              icon:
                                  const Icon(Icons.delete, color: Colors.black),
                              onPressed: () =>
                                  _showDeleteConfirmationDialog(context),
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
