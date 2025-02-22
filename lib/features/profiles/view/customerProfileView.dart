import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/profiles/view_model/profile_bloc.dart';

class CustomerProfileView extends StatefulWidget {
  final String userId;

  const CustomerProfileView({super.key, required this.userId});

  @override
  CustomerProfileViewState createState() => CustomerProfileViewState();
}

class CustomerProfileViewState extends State<CustomerProfileView> {
  @override
  void initState() {
    super.initState();
    // Dispatch the event to fetch purchases when the widget is loaded
    context
        .read<ProfileBloc>()
        .add(FetchPurchasesByUserId(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: SafeArea(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.errorMessage.isNotEmpty) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (state.purchases.isEmpty) {
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
            } else {
              return ListView.builder(
                itemCount: state.purchases.length,
                itemBuilder: (context, index) {
                  final purchase = state.purchases[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(purchase.status ?? 'Unknown Art'),
                      subtitle: Text('Status: ${purchase.status}'),
                      trailing: Text('\$${purchase.totalAmount}'),
                      onTap: () {
                        // Navigate to purchase details if needed
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
