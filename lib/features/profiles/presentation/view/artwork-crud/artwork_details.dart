import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/profiles/presentation/view_model/profile_bloc.dart';

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
  bool isEditMode = false;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController mediumController = TextEditingController();
  final TextEditingController archiveController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchArtworkById(widget.artworkId));
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    mediumController.dispose();
    archiveController.dispose();
    super.dispose();
  }

  void _toggleEditMode(ProfileState state) {
    setState(() {
      isEditMode = !isEditMode;
      if (isEditMode && state.selectedArtwork != null) {
        // Reset fields when entering edit mode
        titleController.text = state.selectedArtwork!.title;
        priceController.text = state.selectedArtwork!.price;
        mediumController.text = state.selectedArtwork!.medium_used;
        archiveController.text = state.selectedArtwork!.archive ?? '';
      }
    });
  }

  void _saveChanges(BuildContext context, ProfileState state) {
    final artwork = state.selectedArtwork;
    if (artwork != null) {
      context.read<ProfileBloc>().add(
            UpdateArtworkEvent(
              
              artworkId: artwork.artworkId!,
              title: titleController.text.trim().isNotEmpty
                  ? titleController.text
                  : artwork.title,
              dimensions: artwork.dimensions,
              price: priceController.text.trim().isNotEmpty
                  ? priceController.text
                  : artwork.price,
              mediumUsed: mediumController.text.trim().isNotEmpty
                  ? mediumController.text
                  : artwork.medium_used,
              categories: artwork.categories,
              creatorsNote: artwork.creatorsNote,
              images: artwork.images,
              context: context,
            ),
            
          );
    }
    // print(update title);
    _toggleEditMode(state);
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
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
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
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (!state.isLoading &&
              !state.artworks.any((art) => art.artworkId == widget.artworkId)) {
            widget.onBack();
          }
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Artwork updated successfully!')),
            );
          } else if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
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

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                        : const Icon(Icons.image_not_supported, size: 100),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                        ),
                        const Icon(Icons.remove_red_eye, color: Colors.grey),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isEditMode ? Icons.check : Icons.edit,
                            color: Colors.black,
                          ),
                          onPressed: () => isEditMode
                              ? _saveChanges(context, state)
                              : _toggleEditMode(state),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.black),
                          onPressed: () =>
                              _showDeleteConfirmationDialog(context),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                isEditMode
                    ? TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          hintText: artwork.title,
                        ),
                      )
                    : Text(
                        artwork.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                const SizedBox(height: 10),
                isEditMode
                    ? TextFormField(
                        controller: mediumController,
                        decoration: InputDecoration(
                          labelText: 'Medium',
                          hintText: artwork.medium_used,
                        ),
                      )
                    : Text('Medium: ${artwork.medium_used}'),
                isEditMode
                    ? TextFormField(
                        controller: priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          hintText: artwork.price,
                        ),
                      )
                    : Text('Price: ${artwork.price}'),
                isEditMode
                    ? TextFormField(
                        controller: archiveController,
                        decoration: InputDecoration(
                          labelText: 'Archive Status',
                          hintText: artwork.archive ?? 'N/A',
                        ),
                      )
                    : Text('Archive Status: ${artwork.archive}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
