import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../routes/app_routes.dart';
import './widgets/contact_location_section.dart';
import './widgets/establishment_section.dart';
import './widgets/password_section.dart';
import './widgets/registration_progress_indicator.dart';
import './widgets/security_section.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  int _currentStep = 0;
  final int _totalSteps = 4;
  bool _isLoading = false;

  // Form Controllers
  final TextEditingController _firstNameArController = TextEditingController();
  final TextEditingController _lastNameArController = TextEditingController();
  final TextEditingController _establishmentController = TextEditingController();
  final TextEditingController _firstNameFrController = TextEditingController();
  final TextEditingController _lastNameFrController = TextEditingController();
  final TextEditingController _ninController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Validation States
  String? _establishmentError;
  String? _firstNameArError;
  String? _lastNameArError;
  String? _firstNameFrError;
  String? _lastNameFrError;
  String? _ninError;
  String? _emailError;
  String? _confirmEmailError;
  String? _phoneError;
  String? _genderError;
  String? _photoError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _selectedEstablishment;
  String? _selectedGender;
  bool _acceptInformation = false;
  bool _acceptLaw = false;
  bool _isCaptchaVerified = false;
  String? _captchaError;
  XFile? _identityPhoto;

  // Mock user data for auto-save functionality
  final Map<String, dynamic> _savedUserData = {
    "establishment": "OPOW Béjaïa",
    "firstNameAr": "محمد",
    "lastNameAr": "بن علي",
    "firstNameFr": "Mohamed",
    "lastNameFr": "Benali",
    "nin": "1234567890123456789",
    "email": "mohamed.benali@example.com",
    "confirmEmail": "mohamed.benali@example.com",
    "phone": "6 12 34 56 78",
    "gender": "male",
  };

  final List<String> _establishments = [

 'OPOW Béjaïa',

 'OPOW Blida',

 'OPOW Alger',

 'OPOW Oran',

 'OPOW Constantine',

];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    // Auto-restore saved data for demo purposes
    _restoreSavedData();
  }

  @override
  void dispose() {
    _establishmentController.dispose();
    _firstNameArController.dispose();
    _lastNameArController.dispose();
    _firstNameFrController.dispose();
    _lastNameFrController.dispose();
    _ninController.dispose();
    _emailController.dispose();
    _confirmEmailController.dispose();
    _phoneController.dispose();
    _animationController.dispose();
    _pageController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _restoreSavedData() {
    // Simulate auto-restore functionality
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _establishmentController.text = _savedUserData["establishment"] ?? "";
          _selectedEstablishment = _savedUserData["establishment"];
          _firstNameArController.text = _savedUserData["firstNameAr"] ?? "";
          _lastNameArController.text = _savedUserData["lastNameAr"] ?? "";
          _firstNameFrController.text = _savedUserData["firstNameFr"] ?? "";
          _lastNameFrController.text = _savedUserData["lastNameFr"] ?? "";
          _ninController.text = _savedUserData["nin"] ?? "";
          _emailController.text = _savedUserData["email"] ?? "";
          _confirmEmailController.text = _savedUserData["confirmEmail"] ?? "";
          _phoneController.text = _savedUserData["phone"] ?? "";
          _selectedGender = _savedUserData["gender"];
        });
      }
    });
  }

  // Validation Methods
  void _validateEstablishment() {
    setState(() {
      if (_selectedEstablishment == null) {
        _establishmentError = 'Veuillez sélectionner un établissement';
      } else {
        _establishmentError = null;
      }
    });
  }

  void _validateFirstNameAr() {
    setState(() {
      if (_firstNameArController.text.trim().isEmpty) {
        _firstNameArError = 'الاسم باللغة العربية مطلوب';
      } else if (_firstNameArController.text.trim().length < 2) {
        _firstNameArError = 'الحد الأدنى هو حرفين';
      } else {
        _firstNameArError = null;
      }
    });
  }

  void _validateLastNameAr() {
    setState(() {
      if (_lastNameArController.text.trim().isEmpty) {
        _lastNameArError = 'اللقب باللغة العربية مطلوب';
      } else if (_lastNameArController.text.trim().length < 2) {
        _lastNameArError = 'الحد الأدنى هو حرفين';
      } else {
        _lastNameArError = null;
      }
    });
  }

  void _validateFirstNameFr() {
    setState(() {
      if (_firstNameFrController.text.trim().isEmpty) {
        _firstNameFrError = 'Le prénom en français est requis';
      } else if (_firstNameFrController.text.trim().length < 2) {
        _firstNameFrError = 'Minimum 2 caractères';
      } else {
        _firstNameFrError = null;
      }
    });
  }

  void _validateLastNameFr() {
    setState(() {
      if (_lastNameFrController.text.trim().isEmpty) {
        _lastNameFrError = 'Le nom en français est requis';
      } else if (_lastNameFrController.text.trim().length < 2) {
        _lastNameFrError = 'Minimum 2 caractères';
      } else {
        _lastNameFrError = null;
      }
    });
  }

  void _validateNin() {
    setState(() {
      final digitsOnly = _ninController.text.trim();
      if (digitsOnly.isEmpty) {
        _ninError = 'Le NIN est requis';
      } else if (!RegExp(r'^\d{18}$').hasMatch(digitsOnly)) {
        _ninError = 'Le NIN doit contenir 18 chiffres';
      } else {
        _ninError = null;
      }
    });
  }

  void _validateEmail() {
    setState(() {
      if (_emailController.text.trim().isEmpty) {
        _emailError = 'L\'adresse e-mail est requise';
      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
          .hasMatch(_emailController.text)) {
        _emailError = 'Veuillez entrer une adresse e-mail valide';
      } else {
        _emailError = null;
      }
    });
    if (_confirmEmailController.text.trim().isNotEmpty) {
      _validateConfirmEmail();
    }
  }

  void _validateConfirmEmail() {
    setState(() {
      if (_confirmEmailController.text.trim().isEmpty) {
        _confirmEmailError = 'Veuillez confirmer votre adresse e-mail';
      } else if (_confirmEmailController.text.trim() !=
          _emailController.text.trim()) {
        _confirmEmailError = 'Les adresses e-mail ne correspondent pas';
      } else {
        _confirmEmailError = null;
      }
    });
  }

  void _validatePhone() {
    setState(() {
      if (_phoneController.text.trim().isEmpty) {
        _phoneError = 'Le numéro de téléphone est requis';
      } else if (_phoneController.text.replaceAll(RegExp(r'[^\d]'), '').length <
          8) {
        _phoneError = 'Veuillez entrer un numéro valide';
      } else {
        _phoneError = null;
      }
    });
  }

  void _validateGender() {
    setState(() {
      if (_selectedGender == null) {
        _genderError = 'Veuillez sélectionner le genre';
      } else {
        _genderError = null;
      }
    });
  }

  void _validatePhoto() {
    setState(() {
      if (_identityPhoto == null) {
        _photoError = 'La photo d\'identité est requise';
      } else {
        _photoError = null;
      }
    });
  }

  void _validatePassword() {
    setState(() {
      if (_passwordController.text.isEmpty) {
        _passwordError = 'Le mot de passe est requis';
      } else if (_passwordController.text.length < 6) {
        _passwordError = 'Le mot de passe doit contenir au moins 6 caractères';
      } else {
        _passwordError = null;
      }
    });
    if (_confirmPasswordController.text.isNotEmpty) {
      _validateConfirmPassword();
    }
  }

  void _validateConfirmPassword() {
    setState(() {
      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = 'Veuillez confirmer votre mot de passe';
      } else if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Les mots de passe ne correspondent pas';
      } else {
        _confirmPasswordError = null;
      }
    });
  }

  Future<void> _pickIdentityPhoto() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _identityPhoto = image;
        });
        _validatePhoto();
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Impossible de capturer la photo",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        textColor: Colors.white,
      );
    }
  }

  bool _isCurrentStepValid() {
    switch (_currentStep) {
      case 0: // Establishment & Identity
        return _establishmentError == null &&
            _firstNameArError == null &&
            _lastNameArError == null &&
            _firstNameFrError == null &&
            _lastNameFrError == null &&
            _ninError == null &&
            _genderError == null &&
            _photoError == null &&
            _selectedEstablishment != null &&
            _firstNameArController.text.trim().isNotEmpty &&
            _lastNameArController.text.trim().isNotEmpty &&
            _firstNameFrController.text.trim().isNotEmpty &&
            _lastNameFrController.text.trim().isNotEmpty &&
            _ninController.text.trim().isNotEmpty &&
            _selectedGender != null &&
            _identityPhoto != null;
      case 1: // Email & Phone
        return _emailError == null &&
            _confirmEmailError == null &&
            _phoneError == null &&
            _emailController.text.trim().isNotEmpty &&
            _confirmEmailController.text.trim().isNotEmpty &&
            _phoneController.text.trim().isNotEmpty;
      case 2: // Password
        return _passwordError == null &&
            _confirmPasswordError == null &&
            _passwordController.text.isNotEmpty &&
            _confirmPasswordController.text.isNotEmpty;
      case 3: // Security
        return _acceptInformation && _acceptLaw && _isCaptchaVerified;
      default:
        return false;
    }
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }

  Future<void> _createAccount() async {
    if (!_isCurrentStepValid()) return;

    setState(() {
      _isLoading = true;
    });
 String _generateDossierNumber() {

  final year = DateTime.now().year;

  final sequence =
      (100000 +
      DateTime.now().millisecondsSinceEpoch % 900000)

      .toString()

      .substring(0, 6);

  return '$year-$sequence';
}
    try {
      // Simulate account creation
      await Future.delayed(Duration(seconds: 3));

      Fluttertoast.showToast(
        msg: "Compte créé avec succès!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        textColor: Colors.white,
      );

      if (mounted) {

  final dossierNumber = _generateDossierNumber();

  context.go(
    AppRoutes.successRegistrationScreen,

    extra: dossierNumber,
  );
}
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Erreur lors de la création du compte",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        textColor: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Widget _buildEstablishmentStep() {
    return EstablishmentSection(
      establishmentController: _establishmentController,
      firstNameArController: _firstNameArController,
      lastNameArController: _lastNameArController,
      firstNameFrController: _firstNameFrController,
      lastNameFrController: _lastNameFrController,
      ninController: _ninController,
      establishments: _establishments,
      selectedEstablishment: _selectedEstablishment,
      selectedGender: _selectedGender,
      identityPhoto: _identityPhoto,
      establishmentError: _establishmentError,
      firstNameArError: _firstNameArError,
      lastNameArError: _lastNameArError,
      firstNameFrError: _firstNameFrError,
      lastNameFrError: _lastNameFrError,
      ninError: _ninError,
      genderError: _genderError,
      photoError: _photoError,
      onEstablishmentChanged: (value) {
        setState(() {
          _selectedEstablishment = value;
          _establishmentController.text = value ?? '';
        });
        _validateEstablishment();
      },
      onFirstNameArChanged: _validateFirstNameAr,
      onLastNameArChanged: _validateLastNameAr,
      onFirstNameFrChanged: _validateFirstNameFr,
      onLastNameFrChanged: _validateLastNameFr,
      onNinChanged: _validateNin,
      onGenderChanged: (value) {
        setState(() => _selectedGender = value);
        _validateGender();
      },
      onPickPhoto: _pickIdentityPhoto,
    );
  }

  Widget _buildEmailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Adresse e-mail',
            errorText: _emailError,
          ),
          onChanged: (_) => _validateEmail(),
        ),
        SizedBox(height: 2.h),
        TextFormField(
          controller: _confirmEmailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Confirmer l\'adresse e-mail',
            errorText: _confirmEmailError,
          ),
          onChanged: (_) => _validateConfirmEmail(),
        ),
        SizedBox(height: 3.h),
        ContactLocationSection(
          phoneController: _phoneController,
          phoneError: _phoneError,
          onPhoneChanged: _validatePhone,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Header with Back Button and Progress
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _currentStep > 0
                          ? _previousStep
                          : () => Navigator.pop(context),
                      icon: CustomIconWidget(
                        iconName: 'arrow_back',
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                        size: 24,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Créer un compte',
                            style: AppTheme.lightTheme.textTheme.headlineSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            'Rejoignez la plateforme',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 48), // Balance the back button
                  ],
                ),
              ),

              // Progress Indicator
              RegistrationProgressIndicator(
                currentStep: _currentStep,
                totalSteps: _totalSteps,
              ),

              // Form Content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    // Step 1: Establishment & Identity
                    SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: _buildEstablishmentStep(),
                    ),

                    // Step 2: Email
                    SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: _buildEmailStep(),
                    ),

                    // Step 3: Password Setup
                    SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: PasswordSection(
                        passwordController: _passwordController,
                        confirmPasswordController: _confirmPasswordController,
                        passwordError: _passwordError,
                        confirmPasswordError: _confirmPasswordError,
                        onPasswordChanged: _validatePassword,
                        onConfirmPasswordChanged: _validateConfirmPassword,
                      ),
                    ),

                    // Step 4: Security
                    SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Column(
                        children: [
                          SizedBox(height: 2.h),
                          SecuritySection(
                            isInfoAccurateAccepted: _acceptInformation,
                            isDataPolicyAccepted: _acceptLaw,
                            onInfoAccurateChanged: () {
                              setState(() {
                                _acceptInformation = !_acceptInformation;
                              });
                            },
                            onDataPolicyChanged: () {
                              setState(() {
                                _acceptLaw = !_acceptLaw;
                              });
                            },
                            isCaptchaVerified: _isCaptchaVerified,
                            onCaptchaVerifiedChanged: (verified) {
                              setState(() {
                                _isCaptchaVerified = verified;
                              });
                            },
                            captchaError: _captchaError,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Action Buttons
              Container(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  children: [
                    // Main Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 6.h,
                      child: ElevatedButton(
                        onPressed: _isCurrentStepValid()
                            ? (_currentStep == _totalSteps - 1
                                ? _createAccount
                                : _nextStep)
                            : null,
                        child: _isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppTheme.lightTheme.colorScheme.onPrimary,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _currentStep == _totalSteps - 1
                                        ? 'Créer mon compte'
                                        : 'Continuer',
                                    style: AppTheme
                                        .lightTheme.textTheme.titleMedium
                                        ?.copyWith(
                                      color: AppTheme
                                          .lightTheme.colorScheme.onPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  if (_currentStep < _totalSteps - 1) ...[
                                    SizedBox(width: 2.w),
                                    CustomIconWidget(
                                      iconName: 'arrow_forward',
                                      color: AppTheme
                                          .lightTheme.colorScheme.onPrimary,
                                      size: 18,
                                    ),
                                  ],
                                ],
                              ),
                      ),
                    ),
                    SizedBox(height: 2.h),

                    // Login Link
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, '/login-screen'),
                      child: RichText(
                        text: TextSpan(
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                          children: [
                            TextSpan(text: 'Vous avez déjà un compte? '),
                            TextSpan(
                              text: 'Se connecter',
                              style: TextStyle(
                                color: AppTheme.lightTheme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}