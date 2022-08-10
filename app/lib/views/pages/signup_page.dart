import 'package:flutter/material.dart';
import 'package:app/modules/module_list.dart';
import 'package:app/widgets/widget_list.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    Key? key,
    required this.onPageChange,
  }) : super(key: key);

  final VoidCallback onPageChange;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _usernameTxtCtrl = TextEditingController();
  final _emailTxtCtrl = TextEditingController();
  final _passwordTxtCtrl = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _usernameTxtCtrl.dispose();
    _emailTxtCtrl.dispose();
    _passwordTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
      ? Center(child: CircularProgressIndicator())
      : SafeArea(
        minimum: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
        
              SignUpForm(
                signUpFormKey: _signUpFormKey,
                usernameTxtCtrl: _usernameTxtCtrl,
                emailTxtCtrl: _emailTxtCtrl,
                passwordTxtCtrl: _passwordTxtCtrl,
              ),
        
              // signup button
              SizedBox(height: 16),
              AuthButton(
                signInMode: false,
                onTap: () {
                  if (_signUpFormKey.currentState!.validate()) {
                    setState( () {
                      _isLoading = true;
                    });
                    signUp(
                      context,
                      _emailTxtCtrl.text.trim(),
                      _passwordTxtCtrl.text.trim()
                    );
                    setState( () {
                      _isLoading = false;
                    });
                  }
                },
              ),
        
              // to signin page
              SizedBox(height: 16),
              ToOtherPage(
                signInMode: false,
                onTap: widget.onPageChange,
              ),
        
            ],
          ),
        ),
      );
  }
}
