import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/providers/auth.dart';

enum AuthMode { SignUp, Login }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final _passWordController = TextEditingController();

  AnimationController _controller;
  Animation<Size> _highAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    _highAnimation = Tween(
      begin: Size(double.infinity, 290),
      end: Size(double.infinity, 371),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _highAnimation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final Map<String, String> _authData = {'email': "", "passoword": ""};

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Error"),
              content: Text(msg),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok"),
                )
              ],
            ));
  }

  Future<void> _subbmit() async {
    if (!_form.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    _form.currentState.save();
    Auth auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        await auth.login(_authData['email'], _authData['password']);
      } else {
        await auth.signup(_authData['email'], _authData['password']);
      }
    } on AuthException catch (e) {
      _showErrorDialog(e.toString());
    } catch (e) {
      _showErrorDialog("Error\n$e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 8.0,
      child: Container(
        width: _deviceSize.width * 0.75,
        height: _highAnimation.value.height,
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Inform a valid email";
                  }
                  return null;
                },
                onSaved: (value) => _authData['email'] = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                controller: _passWordController,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return "Inform a valid email";
                  }
                  return null;
                },
                onSaved: (value) => _authData['password'] = value,
              ),
              if (_authMode == AuthMode.SignUp)
                TextFormField(
                  decoration: InputDecoration(labelText: "Confirm Password"),
                  obscureText: true,
                  validator: _authMode == AuthMode.SignUp
                      ? (value) {
                          if (value != _passWordController.text) {
                            return "Passords not Match";
                          }
                          return null;
                        }
                      : null,
                  onSaved: (value) => _authData['password'] = value,
                ),
              Spacer(),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : RaisedButton(
                      child: Text(
                          _authMode == AuthMode.Login ? "LOGIN" : "REGISTER"),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor:
                          Theme.of(context).primaryTextTheme.button.color,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                      onPressed: _subbmit,
                    ),
              FlatButton(
                onPressed: _switchMode,
                child: Text(_authMode == AuthMode.Login ? "Register" : "Login"),
                textColor: Theme.of(context).textTheme.headline6.color,
              )
            ],
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}