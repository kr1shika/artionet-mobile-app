import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/purchases/presentation/view_model/purchase_bloc.dart';

// Fallback Widget
class FallbackWidget extends StatelessWidget {
  const FallbackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/server_down.png',
            height: 110,
            width: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16),
          const Text(
            'Go create art instead.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontFamily: 'IM_FELL_Great_Primer',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Loading Widget
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final purchaseBloc = context.read<PurchaseBloc>();
      purchaseBloc.add(FetchPurchasesByUserId(userId: widget.userId));
      purchaseBloc.add(FetchArtistSales(artistId: widget.artistId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PurchaseBloc>.value(
      value: context.read<PurchaseBloc>(),
      child: Scaffold(
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
                      // Show loading widget when data is being fetched
                      if (state.isLoading &&
                          (state.purchases == null ||
                              state.artistSales == null)) {
                        return const LoadingWidget();
                      }

                      // Show fallback widget when no data is available
                      if ((state.purchases == null ||
                              state.purchases!.isEmpty) &&
                          (state.artistSales == null ||
                              state.artistSales!.isEmpty)) {
                        return const FallbackWidget();
                      }

                      return TabBarView(
                        children: [
                          SingleChildScrollView(
                              child: _buildPurchasesTab(state)),
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
      ),
    );
  }

  Widget _buildPurchasesTab(PurchaseState state) {
    final activePurchases =
        state.purchases?.where((p) => p.status != 'Completed').toList() ?? [];
    final historyPurchases =
        state.purchases?.where((p) => p.status == 'Completed').toList() ?? [];

    if (activePurchases.isEmpty && historyPurchases.isEmpty) {
      return const FallbackWidget();
    }

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

    if (activeSales.isEmpty && historySales.isEmpty) {
      return const FallbackWidget();
    }

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
          padding: const EdgeInsets.only(left: 22.0, top: 8.0, bottom: 8.0),
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

            return LayoutBuilder(
              builder: (context, constraints) {
                final isTablet = constraints.maxWidth > 600;

                return Card(
                  margin: EdgeInsets.only(
                    left: isTablet ? 70 : 20,
                    right: isTablet ? 70 : 20,
                    top: isTablet ? 0 : 0,
                    bottom: isTablet ? 30 : 20,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(isTablet ? 0 : 0),
                    child: isTablet
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: item.imageUrl != null
                                    ? Image.network(
                                        item.imageUrl!,
                                        height: isTablet ? 200 : 150,
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
                              SizedBox(width: isTablet ? 30 : 10),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title ?? 'Unknown Art',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text('Status: ${item.status}'),
                                    const SizedBox(height: 8),
                                    if (isSales && item.status != 'Completed')
                                      ElevatedButton(
                                        onPressed: () {
                                          if (item.purchaseId != null) {
                                            _showStatusUpdateDialog(
                                                context, item.purchaseId!);
                                          }
                                        },
                                        child: const Text('Update Status'),
                                      )
                                    else
                                      Text(
                                        '\$${item.totalAmount}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              item.imageUrl != null
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
                              ListTile(
                                title: Text(item.title ?? 'Unknown Art'),
                                subtitle: Text('Status: ${item.status}'),
                                trailing: isSales && item.status != 'Completed'
                                    ? ElevatedButton(
                                        onPressed: () {
                                          if (item.purchaseId != null) {
                                            _showStatusUpdateDialog(
                                                context, item.purchaseId!);
                                          }
                                        },
                                        child: const Text('Update Status'),
                                      )
                                    : Text(
                                        '\$${item.totalAmount}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                              ),
                            ],
                          ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _showStatusUpdateDialog(BuildContext context, String purchaseId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Update Order Status"),
          content: const Text("Select the new status for this order."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (String status in [
                  "Order Confirmed",
                  "Order Processing",
                  "Shipped",
                  "Completed",
                  "Cancelled",
                  "Refunded"
                ])
                  ListTile(
                    title: Text(status),
                    onTap: () {
                      context.read<PurchaseBloc>().add(
                            UpdatePurchaseStatusEvent(
                              purchaseId: purchaseId,
                              status: status,
                            ),
                          );
                      Navigator.pop(dialogContext);
                    },
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
