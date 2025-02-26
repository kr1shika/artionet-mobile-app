import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view/purchase_view.dart';

class DetailView extends StatefulWidget {
  final String artworkId;
  final String buyerId;
  final bool? isLiked;
  final VoidCallback? onBack; // Add onBack callback

  const DetailView({
    super.key,
    required this.artworkId,
    required this.buyerId,
    this.isLiked,
    this.onBack, // Optional onBack callback
  });

  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    // Initialize isFavorite based on the passed isLiked parameter
    if (widget.isLiked != null) {
      isFavorite = widget.isLiked!;
    }

    // Fetch artwork details and check liked status
    context.read<ArtworkBloc>().add(FetchArtworkById(widget.artworkId));
    if (widget.isLiked == null) {
      context.read<ArtworkBloc>().add(CheckArtworkStatusEvent(
            artId: widget.artworkId,
            buyerId: widget.buyerId,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ArtworkBloc, ArtworkState>(
        builder: (context, state) {
          final artwork = state.selectedArtwork;

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage?.isNotEmpty ?? false) {
            return Center(
              child: Text(
                state.errorMessage ?? 'An error occurred',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          } else if (artwork == null) {
            return const Center(child: Text('Artwork not found.'));
          }

          // Use the local isFavorite state instead of the Bloc state
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Artwork Image
                    artwork.images != null
                        ? Image.network(artwork.images!, fit: BoxFit.cover)
                        : const Icon(Icons.image_not_supported, size: 100),
                    const SizedBox(height: 10),
                    // Title and Like Button
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
                            final artworkBloc = context.read<ArtworkBloc>();

                            // Update the local state immediately
                            setState(() {
                              isFavorite = !isFavorite;
                            });

                            if (isFavorite) {
                              // Like the artwork
                              artworkBloc.add(SaveArtworkEvent(
                                artId: widget.artworkId,
                                buyerId: widget.buyerId,
                              ));
                            } else {
                              // Unlike the artwork
                              artworkBloc.add(RemoveSavedArtworkEvent(
                                artId: widget.artworkId,
                                buyerId: widget.buyerId,
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Medium and Price
                    Text('Medium: ${artwork.medium_used}'),
                    Text('Price: ${artwork.price}'),
                    const SizedBox(height: 20),
                    // Purchase Button
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
              ),
              // Cross Button to go back
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 30),
                  onPressed: () {
                    if (widget.onBack != null) {
                      widget.onBack!(); // Call the onBack callback
                    } else {
                      Navigator.pop(
                          context); // Fallback to default back navigation
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
