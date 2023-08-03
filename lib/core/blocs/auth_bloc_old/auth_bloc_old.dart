// //

// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../../core/helpers/safe.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthStatus> {
//   final Safe safe;
//   AuthBloc({required this.safe}) : super(const AuthStatus.empty()) {
//     checkAuthStatus: (e) => _onCheckAuthStatus(e, emit),
//           authorized: (e) => _onAuthorized(e, emit),
//   }
//   _onAuthorized(_Authorized event, Emitter<AuthStatus> emit) {
//     safe.setToken('Ok');
//     emit(const AuthStatus.home());
//   }

//   _onCheckAuthStatus(_CheckAuthStatus event, Emitter<AuthStatus> emit) {
//     final option = safe.getAuthStatus();
//     switch (option) {
//       case AuthOption.home:
//         emit(const AuthStatus.home());
//         break;
//       case AuthOption.none:
//       case AuthOption.login:
//         emit(const AuthStatus.login());
//         break;
//     }
//   }
// }
