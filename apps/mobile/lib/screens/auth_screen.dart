import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aevum_native/services/auth_service.dart';

const bool googleSignInEnabled = bool.fromEnvironment(
  'AEVUM_ENABLE_GOOGLE_SIGN_IN',
  defaultValue: false,
);
const bool appleSignInEnabled = bool.fromEnvironment(
  'AEVUM_ENABLE_APPLE_SIGN_IN',
  defaultValue: false,
);

class AuthScreen extends StatefulWidget {
  final AuthClient? authClient;

  const AuthScreen({super.key, this.authClient});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final AuthClient _auth;

  @override
  void initState() {
    super.initState();
    _auth = widget.authClient ?? AuthService();
  }
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  bool _showEmail = false;
  bool _createAccount = false;
  String? _error;
  String? _message;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _authError(Object error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return 'Enter a valid email address.';
        case 'weak-password':
          return 'Use a stronger password with at least 8 characters.';
        case 'email-already-in-use':
          return 'An account already exists for this email.';
        case 'invalid-credential':
        case 'user-not-found':
        case 'wrong-password':
          return 'The email or password is incorrect.';
        case 'operation-not-allowed':
          return 'This sign-in method is not enabled yet.';
        case 'network-request-failed':
          return 'Check your connection and try again.';
        case 'too-many-requests':
          return 'Too many attempts. Try again later.';
      }
      return error.message ?? 'Authentication failed.';
    }
    return 'Authentication failed. Please try again.';
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
      _message = null;
    });

    try {
      await action();
    } catch (error) {
      if (!mounted) return;
      setState(() => _error = _authError(error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _submitEmail() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.length < 8) {
      setState(() => _error = 'Enter an email and a password of at least 8 characters.');
      return;
    }

    await _run(() async {
      if (_createAccount) {
        await _auth.createAccountWithEmail(email, password);
      } else {
        await _auth.signInWithEmail(email, password);
      }
    });
  }

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => _error = 'Enter your email first.');
      return;
    }

    await _run(() async {
      await _auth.sendPasswordReset(email);
      if (mounted) {
        setState(() => _message = 'Password reset instructions were sent if the account exists.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Welcome to Aevum',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sign in to your family archive.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 36),
                  if (_error != null) ...[
                    _notice(_error!, Colors.redAccent),
                    const SizedBox(height: 16),
                  ],
                  if (_message != null) ...[
                    _notice(_message!, Colors.greenAccent),
                    const SizedBox(height: 16),
                  ],
                  if (!_showEmail) ...[
                    _socialButton(
                      icon: Icons.g_mobiledata,
                      label: googleSignInEnabled
                          ? 'Continue with Google'
                          : 'Google sign-in is not configured',
                      onTap: googleSignInEnabled
                          ? () => _run(() async {
                              await _auth.signInWithGoogle();
                            })
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _socialButton(
                      icon: Icons.apple,
                      label: appleSignInEnabled
                          ? 'Continue with Apple'
                          : 'Apple sign-in is not configured',
                      onTap: appleSignInEnabled
                          ? () => _run(() async {
                              await _auth.signInWithApple();
                            })
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _socialButton(
                      icon: Icons.email_outlined,
                      label: 'Continue with Email',
                      onTap: () => setState(() => _showEmail = true),
                    ),
                  ] else ...[
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      style: const TextStyle(color: Colors.white),
                      decoration: _fieldDecoration('Email'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      autofillHints: const [AutofillHints.password],
                      style: const TextStyle(color: Colors.white),
                      decoration: _fieldDecoration('Password'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _loading ? null : _submitEmail,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        _loading
                            ? 'Please wait...'
                            : _createAccount
                                ? 'Create Account'
                                : 'Sign In',
                      ),
                    ),
                    TextButton(
                      onPressed: _loading
                          ? null
                          : () => setState(() => _createAccount = !_createAccount),
                      child: Text(
                        _createAccount
                            ? 'Already have an account? Sign in'
                            : 'Need an account? Create one',
                      ),
                    ),
                    if (!_createAccount)
                      TextButton(
                        onPressed: _loading ? null : _resetPassword,
                        child: const Text('Forgot password?'),
                      ),
                    TextButton(
                      onPressed: _loading ? null : () => setState(() => _showEmail = false),
                      child: const Text('Back to all sign-in options'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.06),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _notice(String text, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: color)),
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
  }) {
    return ElevatedButton(
      onPressed: _loading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
