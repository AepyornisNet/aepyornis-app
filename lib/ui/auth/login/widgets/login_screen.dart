import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:workout_tracker_app/routing/routes.dart';
import 'package:workout_tracker_app/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:workout_tracker_app/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _url = TextEditingController(
    text: '',
  );

  final TextEditingController _apiKey = TextEditingController(
    text: '',
  );

  @override
  void initState() {
    super.initState();
    widget.viewModel.loginApi.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant LoginScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.loginApi.removeListener(_onResult);
    widget.viewModel.loginApi.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.loginApi.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _url,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.url,
                      hintText: 'https://example.com',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _apiKey,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.apiKey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => {
                      widget.viewModel.loginApi.execute(
                          LoginData(url: _url.text, apiKey: _apiKey.text))
                    },
                    child: Text(AppLocalizations.of(context)!.login),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onResult() {
    if (widget.viewModel.loginApi.value != null &&
        widget.viewModel.loginApi.value!.isSuccess()) {
      widget.viewModel.loginApi.clearErrors();
      context.go(Routes.home);
    }

    if (widget.viewModel.loginApi.value != null &&
        widget.viewModel.loginApi.value!.isError()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.loginError),
        ),
      );
    }
  }
}
