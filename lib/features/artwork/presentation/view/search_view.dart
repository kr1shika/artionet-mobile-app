import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/common/snackbar/my_snackbar.dart';
import 'package:tryproject/features/artwork/presentation/view/details_view.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';
import 'package:tryproject/features/home/presentation/view_model/home_cubit.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final searchController = TextEditingController();
  final _searchFormKey = GlobalKey<FormState>();
  String? selectedArtworkId;
  final Set<String> likedArtworks = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFF7),
        centerTitle: true,
        title: selectedArtworkId == null
            ? Image.asset(
                'assets/images/logo.png',
                height: 43,
                fit: BoxFit.contain,
              )
            : const Text('Artwork Details'),
        leading: selectedArtworkId != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    selectedArtworkId = null;
                  });
                },
              )
            : null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {
              showMySnackBar(
                context: context,
                message: 'Logging out...',
                color: Colors.red,
              );
              context.read<HomeCubit>().logout(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _searchFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (selectedArtworkId == null) ...[
                TextFormField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search Artwork',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter artwork name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<ArtworkBloc, ArtworkState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.errorMessage != null) {
                        return Center(
                          child: Text(
                            state.errorMessage!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (state.artworks.isEmpty) {
                        return const Center(child: Text('No artworks found.'));
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: state.artworks.length,
                          itemBuilder: (context, index) {
                            final artwork = state.artworks[index];
                            final isLiked =
                                likedArtworks.contains(artwork.artworkId);
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedArtworkId = artwork.artworkId;
                                });
                                BlocProvider.of<ArtworkBloc>(context).add(
                                  FetchArtworkById(artwork.artworkId ?? ''),
                                );
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                        ),
                                        child: artwork.images != null
                                            ? Image.network(
                                                artwork.images!,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              )
                                            : const Icon(
                                                Icons.image_not_supported,
                                                size: 100,
                                              ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                artwork.title,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Price: ${artwork.price}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 24, 24, 24)),
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              isLiked
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isLiked
                                                  ? Colors.red
                                                  : Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (isLiked) {
                                                  likedArtworks.remove(
                                                      artwork.artworkId);
                                                  context
                                                      .read<ArtworkBloc>()
                                                      .add(
                                                        RemoveSavedArtworkEvent(
                                                          artId: artwork
                                                              .artworkId!,
                                                          buyerId:
                                                              '679cb11ed81a6e1b96420af0', // Replace with actual buyer ID
                                                        ),
                                                      );
                                                } else {
                                                  likedArtworks
                                                      .add(artwork.artworkId!);
                                                  context
                                                      .read<ArtworkBloc>()
                                                      .add(
                                                        SaveArtworkEvent(
                                                          artId: artwork
                                                              .artworkId!,
                                                          buyerId:
                                                              '679cb11ed81a6e1b96420af0', // Replace with actual buyer ID
                                                        ),
                                                      );
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: DetailView(
                    artworkId: selectedArtworkId!,
                    buyerId: '',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
