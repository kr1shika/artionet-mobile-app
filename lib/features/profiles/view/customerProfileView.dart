import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/features/artwork/presentation/view/upload_artwork_view.dart';
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
    context
        .read<ProfileBloc>()
        .add(FetchPurchasesByUserId(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                ClipOval(
                  child: Image.asset(
                    'assets/images/krishika.jpg',
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "@kr1shika",
                  style: TextStyle(
                    fontFamily: 'IM_FELL_Great_Primer',
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 3),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProfileBloc>().add(NavigateToUpload(
                          context: context,
                          destination: const UploadPage(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 1,
                    ),
                    backgroundColor: const Color.fromARGB(73, 27, 29, 30),
                    foregroundColor: const Color(0xFFFFFFF7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Upload',
                    style: TextStyle(
                      fontFamily: 'IM_FELL_Great_Primer',
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const TabBar(
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black,
                  tabs: [
                    Tab(text: "Your Orders"),
                    Tab(text: "Saved"),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1.1,
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
                        return TabBarView(
                          children: [
                            ListView.builder(
                              itemCount: state.purchases.length,
                              itemBuilder: (context, index) {
                                final purchase = state.purchases[index];
                                return Card(
                                  margin: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4),
                                          topRight: Radius.circular(4),
                                        ),
                                        child: purchase.imageUrl != null
                                            ? Image.network(
                                                purchase.imageUrl!,
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
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              purchase.title ?? 'Unknown Art',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Status: ${purchase.status}',
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Price: \$${purchase.totalAmount}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const Center(
                              child: Text(
                                "No saved posts yet!",
                                style: TextStyle(
                                  fontFamily: 'IM_FELL_Great_Primer',
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
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
}