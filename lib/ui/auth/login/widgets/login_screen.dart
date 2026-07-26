import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:aepyornis_app/routing/routes.dart';
import 'package:aepyornis_app/ui/auth/login/view_models/login_viewmodel.dart';
import 'package:aepyornis_app/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _urlController = TextEditingController(text: '');
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  final TextEditingController _apiKeyController =
      TextEditingController(text: '');

  AuthMode _authMode = AuthMode.emailPassword;
  bool _obscurePassword = true;
  bool _isSubmitting = false;

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
    _urlController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _apiKeyController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final data = LoginData(
      url: _urlController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      apiKey: _apiKeyController.text.trim(),
      authMode: _authMode,
    );

    widget.viewModel.loginApi.execute(data);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Brand / Logo
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/icon/app_icon.png',
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Aepyornis',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Auth Mode Selector
                    SegmentedButton<AuthMode>(
                      segments: [
                        ButtonSegment<AuthMode>(
                          value: AuthMode.emailPassword,
                          label: Text(l10n.loginWithEmail),
                          icon: const Icon(Icons.email_outlined),
                        ),
                        ButtonSegment<AuthMode>(
                          value: AuthMode.apiKey,
                          label: Text(l10n.loginWithApiKey),
                          icon: const Icon(Icons.key_outlined),
                        ),
                      ],
                      selected: {_authMode},
                      onSelectionChanged: (Set<AuthMode> selection) {
                        setState(() {
                          _authMode = selection.first;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    // Server URL Field
                    TextFormField(
                      controller: _urlController,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.dns_outlined),
                        labelText: l10n.url,
                        hintText: 'https://example.com',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter server URL';
                        }
                        final uri = Uri.tryParse(value.trim());
                        if (uri == null || !uri.hasScheme) {
                          return 'Please enter a valid URL (e.g. https://example.com)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Dynamic Auth Fields
                    if (_authMode == AuthMode.emailPassword) ...[
                      TextFormField(
                        controller: _emailController,
                        enableSuggestions: true,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.person_outline),
                          labelText: l10n.email,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          labelText: l10n.password,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ] else ...[
                      TextFormField(
                        controller: _apiKeyController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.vpn_key_outlined),
                          labelText: l10n.apiKey,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your API Key';
                          }
                          return null;
                        },
                      ),
                    ],
                    const SizedBox(height: 24),

                    // Submit Button
                    FilledButton(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _isSubmitting ? null : _submit,
                      child: _isSubmitting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              l10n.login,
                              style: const TextStyle(fontSize: 16),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onResult() {
    final commandValue = widget.viewModel.loginApi.value;
    if (commandValue != null) {
      if (commandValue.isSuccess()) {
        setState(() {
          _isSubmitting = false;
        });
        widget.viewModel.loginApi.clearErrors();
        context.go(Routes.home);
      } else if (commandValue.isError()) {
        setState(() {
          _isSubmitting = false;
        });
        final error = commandValue.exceptionOrNull();
        final errorMessage = error != null
            ? error.toString().replaceAll('Exception: ', '')
            : AppLocalizations.of(context)!.loginError;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
