import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';

class PurchaseView extends StatefulWidget {
  final String artworkId;

  const PurchaseView({super.key, required this.artworkId});

  @override
  _PurchaseViewState createState() => _PurchaseViewState();
}

class _PurchaseViewState extends State<PurchaseView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String? purchaseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase Artwork')),
      body: BlocConsumer<PurchaseBloc, PurchaseState>(
        listener: (context, state) {
          if (state.isSuccess && state.purchaseId != null) {
            setState(() {
              purchaseId =
                  state.purchaseId; // Store purchaseId for OTP verification
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP sent to your email')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter address' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<PurchaseBloc>().add(
                              CreatePurchaseEvent(
                                art_id: widget.artworkId,
                                buyer_id: "buyer_123",
                                address: addressController.text,
                                context: context,
                                status: '',
                              ),
                            );
                      }
                    },
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Confirm Purchase'),
                  ),
                  const SizedBox(height: 20),
                  if (purchaseId != null) ...[
                    TextFormField(
                      controller: otpController,
                      decoration: const InputDecoration(labelText: 'Enter OTP'),
                      validator: (value) => value!.isEmpty ? 'Enter OTP' : null,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (otpController.text.isNotEmpty) {
                          context.read<PurchaseBloc>().add(
                                VerifyPurchaseEvent(
                                  otp: otpController.text,
                                  art_id: widget.artworkId,
                                  buyer_id: "buyer_123",
                                  address: addressController.text,
                                ),
                              );
                        }
                      },
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Verify OTP'),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
