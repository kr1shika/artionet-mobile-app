import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/common/snackbar/my_snackbar.dart';
import 'package:tryproject/features/artwork/presentation/view/search_view.dart';
import 'package:tryproject/features/home/presentation/view/buyer/pages/customerProfileView.dart';
import 'package:tryproject/features/home/presentation/view/buyer/pages/dashboard_view.dart';
import 'package:tryproject/features/home/presentation/view/buyer/pages/notification_view.dart';
import 'package:tryproject/features/home/presentation/view_model/home_cubit.dart';
import 'package:tryproject/features/home/presentation/view_model/home_state.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final homeCubit = context.read<HomeCubit>();

          final List<Widget> pages = [
            const HomeScreen(),
            SearchView(),
            const Customerprofileview(),
            const NotificationsView(),
          ];

          return Scaffold(
            backgroundColor: const Color(0xFFFFFFF7),
            appBar: AppBar(
              backgroundColor: const Color(0xFFFFFFF7),
              centerTitle: true,
              title: Image.asset(
                'assets/images/logo.png',
                height: 43,
                fit: BoxFit.contain,
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.logout_outlined),
                  onPressed: () {
                    showMySnackBar(
                      context: context,
                      message: 'Logging out...',
                      color: Colors.red,
                    );
                    context.read<HomeCubit>().logout(context);
                  },
                ),
              ],
            ),
            body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              return state.views.elementAt(state.selectedIndex);
            }),
            // bottomNavigationBar: BottomNavigationBar(
            //   type: BottomNavigationBarType.fixed,
            //   backgroundColor: const Color.fromARGB(255, 27, 29, 30),
            //   currentIndex: state.selectedIndex,
            //   onTap: (index) => homeCubit.onTabTapped(index),
            //   items: const [
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.home),
            //       label: 'Home',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.search),
            //       label: 'Search',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.person),
            //       label: 'Profile',
            //     ),
            //     BottomNavigationBarItem(
            //       icon: Icon(Icons.notifications),
            //       label: 'Notifications',
            //     ),
            //   ],
            //   selectedItemColor: const Color.fromARGB(255, 133, 139, 144),
            //   unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
            // ),

            bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications),
                      label: 'Notifications',
                    ),
                  ],
                  currentIndex: state.selectedIndex,
                  selectedItemColor: const Color.fromARGB(255, 133, 139, 144),
                  unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
                  onTap: (index) {
                    context.read<HomeCubit>().onTabTapped(index);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
