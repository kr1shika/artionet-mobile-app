import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/presentation/view/details_view.dart';
import 'package:tryproject/features/artwork/presentation/view/upload_artwork_view.dart';
import 'package:tryproject/features/profiles/view/artwork-crud/artwork_details.dart';
import 'package:tryproject/features/profiles/view_model/profile_bloc.dart'
    as profile;

class CustomerProfileView extends StatefulWidget {
  final String userId;

  const CustomerProfileView({super.key, required this.userId});

  @override
  CustomerProfileViewState createState() => CustomerProfileViewState();
}

class CustomerProfileViewState extends State<CustomerProfileView> {
  String? selectedArtworkId;

  @override
  void initState() {
    super.initState();
    final profileBloc = context.read<profile.ProfileBloc>();

    // Fetch uploaded and saved artworks when the profile screen loads
    profileBloc.add(profile.FetchArtworkByUserID(userId: widget.userId));
    profileBloc.add(profile.GetCollection(buyerId: widget.userId));
  }

  void _closeDetailView() {
    setState(() {
      selectedArtworkId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: selectedArtworkId == null
            ? DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    ClipOval(
                      child: Image.asset(
                        'assets/images/krishika.jpg',
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "@kr1shika",
                      style: TextStyle(
                        fontFamily: 'IM_FELL_Great_Primer',
                        fontSize: 26,
                      ),
                    ),
                    const SizedBox(height: 3),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<profile.ProfileBloc>()
                            .add(profile.NavigateToUpload(
                              context: context,
                              destination: const UploadPage(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 1),
                        backgroundColor: const Color.fromARGB(73, 27, 29, 30),
                        foregroundColor: const Color(0xFFFFFFF7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Upload',
                        style: TextStyle(
                          fontFamily: 'IM_FELL_Great_Primer',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.black,
                      tabs: [
                        Tab(text: "Your Artworks"),
                        Tab(text: "Saved"),
                      ],
                    ),
                    Expanded(
                      child: BlocBuilder<profile.ProfileBloc,
                          profile.ProfileState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state.errorMessage.isNotEmpty) {
                            return Center(
                              child: Text(
                                state.errorMessage,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 16),
                              ),
                            );
                          }

                          return TabBarView(
                            children: [
                              _buildUploadedArtworks(state),
                              _buildSavedArtworks(state),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : ArtworkDetailView(
                artworkId: selectedArtworkId!,
                onBack: _closeDetailView,
              ),
      ),
    );
  }

  /// Builds the "Your Artworks" tab
  Widget _buildUploadedArtworks(profile.ProfileState state) {
    if (state.artworks.isEmpty) {
      return const Center(
        child: Text(
          "No artworks uploaded yet!",
          style: TextStyle(
            fontFamily: 'IM_FELL_Great_Primer',
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: state.artworks.length,
      itemBuilder: (context, index) {
        final artwork = state.artworks[index];
        return _buildArtworkCard(
          artwork.artworkId ?? '',
          artwork.images,
          artwork.title ?? 'Unknown Art',
          artwork.archive ?? 'Unknown',
          isSavedTab: false, // This is for the "Your Artworks" tab
        );
      },
    );
  }

  /// Builds the "Saved" tab
  Widget _buildSavedArtworks(profile.ProfileState state) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: state.collection.length,
      itemBuilder: (context, index) {
        final savedArtwork = state.collection[index];
        return _buildArtworkCard(
          savedArtwork.art_id,
          savedArtwork.imageUrl,
          savedArtwork.title ?? '',
          'Unknown',
          isSavedTab: true,
          isLiked: true, // Pass isLiked as true for saved artworks
        );
      },
    );
  }

  Widget _buildArtworkCard(
    String artworkId,
    String? imageUrl,
    String title,
    String status, {
    required bool isSavedTab,
    bool isLiked = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (isSavedTab) {
          // For the "Saved" tab, navigate to DetailView using the event
          context.read<profile.ProfileBloc>().add(
                profile.NavigateToDetailView(
                  context: context,
                  destination: DetailView(
                    artworkId: artworkId,
                    buyerId: '679cb11ed81a6e1b96420af0',
                    isLiked: isLiked,
                    onBack: _closeDetailView, // Pass the onBack callback
                  ),
                ),
              );
        } else {
          // For the "Your Artworks" tab, update selectedArtworkId
          setState(() {
            selectedArtworkId = artworkId;
          });
          context.read<profile.ProfileBloc>().add(
                profile.FetchArtworkById(artworkId),
              );
        }
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      height: 175,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Status: $status',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
