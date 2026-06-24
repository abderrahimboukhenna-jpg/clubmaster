import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EstablishmentSection extends StatelessWidget {
  final TextEditingController establishmentController;
  final TextEditingController firstNameArController;
  final TextEditingController lastNameArController;
  final TextEditingController firstNameFrController;
  final TextEditingController lastNameFrController;
  final TextEditingController ninController;

  final List<String> establishments;
  final String? selectedEstablishment;
  final String? selectedGender;
  final dynamic identityPhoto; 

  final String? establishmentError;
  final String? firstNameArError;
  final String? lastNameArError;
  final String? firstNameFrError;
  final String? lastNameFrError;
  final String? ninError;
  final String? genderError;
  final String? photoError;

  final ValueChanged<String?> onEstablishmentChanged;
  final VoidCallback onFirstNameArChanged;
  final VoidCallback onLastNameArChanged;
  final VoidCallback onFirstNameFrChanged;
  final VoidCallback onLastNameFrChanged;
  final VoidCallback onNinChanged;
  final ValueChanged<String?> onGenderChanged;
  final VoidCallback onPickPhoto;

  const EstablishmentSection({
    super.key,
    required this.establishmentController,
    required this.firstNameArController,
    required this.lastNameArController,
    required this.firstNameFrController,
    required this.lastNameFrController,
    required this.ninController,
    required this.establishments,
    this.selectedEstablishment,
    this.selectedGender,
    this.identityPhoto,
    this.establishmentError,
    this.firstNameArError,
    this.lastNameArError,
    this.firstNameFrError,
    this.lastNameFrError,
    this.ninError,
    this.genderError,
    this.photoError,
    required this.onEstablishmentChanged,
    required this.onFirstNameArChanged,
    required this.onLastNameArChanged,
    required this.onFirstNameFrChanged,
    required this.onLastNameFrChanged,
    required this.onNinChanged,
    required this.onGenderChanged,
    required this.onPickPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations personnelles',
          style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 3.h),

        // Establishment Dropdown
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Établissement *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            DropdownButtonFormField<String>(
              value: selectedEstablishment,
              items: establishments
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: onEstablishmentChanged,
              decoration: InputDecoration(
                hintText: 'Sélectionnez votre établissement',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'school',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                errorText: establishmentError,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.5.h),

        // First Name (Arabic)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'الاسم (بالعربية) *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            TextFormField(
              controller: firstNameArController,
              textDirection: TextDirection.rtl,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => onFirstNameArChanged(),
              decoration: InputDecoration(
                hintText: 'الاسم',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'person',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                errorText: firstNameArError,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.5.h),

        // Last Name (Arabic)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'اللقب (بالعربية) *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            TextFormField(
              controller: lastNameArController,
              textDirection: TextDirection.rtl,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => onLastNameArChanged(),
              decoration: InputDecoration(
                hintText: 'اللقب',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'person_outline',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                errorText: lastNameArError,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.5.h),

        // First Name (French)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prénom (en français) *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            TextFormField(
              controller: firstNameFrController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => onFirstNameFrChanged(),
              decoration: InputDecoration(
                hintText: 'Votre prénom',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'person',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                errorText: firstNameFrError,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.5.h),

        // Last Name (French)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom (en français) *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            TextFormField(
              controller: lastNameFrController,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => onLastNameFrChanged(),
              decoration: InputDecoration(
                hintText: 'Votre nom de famille',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'person_outline',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                errorText: lastNameFrError,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.5.h),

        // NIN
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NIN (Numéro d\'Identification Nationale) *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            TextFormField(
              controller: ninController,
              keyboardType: TextInputType.number,
              maxLength: 18,
              onChanged: (_) => onNinChanged(),
              decoration: InputDecoration(
                hintText: '18 chiffres',
                counterText: '',
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'badge',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                errorText: ninError,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.5.h),

        // Gender
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Genre *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Homme'),
                    value: 'male',
                    groupValue: selectedGender,
                    onChanged: onGenderChanged,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Femme'),
                    value: 'female',
                    groupValue: selectedGender,
                    onChanged: onGenderChanged,
                  ),
                ),
              ],
            ),
            if (genderError != null)
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: Text(
                  genderError!,
                  style: TextStyle(
                    color: AppTheme.lightTheme.colorScheme.error,
                    fontSize: 12.sp,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 2.5.h),

        // Identity Photo
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Photo d\'identité *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            InkWell(
              onTap: onPickPhoto,
              child: Container(
                width: double.infinity,
                height: 20.h,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: photoError != null
                        ? AppTheme.lightTheme.colorScheme.error
                        : AppTheme.lightTheme.colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: identityPhoto == null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconWidget(
                              iconName: 'camera_alt',
                              color: AppTheme.lightTheme.colorScheme.primary,
                              size: 32,
                            ),
                            SizedBox(height: 1.h),
                            Text('Prendre une photo'),
                          ],
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(identityPhoto.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      ),
              ),
            ),
            if (photoError != null)
              Padding(
                padding: EdgeInsets.only(top: 0.5.h, left: 1.w),
                child: Text(
                  photoError!,
                  style: TextStyle(
                    color: AppTheme.lightTheme.colorScheme.error,
                    fontSize: 12.sp,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}