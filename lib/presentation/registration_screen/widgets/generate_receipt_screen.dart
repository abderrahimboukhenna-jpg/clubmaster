import 'package:clubmaster/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';


/// Arguments passed in from SuccessRegistrationScreen via GoRouter `extra`.
class GenerateReceiptArgs {
  const GenerateReceiptArgs({this.prefillNin, this.dossierNumber});
  final String? prefillNin;
  final String? dossierNumber;
}

class GenerateReceiptScreen extends StatefulWidget {
  const GenerateReceiptScreen({Key? key, this.args}) : super(key: key);

  final GenerateReceiptArgs? args;

  @override
  State<GenerateReceiptScreen> createState() => _GenerateReceiptScreenState();
}

class _GenerateReceiptScreenState extends State<GenerateReceiptScreen> {
  final TextEditingController _ninController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  String? _ninError;
  String? _firstNameError;
  String? _lastNameError;
  String? _captchaError;
  bool _isCaptchaVerified = false;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    if (widget.args?.prefillNin != null) {
      _ninController.text = widget.args!.prefillNin!;
    }
  }

  @override
  void dispose() {
    _ninController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _validateNin() {
    setState(() {
      final value = _ninController.text.trim();
      if (value.isEmpty) {
        _ninError = 'Le NIN ou le NIN du parent est requis';
      } else if (!RegExp(r'^\d{18}$').hasMatch(value)) {
        _ninError = 'Doit contenir 18 chiffres';
      } else {
        _ninError = null;
      }
    });
  }

  void _validateFirstName() {
    setState(() {
      if (_firstNameController.text.trim().isEmpty) {
        _firstNameError = 'Le prénom est requis';
      } else {
        _firstNameError = null;
      }
    });
  }

  void _validateLastName() {
    setState(() {
      if (_lastNameController.text.trim().isEmpty) {
        _lastNameError = 'Le nom est requis';
      } else {
        _lastNameError = null;
      }
    });
  }

  bool get _isFormValid =>
      _ninError == null &&
      _firstNameError == null &&
      _lastNameError == null &&
      _ninController.text.trim().isNotEmpty &&
      _firstNameController.text.trim().isNotEmpty &&
      _lastNameController.text.trim().isNotEmpty &&
      _isCaptchaVerified;

  Future<void> _generateReceipt() async {
    _validateNin();
    _validateFirstName();
    _validateLastName();
    setState(() {
      _captchaError = _isCaptchaVerified ? null : 'Veuillez valider le reCAPTCHA';
    });
    if (!_isFormValid) return;

    setState(() => _isGenerating = true);
    HapticFeedback.lightImpact();

    try {
      // TODO: replace with real PDF receipt generation/download call.
      await Future.delayed(const Duration(seconds: 2));

      Fluttertoast.showToast(
        msg: "Reçu généré avec succès",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erreur lors de la génération du reçu",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        textColor: Colors.white,
      );
    } finally {
      if (mounted) setState(() => _isGenerating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.lightTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: theme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        title: Text(
          'Générer le reçu',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Renseignez vos informations pour générer votre reçu d\'inscription.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 3.h),

              TextFormField(
                controller: _ninController,
                keyboardType: TextInputType.number,
                maxLength: 18,
                decoration: InputDecoration(
                  labelText: 'NIN Ou Parent Nin',
                  errorText: _ninError,
                  counterText: '',
                ),
                onChanged: (_) => _validateNin(),
              ),
              SizedBox(height: 2.h),

              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'Prénom (Latin)',
                  errorText: _firstNameError,
                ),
                onChanged: (_) => _validateFirstName(),
              ),
              SizedBox(height: 2.h),

              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Nom (Latin)',
                  errorText: _lastNameError,
                ),
                onChanged: (_) => _validateLastName(),
              ),
              SizedBox(height: 3.h),

              _ReceiptCaptchaField(
                isVerified: _isCaptchaVerified,
                errorText: _captchaError,
                onChanged: (verified) {
                  setState(() {
                    _isCaptchaVerified = verified;
                    if (verified) _captchaError = null;
                  });
                },
              ),
              SizedBox(height: 4.h),

              SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  onPressed: _isGenerating ? null : _generateReceipt,
                  child: _isGenerating
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              theme.colorScheme.onPrimary,
                            ),
                          ),
                        )
                      : Text(
                          'Générer le reçu',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}

/// Lightweight "I'm not a robot" style reCAPTCHA placeholder, mirroring the
/// boolean verified/onChanged pattern already used by SecuritySection's
/// captcha in the registration flow. Swap the inner check for an actual
/// Google reCAPTCHA (e.g. via a WebView challenge) when the backend
/// integration is wired up.
class _ReceiptCaptchaField extends StatelessWidget {
  const _ReceiptCaptchaField({
    required this.isVerified,
    required this.onChanged,
    this.errorText,
  });

  final bool isVerified;
  final ValueChanged<bool> onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.lightTheme;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => onChanged(!isVerified),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hasError
                    ? theme.colorScheme.error
                    : theme.colorScheme.outline.withOpacity(0.4),
              ),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: isVerified,
                  onChanged: (value) => onChanged(value ?? false),
                  activeColor: theme.colorScheme.primary,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    'Je ne suis pas un robot',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                CustomIconWidget(
                  iconName: 'shield',
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 28,
                ),
              ],
            ),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: 0.5.h),
          Text(
            errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }
}