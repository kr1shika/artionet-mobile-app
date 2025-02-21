import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/presentation/view_model/artwork_bloc.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final searchController = TextEditingController();
  final _searchFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Artworks')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _searchFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
              // ElevatedButton(
              //   onPressed: () {
              //     if (_searchFormKey.currentState!.validate()) {
              //       context.read<ArtworkBloc>().add(
              //             FetchArtworks(searchController.text),
              //           );
              //     }
              //   },
              //   child: const Text('Search'),
              // ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<ArtworkBloc, ArtworkState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.errorMessage != null) {
                      // return showMySnackBar(
                      //   context: context,
                      //   message: state.errorMessage!,
                      //   color: Colors.red,
                      // );
                      return Center(
                        child: Text(
                          state.errorMessage!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
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
                                  ? Image.network(artwork.images!,
                                      width: 50, height: 50, fit: BoxFit.cover)
                                  : const Icon(Icons.image_not_supported),
                              title: Text(artwork.title),
                              subtitle: Text(
                                  'Medium: ${artwork.medium_used}\nPrice: ${artwork.price}'),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
