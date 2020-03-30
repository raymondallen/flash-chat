import 'package:flash_chat/bloc/auth/auth_bloc.dart';
import 'package:flash_chat/bloc/login/bloc/login_bloc.dart';
import 'package:flash_chat/components/logo.dart';
import 'package:flash_chat/data/user_repository.dart';
import 'package:flash_chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import '../utilities/routes.dart';
import '../components/text_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String email = '';
  String password = '';

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated => email != '' && password != '';
  //    _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return true;
    //return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    //_emailController.addListener(_onEmailChanged);
    //_passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                  style: kErrorStyle,
                ),
                backgroundColor: kPrimaryColor,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Logging In...',
                      style: kPromptStyle,
                    ),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ],
                ),
                backgroundColor: kPrimaryColor,
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: kLogoTag,
                    child: Container(
                      height: 200.0,
                      child: Logo(),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email',
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password',
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  RoundedButton(
                    label: 'Log In',
                    color: Theme.of(context).primaryColor,
                    onTap:
                        isLoginButtonEnabled(state) ? _onFormSubmitted : null,
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  Text(
                    'Don\'t have an account yet?',
                    textAlign: TextAlign.center,
                    style: kPromptStyle,
                  ),
                  TextButton(
                    label: 'Register',
                    color: Theme.of(context).primaryColor,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onFormSubmitted() {
    print('SUBMITTED');
    _loginBloc.add(
      LoginWithCredentialsPressed(
        //email: _emailController.text,
        //password: _passwordController.text,
        email: email,
        password: password,
      ),
    );
  }
}
