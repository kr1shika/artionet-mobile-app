// class HomeState extends Equatable {
//   final int selectedIndex;
//   final List<Widget> views;

//   const HomeState({
//     required this.selectedIndex,
//     required this.views,
//   });

//   // Initial state
//   static HomeState initial() {
//     return const HomeState(
//       selectedIndex: 0,
//       views: [
//         Center(
//           child: Text('Dashboard'),
//         ),
//         Center(
//           child: Text('Account'),
//         ),
//       ],
//     );
//   }

//   HomeState copyWith({
//     int? selectedIndex,
//     List<Widget>? views,
//   }) {
//     return HomeState(
//       selectedIndex: selectedIndex ?? this.selectedIndex,
//       views: views ?? this.views,
//     );
//   }

//   @override
//   List<Object?> get props => [selectedIndex, views];
// }

/// State Class for HomeView
class HomeState {
  final int selectedIndex;

  const HomeState({required this.selectedIndex});

  // Initial state
  factory HomeState.initial() {
    return const HomeState(selectedIndex: 0);
  }

  // Copy with method to create a new instance with updated data
  HomeState copyWith({int? selectedIndex}) {
    return HomeState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
