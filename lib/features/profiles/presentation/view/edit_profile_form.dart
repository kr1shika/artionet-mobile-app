import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tryproject/features/profiles/presentation/view_model/profile_bloc.dart';

class EditProfileForm extends StatefulWidget {
  final String userId;
  final String fullName;
  final String email;
  final String contactNo;
  final String? profilePic;

  const EditProfileForm({
    super.key,
    required this.userId,
    required this.fullName,
    required this.email,
    required this.contactNo,
    this.profilePic,
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
      context
          .read<ProfileBloc>()
          .add(UploadProfileImage(file: _selectedImage!));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final profileState = context.read<ProfileBloc>().state;
      context.read<ProfileBloc>().add(
            UpdateUserProfile(
              userId: widget.userId,
              fullName: _fullNameController.text,
              email: _emailController.text,
              contactNo: _contactNoController.text,
              profilePic: profileState.uploadedImageName ?? widget.profilePic,
              context: context,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully!')),
          );
          Navigator.pop(context); // Close the dialog after successful update
        } else if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text("Update Profile"),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : (widget.profilePic != null &&
                                      widget.profilePic!.isNotEmpty
                                  ? NetworkImage(widget.profilePic!)
                                  : const AssetImage(
                                      'assets/images/default.jpg'))
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _fullNameController,
                    decoration: const InputDecoration(labelText: "Full Name"),
                    validator: (value) =>
                        value!.isEmpty ? "Name cannot be empty" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter a valid email" : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _contactNoController,
                    decoration: const InputDecoration(labelText: "Contact No"),
                    validator: (value) =>
                        value!.isEmpty ? "Enter a valid contact number" : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text("Save Changes"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
