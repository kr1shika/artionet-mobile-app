import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';

class MyPurchasesView extends StatelessWidget {
  const MyPurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseBloc, PurchaseState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.purchaseId == null) {
          return const Center(
            child: Text(
              "No orders made yet!",
              style: TextStyle(
                fontFamily: 'IM_FELL_Great_Primer',
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: 1, // Assuming one purchase for now
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                title: Text("Order ID: ${state.purchaseId}"),
                subtitle: const Text("Status: Order Confirmed"),
                trailing: const Icon(Icons.check_circle, color: Colors.green),
              ),
            );
          },
        );
      },
    );
  }
}
