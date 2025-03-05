import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tryproject/features/profiles/presentation/view_model/upload_edit/crud_bloc.dart';
import 'package:tryproject/main.dart';

class EditProfileForm extends StatefulWidget {
  final String userId;
  final String fullName;
  final String email;
  final String contactNo;
  final String? profilePic;
  final ArtworkCrudBloc artworkCrudBloc;

  const EditProfileForm({
    super.key,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.contactNo,
    this.profilePic,
    required this.artworkCrudBloc,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _contactNoController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName);
    _emailController = TextEditingController(text: widget.email);
    _contactNoController = TextEditingController(text: widget.contactNo);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _contactNoController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Upload the image using the UploadProfileImage event
      context.read<ArtworkCrudBloc>().add(
            UploadProfileImage(file: _selectedImage!),
          );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Get the uploaded image name from the state
      final state = context.read<ArtworkCrudBloc>().state;
      final imageName = state.uploadedImageName;

      // Trigger the UpdateUserProfile event
      context.read<ArtworkCrudBloc>().add(
            UpdateUserProfile(
              userId: widget.userId,
              fullName: _fullNameController.text,
              email: _emailController.text,
              contactNo: _contactNoController.text,
              profilePic: imageName ?? widget.profilePic,
              context: context,
            ),
          );

      // Show a success snackbar
      showMySnackBar(
        context: context,
        message: "Profile updated successfully!",
        color: Colors.green,
      );

      // Navigate back after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
    } else {
      // Show an error snackbar if validation fails
      showMySnackBar(
        context: context,
        message: "Please fill in all fields correctly.",
        color: Colors.red,
      );
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(
              color: Colors.red, // Red border for the dialog
              width: 1,
            ),
          ),
          title: const Text(
            "Confirm Deletion",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Are you sure you want to delete your account? This action is permanent and you will lose all your data.",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                // Dispatch the DeleteUserById event
                widget.artworkCrudBloc.add(
                    DeleteUserById(userId: widget.userId, context: context));

                // Show confirmation snackbar
                showMySnackBar(
                  context: context,
                  message: "Account deleted successfully!",
                  color: Colors.red,
                );

                // Exit the app
                Future.delayed(const Duration(seconds: 2), () {
                  RestartWidget.restartApp(context);
                });
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 63,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 4),
              const Text(
                "Update Profile",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: _selectedImage != null
                      ? FileImage(_selectedImage!)
                      : (widget.profilePic != null &&
                                  widget.profilePic!.isNotEmpty
                              ? NetworkImage(widget.profilePic!)
                              : const AssetImage('assets/images/default.jpg'))
                          as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (value) =>
                    value!.isEmpty ? "Name cannot be empty" : null,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Enter a valid email" : null,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _contactNoController,
                decoration: const InputDecoration(labelText: "Contact No"),
                validator: (value) =>
                    value!.isEmpty ? "Enter a valid contact number" : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text("Save Changes"),
              ),
              const SizedBox(height: 20),
              // Delete Account Button
              SizedBox(
                width: 150, // Smaller button width
                child: ElevatedButton(
                  onPressed: _showDeleteConfirmationDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red, // Red background for the button
                    foregroundColor: Colors.white, // White text color
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    "Delete Account",
                    style: TextStyle(
                      fontSize: 14, // Smaller font size
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showMySnackBar({
  required BuildContext context,
  required String message,
  Color? color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.green,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
