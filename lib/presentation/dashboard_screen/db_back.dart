import 'package:flutter/material.dart';
import 'package:movieflix/presentation/dashboard_screen/bloc/dashboard_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieflix/routes/app_routes.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardBloc dashboardBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
    dashboardBloc = DashboardBloc();
    //dashboardBloc.add(DashboardInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      bloc: dashboardBloc,
      listenWhen: (previous, current) => current is DashboardActionState,
      buildWhen: (previous, current) => current is! DashboardActionState,
      listener: (context, state) {
        if (state is DashboardSearchButtonNavigateState) {
          Navigator.pushNamed(context, AppRoutes.movieInfo);
        }
        //else if (state is DashboardError) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(state.message),
        //     ),
        //   );
        // }
      },
      builder: (context, state) {
        print(state.runtimeType.toString());
        switch (state.runtimeType) {
          // case DashboardLoading:
          //   return Container(
          //     color: Colors.red,
          //   );
          // case DashboardSuccess:
          //   return Scaffold(
          //     appBar: AppBar(
          //       title: const Text('MovieFlix'),
          //       actions: [
          //         IconButton(
          //           icon: const Icon(
          //             Icons.search,
          //           ),
          //           onPressed: () {
          //             dashboardBloc.add(DashboardSearchButtonNavigateEvent());
          //           },
          //         )
          //       ],
          //     ),
          //   );

          default:
            return Container(
              color: Colors.green,
            );
        }
      },
    );
  }
}
