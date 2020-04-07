import 'package:flash_chat/components/logo.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/components/text_button.dart';
import 'package:flash_chat/core/auth/auth_bloc.dart';
import 'package:flash_chat/core/navigator/navigator_bloc.dart';
import 'package:flash_chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/register_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;
  NavigatorBloc _navigatorBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _navigatorBloc = BlocProvider.of<NavigatorBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
                      'Registering...',
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
          BlocProvider.of<NavigatorBloc>(context).add(NavigatorPop());
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: kLogoTag,
                    child: Container(
                      height: 200.0,
                      child: Logo(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: kTextFormFieldDecoration.copyWith(
                    icon: Icon(
                      Icons.email,
                    ),
                    labelText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isEmailValid ? 'Invalid Email' : null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: kTextFormFieldDecoration.copyWith(
                    icon: Icon(
                      Icons.lock,
                    ),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autovalidate: true,
                  autocorrect: false,
                  validator: (_) {
                    return !state.isPasswordValid ? 'Invalid Password' : null;
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                RoundedButton(
                  label: 'Register',
                  color: Theme.of(context).primaryColor,
                  onTap:
                      isRegisterButtonEnabled(state) ? _onFormSubmitted : null,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  'Already have an account?',
                  textAlign: TextAlign.center,
                  style: kPromptStyle,
                ),
                TextButton(
                  label: 'Log In',
                  color: Theme.of(context).primaryColor,
                  onTap: () {
                    _navigatorBloc.add(NavigateToLogin());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }
}
