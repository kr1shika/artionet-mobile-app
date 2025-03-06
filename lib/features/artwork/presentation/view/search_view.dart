import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/app/shared_prefs/token_shared_prefs.dart';
import 'package:tryproject/core/common/snackbar/my_snackbar.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
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
  String? userId;

  // Sensor variables
  late Stream<AccelerometerEvent> _accelerometerStream;
  bool _shakingDetected = false;

  // Dummy data to display when the server is down
  final List<ArtworkEntity> dummyArtworks = [
    const ArtworkEntity(
      artworkId: '1',
      title: 'Tando',
      price: '150.0',
      images: 'https://via.placeholder.com/150',
      dimensions: '',
      medium_used: '',
      categories: '',
    ),
    const ArtworkEntity(
      artworkId: '2',
      title: 'Lavestalu',
      price: '200.0',
      images: 'assets/images/blank.jpg',
      dimensions: '',
      medium_used: '',
      categories: '',
    ),
    const ArtworkEntity(
      artworkId: '3',
      title: 'Parasole',
      price: '120.0',
      images: 'assets/images/blank.jpg',
      dimensions: '',
      medium_used: '',
      categories: '',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _accelerometerStream = accelerometerEvents;
    _accelerometerStream.listen((AccelerometerEvent event) {
      if (mounted) {
        if (event.x > 12 || event.y > 12 || event.z > 12) {
          if (!_shakingDetected) {
            setState(() {
              _shakingDetected = true;
            });
            context.read<ArtworkBloc>().add(FetchAllArtworks());
          }
        } else {
          setState(() {
            _shakingDetected = false;
          });
        }
      }
    });
  }

  Future<void> _loadUserId() async {
    final tokenSharedPrefs = getIt<TokenSharedPrefs>();
    String? storedUserId = tokenSharedPrefs.getUserId();
    setState(() {
      userId = storedUserId;
    });
    print("User ID: $userId");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  decoration: InputDecoration(
                    labelText: 'Search Artwork',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        if (_searchFormKey.currentState!.validate()) {
                          context.read<ArtworkBloc>().add(
                                SearchArtworksEvent(searchController.text),
                              );
                        }
                      },
                    ),
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
                        return _buildArtworkGrid(context, dummyArtworks);
                      } else if (state.artworks.isEmpty) {
                        return const Center(child: Text('No artworks found.'));
                      } else {
                        return LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount =
                                constraints.maxWidth > 600 ? 3 : 2;
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.9,
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
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(1),
                                              topRight: Radius.circular(1),
                                            ),
                                            child: artwork.images != null
                                                ? Image.network(
                                                    artwork.images!,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    height: 150,
                                                  )
                                                : const Icon(
                                                    Icons.image_not_supported,
                                                    size: 100,
                                                  ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      artwork.title,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      'Price: ${artwork.price}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        color: Color.fromARGB(
                                                            255, 24, 24, 24),
                                                      ),
                                                    ),
                                                  ],
                                                ),
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
                                                                  userId ?? '',
                                                            ),
                                                          );
                                                    } else {
                                                      likedArtworks.add(
                                                          artwork.artworkId!);
                                                      context
                                                          .read<ArtworkBloc>()
                                                          .add(
                                                            SaveArtworkEvent(
                                                              artId: artwork
                                                                  .artworkId!,
                                                              buyerId:
                                                                  userId ?? '',
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
                    showAppBar: false,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Extracted method to build the GridView for artworks
  Widget _buildArtworkGrid(BuildContext context, List<ArtworkEntity> artworks) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.9,
          ),
          itemCount: artworks.length,
          itemBuilder: (context, index) {
            final artwork = artworks[index];
            final isLiked = likedArtworks
                .contains(artwork.artworkId); // Use class-level likedArtworks
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
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(1),
                          topRight: Radius.circular(1),
                        ),
                        child: artwork.images != null
                            ? Image.network(
                                artwork.images!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: 150,
                              )
                            : const Icon(
                                Icons.image_not_supported,
                                size: 100,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    color: Color.fromARGB(255, 24, 24, 24),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isLiked) {
                                  likedArtworks.remove(artwork.artworkId);
                                  context.read<ArtworkBloc>().add(
                                        RemoveSavedArtworkEvent(
                                          artId: artwork.artworkId!,
                                          buyerId: userId ?? '',
                                        ),
                                      );
                                } else {
                                  likedArtworks.add(artwork.artworkId!);
                                  context.read<ArtworkBloc>().add(
                                        SaveArtworkEvent(
                                          artId: artwork.artworkId!,
                                          buyerId: userId ?? '',
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
      },
    );
  }
}
