import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/presentation/view/upload_artwork_view.dart';
import 'package:tryproject/features/profiles/view/artwork-crud/artwork_details.dart';
import 'package:tryproject/features/profiles/view_model/profile_bloc.dart';

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
    context
        .read<ProfileBloc>()
        .add(FetchArtworkByUserID(userId: widget.userId));
  }

  void _closeDetailView() {
    setState(() {
      selectedArtworkId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: selectedArtworkId == null
      //     ? null
      //     : AppBar(
      //         // title: const Text("Artwork Details"),
      //         leading: IconButton(
      //           icon: const Icon(Icons.arrow_back),
      //           onPressed: _closeDetailView,
      //         ),
      //       ),
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
                        context.read<ProfileBloc>().add(NavigateToUpload(
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
                      child: BlocBuilder<ProfileBloc, ProfileState>(
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
                          } else if (state.artworks.isEmpty) {
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
                          } else {
                            return TabBarView(
                              children: [
                                GridView.builder(
                                  padding: const EdgeInsets.all(8),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 0.8,
                                  ),
                                  itemCount: state.artworks.length,
                                  itemBuilder: (context, index) {
                                    final artwork = state.artworks[index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedArtworkId = artwork.artworkId;
                                        });
                                        BlocProvider.of<ProfileBloc>(context)
                                            .add(
                                          FetchArtworkById(
                                              artwork.artworkId ?? ''),
                                        );
                                      },
                                      child: Card(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(2),
                                                topRight: Radius.circular(2),
                                              ),
                                              child: artwork.images != null
                                                  ? Image.network(
                                                      artwork.images!,
                                                      height: 175,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Container(
                                                      height: 150,
                                                      color: Colors.grey[300],
                                                      child: const Icon(
                                                        Icons
                                                            .image_not_supported,
                                                        size: 50,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    artwork.title ??
                                                        'Unknown Art',
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    'State: ${artwork.archive}',
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
                                  },
                                ),
                                const Center(
                                  child: Text(
                                    "No saved posts yet!",
                                    style: TextStyle(
                                      fontFamily: 'IM_FELL_Great_Primer',
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )
            : ArtworkDetailView(
                artworkId: selectedArtworkId!,
                onBack: () {
                  setState(() {
                    selectedArtworkId = null; // This will close the detail page
                  });
                },
              ),
      ),
    );
  }
}
