import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFF7),
            body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              return state.views.elementAt(state.selectedIndex);
            }),
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
                    BottomNavigationBarItem(
                      icon: Icon(Icons.shop_two_outlined),
                      label: 'orders',
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
