
import '../../../core/app_export.dart';

class SignupPromptWidget extends StatelessWidget {
  final VoidCallback onSignupTap;

  const SignupPromptWidget({
    super.key,
    required this.onSignupTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nouveau fermier ? ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  fontSize: 12.sp,
                ),
          ),
          GestureDetector(
            onTap: onSignupTap,
            child: Text(
              'Créer un compte',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    decoration: TextDecoration.underline,
                    decorationColor: AppTheme.lightTheme.colorScheme.primary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
