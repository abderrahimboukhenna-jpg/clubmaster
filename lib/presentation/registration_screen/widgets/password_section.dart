import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PasswordSection extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? passwordError;
  final String? confirmPasswordError;
  final VoidCallback onPasswordChanged;
  final VoidCallback onConfirmPasswordChanged;

  const PasswordSection({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    this.passwordError,
    this.confirmPasswordError,
    required this.onPasswordChanged,
    required this.onConfirmPasswordChanged,
  });

  @override
  State<PasswordSection> createState() => _PasswordSectionState();
}

class _PasswordSectionState extends State<PasswordSection> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  String _getPasswordStrength(String password) {
    if (password.isEmpty) return '';
    if (password.length < 6) return 'Faible';
    if (password.length < 8) return 'Moyen';
    if (password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]'))) {
      return 'Fort';
    }
    return 'Moyen';
  }

  Color _getPasswordStrengthColor(String strength) {
    switch (strength) {
      case 'Faible':
        return AppTheme.lightTheme.colorScheme.error;
      case 'Moyen':
        return Colors.orange;
      case 'Fort':
        return AppTheme.lightTheme.colorScheme.primary;
      default:
        return AppTheme.lightTheme.colorScheme.onSurfaceVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final passwordStrength =
        _getPasswordStrength(widget.passwordController.text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sécurité du compte',
          style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 3.h),

        // Password Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mot de passe *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            TextFormField(
              controller: widget.passwordController,
              obscureText: !_isPasswordVisible,
              onChanged: (_) {
                widget.onPasswordChanged();
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: 'Créez un mot de passe sécurisé',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'lock',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: CustomIconWidget(
                    iconName:
                        _isPasswordVisible ? 'visibility_off' : 'visibility',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                errorText: widget.passwordError,
              ),
            ),
            if (passwordStrength.isNotEmpty) ...[
              SizedBox(height: 1.h),
              Row(
                children: [
                  Text(
                    'Force du mot de passe: ',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                  Text(
                    passwordStrength,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: _getPasswordStrengthColor(passwordStrength),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
        SizedBox(height: 2.5.h),

        // Confirm Password Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirmer le mot de passe *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            TextFormField(
              controller: widget.confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              onChanged: (_) => widget.onConfirmPasswordChanged(),
              decoration: InputDecoration(
                hintText: 'Confirmez votre mot de passe',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'lock_outline',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: CustomIconWidget(
                    iconName: _isConfirmPasswordVisible
                        ? 'visibility_off'
                        : 'visibility',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                errorText: widget.confirmPasswordError,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
