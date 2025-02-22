import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view/purchase_view.dart';

class DetailView extends StatefulWidget {
  final String artworkId;

  const DetailView({super.key, required this.artworkId});

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  bool isFavorite = false; // Track heart icon state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        artwork.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite; // Toggle favorite state
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text('Medium: ${artwork.medium_used}'),
                Text('Price: ${artwork.price}'),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ArtworkBloc>().add(
                            NavigateToPurchase(
                              context: context,
                              destination:
                                  PurchaseView(artworkId: widget.artworkId),
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    child: const Text('Purchase'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
