import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SecuritySection extends StatefulWidget {
  final bool isInfoAccurateAccepted;
  final bool isDataPolicyAccepted;
  final VoidCallback onInfoAccurateChanged;
  final VoidCallback onDataPolicyChanged;
  final bool isCaptchaVerified;
  final ValueChanged<bool> onCaptchaVerifiedChanged;
  final String? captchaError;

  const SecuritySection({
    Key? key,
    required this.isInfoAccurateAccepted,
    required this.isDataPolicyAccepted,
    required this.onInfoAccurateChanged,
    required this.onDataPolicyChanged,
    required this.isCaptchaVerified,
    required this.onCaptchaVerifiedChanged,
    this.captchaError,
  }) : super(key: key);

  @override
  State<SecuritySection> createState() => _SecuritySectionState();
}

class _SecuritySectionState extends State<SecuritySection> {
  final TextEditingController _captchaAnswerController =
      TextEditingController();
  late int _numberA;
  late int _numberB;
  String? _captchaLocalError;

  @override
  void initState() {
    super.initState();
    _numberA = Random().nextInt(9) + 1; // 1-9
    _numberB = Random().nextInt(9) + 1; // 1-9
    // Defer notifying the parent until after the current build/layout
    // pass finishes, since calling setState() on an ancestor while this
    // widget is still being built/mounted throws a FlutterError.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onCaptchaVerifiedChanged(false);
      }
    });
  }

  @override
  void dispose() {
    _captchaAnswerController.dispose();
    super.dispose();
  }

  void _generateCaptcha() {
    setState(() {
      _numberA = Random().nextInt(9) + 1; // 1-9
      _numberB = Random().nextInt(9) + 1; // 1-9
      _captchaAnswerController.clear();
      _captchaLocalError = null;
    });
    widget.onCaptchaVerifiedChanged(false);
  }

  void _checkCaptcha() {
    final answer = int.tryParse(_captchaAnswerController.text.trim());
    final expected = _numberA + _numberB;
    bool verified = false;

    setState(() {
      if (_captchaAnswerController.text.trim().isEmpty) {
        _captchaLocalError = 'Veuillez répondre à la question';
        verified = false;
      } else if (answer != expected) {
        _captchaLocalError = 'Réponse incorrecte, réessayez';
        verified = false;
      } else {
        _captchaLocalError = null;
        verified = true;
      }
    });

    widget.onCaptchaVerifiedChanged(verified);
  }

  Widget _buildCheckboxItem({
    required bool value,
    required VoidCallback onChanged,
    required String label,
  }) {
    return InkWell(
      onTap: onChanged,
      borderRadius: BorderRadius.circular(8.0),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: value,
              onChanged: (_) => onChanged(),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 1.5.h),
                child: Text(
                  label,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conditions générales',
          style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 3.h),

        // Checkbox 1: Accuracy certification
        _buildCheckboxItem(
          value: widget.isInfoAccurateAccepted,
          onChanged: widget.onInfoAccurateChanged,
          label: 'Je certifie l\'exactitude des informations fournies *',
        ),

        // Checkbox 2: Data processing consent
        _buildCheckboxItem(
          value: widget.isDataPolicyAccepted,
          onChanged: widget.onDataPolicyChanged,
          label:
              'J\'accepte le traitement de mes données selon la loi 18-07 *',
        ),

        SizedBox(height: 3.h),

        // Security verification section
        Text(
          'Vérification de sécurité',
          style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 2.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: widget.isCaptchaVerified
                  ? AppTheme.lightTheme.colorScheme.primary
                  : AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomIconWidget(
                    iconName: 'security',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Veuillez résoudre ce calcul pour continuer',
                    style:
                        AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary
                          .withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      '$_numberA + $_numberB = ?',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: TextFormField(
                      controller: _captchaAnswerController,
                      keyboardType: TextInputType.number,
                      enabled: !widget.isCaptchaVerified,
                      decoration: InputDecoration(
                        hintText: 'Réponse',
                        errorText: _captchaLocalError ?? widget.captchaError,
                        suffixIcon: widget.isCaptchaVerified
                            ? CustomIconWidget(
                                iconName: 'check_circle',
                                color: AppTheme.lightTheme.colorScheme.primary,
                                size: 20,
                              )
                            : null,
                      ),
                      onChanged: (_) {
                        if (widget.isCaptchaVerified) {
                          widget.onCaptchaVerifiedChanged(false);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 2.w),
                  IconButton(
                    onPressed: _generateCaptcha,
                    icon: CustomIconWidget(
                      iconName: 'refresh',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                    tooltip: 'Nouveau calcul',
                  ),
                ],
              ),
              if (!widget.isCaptchaVerified) ...[
                SizedBox(height: 1.5.h),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _checkCaptcha,
                    child: Text('Vérifier'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}