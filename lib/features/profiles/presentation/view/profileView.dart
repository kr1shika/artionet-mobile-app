import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/app/shared_prefs/token_shared_prefs.dart';
import 'package:tryproject/app/widget/fall_back.dart'; // FallbackWidget
import 'package:tryproject/app/widget/loading.dart';
import 'package:tryproject/features/artwork/presentation/view/details_view.dart';
import 'package:tryproject/features/artwork/presentation/view/upload_artwork_view.dart';
import 'package:tryproject/features/profiles/presentation/view/artwork-crud/artwork_details.dart';
import 'package:tryproject/features/profiles/presentation/view/edit_profile_form.dart';
import 'package:tryproject/features/profiles/presentation/view_model/profile_bloc.dart'
    as profile;
import 'package:tryproject/features/profiles/presentation/view_model/upload_edit/crud_bloc.dart';

class CustomerProfileView extends StatefulWidget {
  final String userId;

  const CustomerProfileView({super.key, required this.userId});

  @override
  CustomerProfileViewState createState() => CustomerProfileViewState();
}

class CustomerProfileViewState extends State<CustomerProfileView> {
  String? selectedArtworkId;
  String? userId;
  DateTime? _loadingStartTime; // Track when loading starts

  Future<void> _loadUserId() async {
    final tokenSharedPrefs = getIt<TokenSharedPrefs>();
    String? storedUserId = tokenSharedPrefs.getUserId();
    setState(() {
      userId = storedUserId;
    });
    print("Customer view page User ID: $userId");
  }

  @override
  void initState() {
    super.initState();
    _loadUserId();

    final profileBloc = context.read<profile.ProfileBloc>();
    setState(() {
      _loadingStartTime = DateTime.now(); // Start timing
    });
    profileBloc.add(profile.FetchArtworkByUserID(userId: widget.userId));
    profileBloc.add(profile.GetCollection(buyerId: widget.userId));
    profileBloc.add(profile.FetchUserById(widget.userId));
  }

  void _closeDetailView() {
    setState(() {
      selectedArtworkId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        actions: [_buildEditProfileButton()],
        toolbarHeight: 34,
      ),
      body: SafeArea(
        child: selectedArtworkId == null
            ? DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    BlocBuilder<profile.ProfileBloc, profile.ProfileState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const LoadingWidget(); // Use custom LoadingWidget
                        }
                        if (state.selectedUser == null) {
                          return const Center(child: Text("Krishika"));
                        }
                        return Column(
                          children: [
                            ClipOval(
                              child: state.errorMessage.isNotEmpty ||
                                      state.selectedUser!.profilepic == null
                                  ? Image.asset(
                                      'assets/images/blank.jpg',
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      state.selectedUser!.profilepic ??
                                          'assets/images/default.jpg',
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/images/blank.jpg',
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.selectedUser!.full_name,
                              style: const TextStyle(
                                fontFamily: 'IM_FELL_Great_Primer',
                                fontSize: 26,
                              ),
                            ),
                            const SizedBox(height: 3),
                            state.selectedUser!.followers != null &&
                                    state.selectedUser!.followers!.isNotEmpty
                                ? Text(
                                    "Followers: ${state.selectedUser!.followers!.length}",
                                    style: const TextStyle(fontSize: 16),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 3),
                    ElevatedButton(
                      onPressed: () {
                        context.read<profile.ProfileBloc>().add(
                              profile.NavigateToUpload(
                                context: context,
                                destination: const UploadPage(),
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
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
                      labelColor: Colors.grey,
                      unselectedLabelColor: Color(0xFF62625F),
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
                          if (state.isLoading && _loadingStartTime != null) {
                            final elapsed = DateTime.now()
                                .difference(_loadingStartTime!)
                                .inSeconds;
                            if (elapsed > 10) {
                              // Show fallback after 10 seconds
                              return const FallbackWidget();
                            }
                            return const LoadingWidget(); // Use custom LoadingWidget
                          } else if (state.errorMessage.isNotEmpty) {
                            return const FallbackWidget();
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

  Widget _buildEditProfileButton() {
    return IconButton(
      icon: const Icon(Icons.edit, size: 28),
      onPressed: _updateProfile,
    );
  }

  void _updateProfile() {
    final profileState = context.read<profile.ProfileBloc>().state;
    if (profileState.selectedUser == null) return;

    final artworkCrudBloc = getIt<ArtworkCrudBloc>();

    context.read<profile.ProfileBloc>().add(
          profile.NavigateToEdit(
            context: context,
            destination: EditProfileForm(
              userId: profileState.selectedUser!.userId ?? '',
              fullName: profileState.selectedUser!.full_name,
              email: profileState.selectedUser!.email ?? '',
              contactNo: profileState.selectedUser!.contact_no ?? '',
              profilePic: profileState.selectedUser!.profilepic,
              artworkCrudBloc: artworkCrudBloc,
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
          isSavedTab: false,
        );
      },
    );
  }

  /// Builds the "Saved" tab
  Widget _buildSavedArtworks(profile.ProfileState state) {
    if (state.collection.isEmpty) {
      return const Center(
        child: Text(
          "No saved artworks yet!",
          style: TextStyle(fontSize: 16, color: Colors.grey),
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
      itemCount: state.collection.length,
      itemBuilder: (context, index) {
        final savedArtwork = state.collection[index];
        return _buildArtworkCard(
          savedArtwork.art_id,
          savedArtwork.imageUrl,
          savedArtwork.title ?? '',
          'Unknown',
          isSavedTab: true,
          isLiked: true,
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
          context.read<profile.ProfileBloc>().add(
                profile.NavigateToDetailView(
                  context: context,
                  destination: DetailView(
                    artworkId: artworkId,
                    buyerId: userId ?? '',
                    isLiked: isLiked,
                    showAppBar: true,
                  ),
                ),
              );
        } else {
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
                      fontSize: 12,
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
