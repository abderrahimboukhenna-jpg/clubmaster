import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/app_routes.dart';
import '../../theme/app_theme.dart';
import './widgets/login_form_widget.dart';
import './widgets/login_header_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _formController;
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _titleOpacity;
  late Animation<Offset> _formSlide;
  late Animation<double> _formOpacity;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _formController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _headerController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _headerController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _headerController,
            curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
          ),
        );
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _headerController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );
    _formSlide = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _formController, curve: Curves.easeOutCubic),
        );
    _formOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _formController, curve: Curves.easeOut));

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _formController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _formController.dispose();
    super.dispose();
  }

  void _handleLogin(String email, String password) async {
    // TODO: Replace with [Riverpod/Bloc] for production — auth service call
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRoutes.homeDashboardScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height - MediaQuery.of(context).padding.top,
            ),
            child: isTablet
                ? _buildTabletLayout(theme, size)
                : _buildPhoneLayout(theme, size),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneLayout(ThemeData theme, Size size) {
    return Column(
      children: [
        LoginHeaderWidget(
          logoScale: _logoScale,
          logoOpacity: _logoOpacity,
          titleSlide: _titleSlide,
          titleOpacity: _titleOpacity,
          height: size.height * 0.38,
        ),
        FadeTransition(
          opacity: _formOpacity,
          child: SlideTransition(
            position: _formSlide,
            child: Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withAlpha(20),
                    blurRadius: 32,
                    offset: const Offset(0, -8),
                  ),
                ],
              ),
              child: LoginFormWidget(
                isLoading: _isLoading,
                onLogin: _handleLogin,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(ThemeData theme, Size size) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: SizedBox(
          width: 480,
          child: Column(
            children: [
              LoginHeaderWidget(
                logoScale: _logoScale,
                logoOpacity: _logoOpacity,
                titleSlide: _titleSlide,
                titleOpacity: _titleOpacity,
                height: 260,
              ),
              const SizedBox(height: 24),
              FadeTransition(
                opacity: _formOpacity,
                child: SlideTransition(
                  position: _formSlide,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primary.withAlpha(26),
                          blurRadius: 32,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: LoginFormWidget(
                      isLoading: _isLoading,
                      onLogin: _handleLogin,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
