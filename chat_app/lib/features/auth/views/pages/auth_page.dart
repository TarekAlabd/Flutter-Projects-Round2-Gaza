import 'package:chat_app/core/route/app_routes.dart';
import 'package:chat_app/core/utils/enums.dart';
import 'package:chat_app/features/auth/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController, _passwordController;
  late FocusNode _emailFocusNode, _passwordFocusNode;
  bool visibility = false;
  var authType = AuthType.login;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginOrRegister(VoidCallback func) {
    if (_formKey.currentState!.validate()) {
      func();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Text(
                    authType == AuthType.login
                        ? 'Login Account!'
                        : 'Register Account!',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    authType == AuthType.login
                        ? 'Please, login with registered account!'
                        : 'Please, register with your email!',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () {
                      _emailFocusNode.unfocus();
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                      prefixIconColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !visibility,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      _passwordFocusNode.unfocus();
                      loginOrRegister(
                        () => authType == AuthType.login
                            ? cubit.login(
                                _emailController.text,
                                _passwordController.text,
                              )
                            : cubit.register(
                                _emailController.text,
                                _passwordController.text,
                              ),
                      );
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      prefixIcon: const Icon(Icons.password),
                      prefixIconColor: Colors.grey,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        child: Icon(visibility
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      suffixIconColor: Colors.grey,
                    ),
                  ),
                  if (authType == AuthType.login) ...[
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: BlocConsumer<AuthCubit, AuthState>(
                      bloc: cubit,
                      listenWhen: (previous, current) =>
                          current is AuthSuccess || current is AuthError,
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(authType == AuthType.login
                                  ? 'Login Success!'
                                  : 'Register Success!'),
                            ),
                          );
                          Navigator.of(context).pushNamed(AppRoutes.chat);
                        } else if (state is AuthError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is AuthLoading ||
                          current is AuthError ||
                          current is AuthSuccess,
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () => loginOrRegister(
                            () => authType == AuthType.login
                                ? cubit.login(
                                    _emailController.text,
                                    _passwordController.text,
                                  )
                                : cubit.register(
                                    _emailController.text,
                                    _passwordController.text,
                                  ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(
                            authType == AuthType.login ? 'Login' : 'Register',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or using other methods:',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        authType == AuthType.login
                            ? 'Don\'t have an account?'
                            : 'Already have an account?',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.grey,
                                ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (authType == AuthType.login) {
                              authType = AuthType.register;
                            } else {
                              authType = AuthType.login;
                            }
                            _emailController.clear();
                            _passwordController.clear();
                          });
                        },
                        child: Text(
                          authType == AuthType.login ? 'Register' : 'Login',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
