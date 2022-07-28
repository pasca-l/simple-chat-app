import 'package:flutter/material.dart';
import 'package:app/views/view_list.dart';
import 'package:app/widgets/widget_list.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool _login = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(),
      body: _login
        ? SignInPage(
          onPageChange: () {
            setState( () {
              _login = !_login;
            });
          },
        )
        : SignUpPage(
          onPageChange: () {
            setState( () {
              _login = !_login;
            });
          },
        ),
    );
  }
}
