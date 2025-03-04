import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/auth/presentation/view_model/artist/artist_bloc.dart';

class ArtistsView extends StatefulWidget {
  const ArtistsView({super.key});

  @override
  _ArtistsViewState createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  @override
  void initState() {
    super.initState();
    // Fetch all artists when the view is initialized
    context.read<ArtistBloc>().add(FetchAllArtists());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artists'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ArtistBloc, ArtistState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage != null) {
              return Center(
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (state.artists.isEmpty) {
              return const Center(child: Text('No artists found.'));
            } else {
              return ListView.builder(
                itemCount: state.artists.length,
                itemBuilder: (context, index) {
                  final artist = state.artists[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: artist.profilepic != null
                            ? NetworkImage(artist.profilepic!)
                            : null,
                        child: artist.profilepic == null
                            ? const Icon(Icons.person)
                            : null,
                      ),
                      title: Text(artist.full_name ?? 'Unknown Artist'),
                      subtitle: Text(artist.email ?? 'No email provided'),
                      onTap: () {
                        // Navigate to artist details or perform an action
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
