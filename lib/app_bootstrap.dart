// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'core/token_store.dart';
// import 'core/api_client.dart';
// import 'services/auth_service.dart';
// import 'state/user_session.dart';

// class AppBootstrap extends StatelessWidget {
//   final Widget child;
//   const AppBootstrap({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final tokenStore = TokenStore();
//     final api = ApiClient(
//       tokenStore,
//       onUnauthorized: () async {
//         // Global 401 handler – log the user out.
//         await tokenStore.clear();
//       },
//     );

//     return MultiProvider(
//       providers: [
//         Provider<TokenStore>.value(value: tokenStore),
//         Provider<ApiClient>.value(value: api),
//         Provider<AuthService>(create: (_) => AuthService(api)),
//         ChangeNotifierProvider<UserSession>(
//           create: (_) => UserSession(tokenStore, api)..restore(),
//         ),
//       ],
//       child: child,
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/token_store.dart';
import 'core/api_client.dart';
import 'services/auth_service.dart';
import 'state/user_session.dart';

class AppBootstrap extends StatelessWidget {
  final Widget child;
  const AppBootstrap({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final tokenStore = TokenStore();
    final api = ApiClient(
      tokenStore,
      onUnauthorized: () async {
        await tokenStore.clear();
      },
    );

    return MultiProvider(
      providers: [
        Provider<ApiClient>.value(value: api),
        Provider<AuthService>(create: (_) => AuthService(api)),
        ChangeNotifierProvider<UserSession>(
          create: (_) => UserSession(tokenStore, api)..restore(),
        ),
      ],
      child: child,
    );
  }
}
