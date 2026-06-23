import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ContactLocationSection extends StatefulWidget {
  final TextEditingController phoneController;
  final String? phoneError;
  final VoidCallback onPhoneChanged;

  const ContactLocationSection({
    Key? key,
    required this.phoneController,
    this.phoneError,
    required this.onPhoneChanged,
  }) : super(key: key);

  @override
  State<ContactLocationSection> createState() => _ContactLocationSectionState();
}

class _ContactLocationSectionState extends State<ContactLocationSection> {
  String _selectedCountryCode = '+213';

  final List<Map<String, String>> _countryCodes = [
    {'code': '+213', 'country': 'Algérie', 'flag': '🇩🇿'},
    {'code': '+33', 'country': 'France', 'flag': '🇫🇷'},
    {'code': '+32', 'country': 'Belgique', 'flag': '🇧🇪'},
    {'code': '+41', 'country': 'Suisse', 'flag': '🇨🇭'},
    {'code': '+352', 'country': 'Luxembourg', 'flag': '🇱🇺'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 3.h),

        // Phone Number Field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Numéro de téléphone *',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Country Code Dropdown
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    color: AppTheme.lightTheme.colorScheme.surface,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCountryCode,
                      isDense: true,
                      items: _countryCodes.map((country) {
                        return DropdownMenuItem<String>(
                          value: country['code'],
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                country['flag']!,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                country['code']!,
                                style: AppTheme.lightTheme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCountryCode = value!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                // Phone Number Input
                Expanded(
                  child: TextFormField(
                    controller: widget.phoneController,
                    keyboardType: TextInputType.phone,
                    onChanged: (_) => widget.onPhoneChanged(),
                    decoration: InputDecoration(
                      hintText: '6 12 34 56 78',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(3.w),
                        child: CustomIconWidget(
                          iconName: 'phone',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 20,
                        ),
                      ),
                      errorText: widget.phoneError,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}