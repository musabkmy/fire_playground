// // In your state management class (e.g., Cubit/ChangeNotifier)
// import 'package:flutter/material.dart';

// import 'base_class.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class DataProvider {
//   Future<void> fetchData() async {
//     _state = ApiState.loading();
//     try {
//       final data = await repository.getData();
//       _state = ApiState.success(data);
//     } catch (e) {
//       _state = ApiState.error(e.toString());
//     }
//   }
// }

// // In UI (using Riverpod example)
// class DataWidget extends ConsumerWidget {
//   const DataWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final dataProvider = DataProvider();
//     final state = ref.watch(dataProvider);

//     return state.when(
//       initial: () => Text('Pull to refresh'),
//       loading: () => CircularProgressIndicator(),
//       success: (data) => ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (context, i) => ListTile(title: Text(data[i])),
//       ),
//       error: (message) => Text('Error: $message'),
//     );
//   }
// }
