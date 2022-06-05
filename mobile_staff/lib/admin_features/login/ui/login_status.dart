// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:sec_2/admin_features/login/bloc/auth_state.dart';
// import 'package:sec_2/admin_features/login/ui/login_page.dart';
// import 'package:sec_2/staff_app.dart';

// class LoginStatusPage extends StatelessWidget {
//   const LoginStatusPage({Key? key, required this.context, required this.state})
//       : super(key: key);

//   final BuildContext context;
//   final AuthState state;
//   @override
//   Widget build(BuildContext context) {
//     print(state);
//     if (state is LoginSuccessful) {
//       return StaffApp();
//     }
//     if (state is LoginFailed) {
//       return LoginPage();
//     }
//     return LoginPage();
//   }
// }
