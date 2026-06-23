import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class RegistrationProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  
  static const List<String> stepTitles = [
    'Informations',
    'Identité',
    'Sécurité',
    'Validation',
  ];

  const RegistrationProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          // Progress Bar
          Row(
            children: List.generate(totalSteps, (index) {
              final isCompleted = index < currentStep;
              final isCurrent = index == currentStep;

              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isCompleted || isCurrent
                        ? AppTheme.lightTheme.colorScheme.primary
                        : AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                  ),
                ),
              );
            }),
          ),
          SizedBox(height: 1.h),

          // Step Text
          Column(
  children: [

    Text(

      'Étape ${currentStep + 1} sur $totalSteps',

      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(

        color: AppTheme
            .lightTheme
            .colorScheme
            .onSurfaceVariant,

        fontWeight: FontWeight.w500,
      ),
    ),

    SizedBox(height: .5.h),

    Text(

      stepTitles[currentStep],

      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(

        fontWeight: FontWeight.w600,

        color: AppTheme
            .lightTheme
            .colorScheme
            .primary,
      ),
    ),
  ],
)
        ],
      ),
    );
  }
}
