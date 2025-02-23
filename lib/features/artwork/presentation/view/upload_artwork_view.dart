import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tryproject/features/profiles/view_model/upload_edit/artwork_crud_bloc.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _titleController = TextEditingController();
  final _dimensionsController = TextEditingController();
  final _priceController = TextEditingController();
  final _mediumUsedController = TextEditingController();
  final _categoriesController = TextEditingController();
  final _creatorsNoteController = TextEditingController();

  File? _image;
  String? _uploadedImageName;

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

  void _submitArtwork() {
    if (_titleController.text.isEmpty || _uploadedImageName == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please provide a title and upload an image.')),
      );
      return;
    }

    context.read<ArtworkCrudBloc>().add(
          CreateArtworkEvent(
            context: context,
            title: _titleController.text,
            dimensions: _dimensionsController.text,
            price: _priceController.text,
            mediumUsed: _mediumUsedController.text,
            artistId: 'artist_id_placeholder',
            categories: _categoriesController.text,
            creatorsNote: _creatorsNoteController.text,
            images: _image!,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Artwork')),
      body: BlocListener<ArtworkCrudBloc, ArtworkCrudState>(
        listener: (context, state) {
          if (state.isSuccess && state.imageName != null) {
            setState(() {
              _uploadedImageName = state.imageName;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : const AssetImage('assets/images/placeholder.png')
                          as ImageProvider,
                ),
              ),
              TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title')),
              TextField(
                  controller: _dimensionsController,
                  decoration: const InputDecoration(labelText: 'Dimensions')),
              TextField(
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: 'Price')),
              TextField(
                  controller: _mediumUsedController,
                  decoration: const InputDecoration(labelText: 'Medium Used')),
              TextField(
                  controller: _categoriesController,
                  decoration: const InputDecoration(labelText: 'Categories')),
              TextField(
                  controller: _creatorsNoteController,
                  decoration:
                      const InputDecoration(labelText: 'Creators Note')),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitArtwork,
                child: const Text('Submit Artwork'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
