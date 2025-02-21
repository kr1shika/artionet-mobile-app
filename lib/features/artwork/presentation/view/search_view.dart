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
                        return ListView.builder(
                          itemCount: state.artworks.length,
                          itemBuilder: (context, index) {
                            final artwork = state.artworks[index];
                            return Card(
                              elevation: 3,
                              child: ListTile(
                                leading: artwork.images != null
                                    ? Image.network(
                                        artwork.images!,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(Icons.image_not_supported),
                                title: Text(artwork.title),
                                subtitle: Text(
                                    'Medium: ${artwork.medium_used}\nPrice: ${artwork.price}'),
                                onTap: () {
                                  setState(() {
                                    selectedArtworkId = artwork
                                        .artworkId; // Set selected artwork
                                  });
                                  BlocProvider.of<ArtworkBloc>(context).add(
                                    FetchArtworkById(artwork.artworkId ?? ''),
                                  );
                                },
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
                      artworkId: selectedArtworkId!), // Show detail view
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
