import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';

class DetailView extends StatelessWidget {
  final String artworkId;

  const DetailView({super.key, required this.artworkId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Artwork Details')),
      body: BlocBuilder<ArtworkBloc, ArtworkState>(
        builder: (context, state) {
          final artwork = state.selectedArtwork;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage != null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (artwork == null) {
            return const Center(child: Text('Artwork not found.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                artwork.images != null
                    ? Image.network(artwork.images!, fit: BoxFit.cover)
                    : const Icon(Icons.image_not_supported, size: 100),
                const SizedBox(height: 10),
                Text(
                  artwork.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text('Medium: ${artwork.medium_used}'),
                Text('Price: ${artwork.price}'),
                const SizedBox(height: 10),
                // Text(artwork.description ?? 'No description available'),
              ],
            ),
          );
        },
      ),
    );
  }
}
