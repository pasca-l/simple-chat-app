import 'package:flutter/material.dart';
import 'package:app/modules/module_list.dart';
import 'package:app/widgets/widget_list.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    Key? key,
    required this.onPageChange,
  }) : super(key: key);

  final VoidCallback onPageChange;

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _signInFormKey = GlobalKey<FormState>();
  final _emailTxtCtrl = TextEditingController();
  final _passwordTxtCtrl = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
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
        
              SignInForm(
                signInFormKey: _signInFormKey,
                emailTxtCtrl: _emailTxtCtrl,
                passwordTxtCtrl: _passwordTxtCtrl,
              ),
        
              // signin button
              SizedBox(height: 16),
              AuthButton(
                signInMode: true,
                onTap: () {
                  if (_signInFormKey.currentState!.validate()) {
                    setState( () {
                      _isLoading = true;
                    });
                    signIn(
                      context,
                      _emailTxtCtrl.text.trim(),
                      _passwordTxtCtrl.text.trim(),
                    );
                    setState( () {
                      _isLoading = false;
                    });
                  }
                }
              ),
        
              // to signup page
              SizedBox(height: 16),
              ToOtherPage(
                signInMode: true,
                onTap: widget.onPageChange,
              ),
        
              // reset password field
              SizedBox(height: 16),
              ResetPassFormField(
                emailTxtCtrl: _emailTxtCtrl,
              ),
        
            ],
          ),
        ),
      );
  }
}


class ResetPassFormField extends StatefulWidget {
  const ResetPassFormField({
    Key? key,
    required this.emailTxtCtrl,
  }) : super(key: key);

  final TextEditingController emailTxtCtrl;

  @override
  State<ResetPassFormField> createState() => _ResetPassFormFieldState();
}

class _ResetPassFormFieldState extends State<ResetPassFormField> {
  final _resetPassFormKey = GlobalKey<FormState>();

  bool _resetPassField = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // change visibility of form field
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                setState( () {
                  _resetPassField = !_resetPassField;
                });
              },
              child: Text(
                !_resetPassField ? "Forgot password?" : "Close form",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),

        // reset password field
        SizedBox(height: 32),
        Visibility(
          visible: _resetPassField,
          child: Column(
            children: [

              Text("Send reset password link to:"),

              ResetPasswordForm(
                resetPassFormKey: _resetPassFormKey,
                emailTxtCtrl: widget.emailTxtCtrl,
              ),

              ElevatedButton(
                onPressed: () {
                  if (_resetPassFormKey.currentState!.validate()) {
                    sendResetEmail(
                      context,
                      widget.emailTxtCtrl.text.trim(),
                    );
                  }
                },
                child: Text("send"),
              ),

            ],
          ),
        ),
      ],
    );
  }
}