import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tryproject/features/profiles/presentation/view_model/upload_edit/crud_bloc.dart';

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
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<ArtworkCrudBloc>().add(
            UpdateUserProfile(
              userId: widget.userId,
              fullName: _fullNameController.text,
              email: _emailController.text,
              contactNo: _contactNoController.text,
              profilePic: widget.profilePic,
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
                  // fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
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
