import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_cinema/features/mobile_staff/index/bloc/index_bloc.dart';
import 'package:royal_cinema/features/mobile_staff/index/bloc/index_event.dart';
import 'package:royal_cinema/features/mobile_staff/index/bloc/index_state.dart';
import 'package:royal_cinema/features/mobile_staff/index/data_provider/local_user_data_provider.dart';
import 'package:royal_cinema/features/mobile_staff/index/repository/index_repository.dart';
import 'package:royal_cinema/features/mobile_staff/login/bloc/auth_bloc.dart';
import 'package:royal_cinema/features/mobile_staff/login/data_provider/login_data_provider.dart';
import 'package:royal_cinema/features/mobile_staff/login/repository/login_repository.dart';
import 'package:royal_cinema/features/mobile_staff/login/ui/login_page.dart';
import 'package:royal_cinema/core/staff_core/colors.dart';
import 'package:royal_cinema/features/mobile_staff/staff_app.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  @override
  Widget build(BuildContext context) {
    final IndexBloc indexBloc = IndexBloc(IndexRepository(IndexDataProvider()));
    final AuthBloc authBloc = AuthBloc(LoginRepository(LoginDataProvider()));
    return BlocProvider(
      create: (_) => indexBloc..add(CheckLogin()),
      child: BlocBuilder<IndexBloc, IndexState>(
        builder: (_, IndexState state) {
          print(state);
          if (state is Checking) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NotLoggedIn) {
            return LoginTest();
            // LoginPage(authBloc: authBloc);
            // FlatButton(
            //   color: Col.background,
            //     onPressed: () {
            //       context.pushNamed('login');
            //     },
            //     child: Container(
            //       color: Col.background,
            //       child: Center(

            //         child: Column(

            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text("You're Not LoggedIn"),
            //             SizedBox(height: 10,),
            //             Text("Login")
            //           ],
            //         ),
            //       ),
            //     )
            //     );
          }
          if (state is LoggedIn) {
            return StaffApp();
            // FlatButton(
            //     color: Col.background,
            //     onPressed: () {
            //       context.pushNamed('home');
            //     },
            //     child: Center(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text("You're LoggedIn"),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           Text("Goto Home Screen")
            //         ],
            //       ),
            //     ));
          }
          if (state is CheckFailed) {
            return Center(child: Text("Error Loading Login Data"));
          }
          return Center(child: Text("Loading Failed Restart The App"));
        },
      ),
    );
  }
}
