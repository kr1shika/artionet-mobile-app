import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/app/shared_prefs/token_shared_prefs.dart';
import 'package:tryproject/features/profiles/presentation/view_model/upload_edit/crud_bloc.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _artkey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _dimensionsController = TextEditingController();
  final _priceController = TextEditingController();
  final _mediumUsedController = TextEditingController();
  final _categoriesController = TextEditingController();
  final _creatorsNoteController = TextEditingController();

  File? _image;
  String? _uploadedImageName;

  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final tokenSharedPrefs = getIt<TokenSharedPrefs>();
    String? storedUserId = tokenSharedPrefs.getUserId();
    setState(() {
      userId = storedUserId;
    });
    print("Fetched User ID: $userId");
  }

  Future<void> _checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _browseImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        context.read<ArtworkCrudBloc>().add(LoadImage(file: _image!));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Upload Artwork')), // Centered title
        backgroundColor: Colors.white, // AppBar background color
        elevation: 0, // Remove shadow
        iconTheme:
            const IconThemeData(color: Colors.black), // Back button color
      ),
      body: BlocListener<ArtworkCrudBloc, ArtworkCrudState>(
        listener: (context, state) {
          if (state.isSuccess && state.imageName != null) {
            setState(() {
              _uploadedImageName = state.imageName;
            });
          }
        },
        child: SingleChildScrollView(
          // Make the page scrollable
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _artkey,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera),
                            title: const Text('Camera'),
                            onTap: () {
                              _checkCameraPermission();
                              _browseImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.image),
                            title: const Text('Gallery'),
                            onTap: () {
                              _browseImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    width: 250,
                    height: 270,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200], // Light grey background
                    ),
                    child: _image == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload,
                                  size: 50, color: Colors.grey), // Upload icon
                              SizedBox(height: 10),
                              Text(
                                'Upload an image here',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        : Image.file(_image!,
                            fit: BoxFit.cover), // Display uploaded image
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(), // Add border
                  ),
                  autofocus: true, // Focus on input when clicked
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dimensionsController,
                  decoration: const InputDecoration(
                    labelText: 'Dimensions',
                    border: OutlineInputBorder(), // Add border
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(), // Add border
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _mediumUsedController,
                  decoration: const InputDecoration(
                    labelText: 'Medium Used',
                    border: OutlineInputBorder(), // Add border
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _categoriesController,
                  decoration: const InputDecoration(
                    labelText: 'Categories',
                    border: OutlineInputBorder(), // Add border
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _creatorsNoteController,
                  decoration: const InputDecoration(
                    labelText: 'Creators Note',
                    border: OutlineInputBorder(), // Add border
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_artkey.currentState!.validate()) {
                      final artworkState =
                          context.read<ArtworkCrudBloc>().state;
                      final imageName = artworkState.imageName;
                      context.read<ArtworkCrudBloc>().add(
                            CreateArtworkEvent(
                              context: context,
                              title: _titleController.text,
                              dimensions: _dimensionsController.text,
                              price: _priceController.text,
                              mediumUsed: _mediumUsedController.text,
                              artistId: userId,
                              categories: 'Painting',
                              creatorsNote: _creatorsNoteController.text,
                              images: imageName,
                            ),
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 42,
                      vertical: 16, // Increased vertical padding
                    ),
                    backgroundColor: Colors.black, // Button background color
                    foregroundColor: Colors.white, // Button text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Upload Artwork',
                    style: TextStyle(
                        fontFamily: 'IM_FELL_Great_Primer', fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
