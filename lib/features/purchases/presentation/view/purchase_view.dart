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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchase Artwork')),
      body: BlocConsumer<PurchaseBloc, PurchaseState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Purchase Successful!')),
            );
          } else if (!state.isSuccess && !state.isLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Purchase Failed. Please try again.')),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(labelText: 'Address'),
                    validator: (value) =>
                        value!.isEmpty ? 'Enter address' : null,
                  ),
                  const SizedBox(height: 20),

                  // Confirm Purchase Button
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<PurchaseBloc>().add(
                                    CreatePurchaseEvent(
                                      art_id: widget.artworkId,
                                      buyer_id: "679cb11ed81a6e1b96420af0",
                                      address: addressController.text,
                                      status: 'Order Confirmed',
                                      context: context,
                                      purchaseId:
                                          "", // No need for purchaseId now
                                    ),
                                  );
                            }
                          },
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Confirm Purchase'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}
