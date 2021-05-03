import 'package:flutter/material.dart';

import 'blocs/credentials_provider.dart';
import 'blocs/shares_provider.dart';

import 'screens/login_screen.dart';
import 'screens/dashboard.dart';
import 'screens/register_screen.dart';
import 'screens/live_shares.dart';
import 'screens/portfolio_screen.dart';

class App extends StatelessWidget {
  Widget build(context) {
    // final _bloc = SharesProvider.of(context);
    // _bloc.fetchShare();
    return CredentialsProvider(
        child: SharesProvider(
      child: MaterialApp(
        initialRoute: '/login',
        onGenerateRoute: routes,
        title: 'Stock App',
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    ));
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        {
          return MaterialPageRoute(builder: (context) {
            final _bloc = SharesProvider.of(context);
            _bloc.fetchShare();
            return LoginScreen();
          });
        }
      case '/login':
        {
          return MaterialPageRoute(builder: (context) {
            return LoginScreen();
          });
        }
      case '/register':
        {
          return MaterialPageRoute(builder: (context) {
            return RegisterScreen();
          });
        }
      case '/dashboard':
        {
          return MaterialPageRoute(builder: (context) {
            return Dashboard();
          });
        }
      case '/liveShares':
        {
          return MaterialPageRoute(builder: (context) {
            return LiveShares();
          });
        }
      case '/portfolio':
        {
          return MaterialPageRoute(builder: (context) {
            return Portfolio();
          });
        }
    }
    return MaterialPageRoute(builder: (context) {
      return LoginScreen();
    });
  }
}
