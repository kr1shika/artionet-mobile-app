import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/app/di/di.dart';
import 'package:tryproject/app/shared_prefs/token_shared_prefs.dart';
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
  String? userId;

  Future<void> _loadUserId() async {
    final tokenSharedPrefs =
        getIt<TokenSharedPrefs>(); // ✅ Get instance from DI
    String? storedUserId = tokenSharedPrefs.getUserId(); // ✅ Retrieve userId
    setState(() {
      userId = storedUserId;
    });
    print(" CUstomer view page User ID: $userId"); // ✅ Debugging
  }

  @override
  void initState() {
    super.initState();
    _loadUserId();
    context.read<PurchaseBloc>().add(FetchArtworkById(id: widget.artworkId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 43,
          fit: BoxFit.contain,
        ),
      ),
      body: BlocConsumer<PurchaseBloc, PurchaseState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Purchase Successful!')),
            );
          } else if (!state.isSuccess &&
              !state.isLoading &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Summary",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (state.artworkImages != null &&
                            state.artworkImages!.isNotEmpty)
                          Image.network(
                            state.artworkImages!.first,
                            height: 270,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (state.artworkTitle != null)
                                Text(
                                  state.artworkTitle!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              const SizedBox(height: 8),
                              const Text(
                                "Artist Name",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              if (state.artworkPrice != null)
                                Column(
                                  children: [
                                    Text(
                                        "Price: \$${state.artworkPrice!.toStringAsFixed(2)}"),
                                    const SizedBox(height: 4),
                                    Text(
                                        "Service Fee (4%): \$${(state.artworkPrice! * 0.04).toStringAsFixed(2)}"),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Total: \$${(state.artworkPrice! * 1.04).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Note: The artist’s team will contact you as soon as possible for payment",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: addressController,
                          decoration:
                              const InputDecoration(labelText: 'Address'),
                          validator: (value) =>
                              value!.isEmpty ? 'Enter address' : null,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: state.isLoading
                                ? null
                                : () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<PurchaseBloc>().add(
                                            CreatePurchaseEvent(
                                              art_id: widget.artworkId,
                                              buyer_id:
                                                  userId ?? "User ID not found",
                                              address: addressController.text,
                                              status: 'Order Confirmed',
                                              context: context,
                                              purchaseId: "",
                                            ),
                                          );
                                    }
                                  },
                            child: state.isLoading
                                ? const CircularProgressIndicator()
                                : const Text('Confirm Purchase'),
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
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}
