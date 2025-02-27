import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';

class PurchasesOrdersView extends StatefulWidget {
  final String userId;
  final String artistId;

  const PurchasesOrdersView({
    super.key,
    required this.userId,
    required this.artistId,
  });

  @override
  PurchasesOrdersViewState createState() => PurchasesOrdersViewState();
}

class PurchasesOrdersViewState extends State<PurchasesOrdersView> {
  @override
  void initState() {
    super.initState();
    final purchaseBloc = context.read<PurchaseBloc>();
    purchaseBloc.add(FetchPurchasesByUserId(userId: widget.userId));
    purchaseBloc.add(FetchArtistSales(artistId: widget.artistId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const SizedBox(height: 4),
              const TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.black,
                tabs: [
                  Tab(text: "Your Orders"),
                  Tab(text: "Your Sales"),
                ],
              ),
              Expanded(
                child: BlocBuilder<PurchaseBloc, PurchaseState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return TabBarView(
                      children: [
                        SingleChildScrollView(child: _buildPurchasesTab(state)),
                        SingleChildScrollView(child: _buildSalesTab(state)),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPurchasesTab(PurchaseState state) {
    final activePurchases =
        state.purchases?.where((p) => p.status != 'Completed').toList() ?? [];
    final historyPurchases =
        state.purchases?.where((p) => p.status == 'Completed').toList() ?? [];

    return Column(
      children: [
        _buildSectionedList("Active", activePurchases, false),
        _buildSectionedList("History", historyPurchases, false),
      ],
    );
  }

  Widget _buildSalesTab(PurchaseState state) {
    final activeSales =
        state.artistSales?.where((s) => s.status != 'Completed').toList() ?? [];
    final historySales =
        state.artistSales?.where((s) => s.status == 'Completed').toList() ?? [];

    return Column(
      children: [
        _buildSectionedList("Active", activeSales, true),
        _buildSectionedList("History", historySales, true),
      ],
    );
  }

  Widget _buildSectionedList(String title, List<dynamic> items, bool isSales) {
    if (items.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    child: item.imageUrl != null
                        ? Image.network(
                            item.imageUrl!,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  ListTile(
                    title: Text(item.title ?? 'Unknown Art'),
                    subtitle: Text('Status: ${item.status}'),
                    trailing: isSales && item.status != 'Completed'
                        ? ElevatedButton(
                            onPressed: () {
                              // Implement update status event here
                            },
                            child: const Text('Update Status'),
                          )
                        : Text('\$${item.totalAmount}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
