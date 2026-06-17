import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

enum MembershipStatus { active, expiringSoon, expired, pending }

class StatusBadgeWidget extends StatelessWidget {
  final MembershipStatus status;
  final bool compact;

  const StatusBadgeWidget({
    required this.status,
    this.compact = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final config = _getConfig(status);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: config.bgColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: config.borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? 5 : 6,
            height: compact ? 5 : 6,
            decoration: BoxDecoration(
              color: config.dotColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: compact ? 4 : 5),
          Text(
            config.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: compact ? 10 : 11,
              fontWeight: FontWeight.w700,
              color: config.textColor,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  _StatusConfig _getConfig(MembershipStatus status) {
    switch (status) {
      case MembershipStatus.active:
        return _StatusConfig(
          label: 'ACTIF',
          bgColor: AppTheme.successContainer,
          borderColor: AppTheme.success.withAlpha(77),
          dotColor: AppTheme.success,
          textColor: AppTheme.success,
        );
      case MembershipStatus.expiringSoon:
        return _StatusConfig(
          label: 'EXPIRE BIENTÔT',
          bgColor: AppTheme.warningContainer,
          borderColor: AppTheme.warning.withAlpha(77),
          dotColor: AppTheme.warning,
          textColor: AppTheme.warning,
        );
      case MembershipStatus.expired:
        return _StatusConfig(
          label: 'EXPIRÉ',
          bgColor: AppTheme.errorContainer,
          borderColor: AppTheme.error.withAlpha(77),
          dotColor: AppTheme.error,
          textColor: AppTheme.error,
        );
      case MembershipStatus.pending:
        return _StatusConfig(
          label: 'EN ATTENTE',
          bgColor: AppTheme.accentContainer,
          borderColor: AppTheme.accent.withAlpha(77),
          dotColor: AppTheme.accent,
          textColor: AppTheme.primaryLight,
        );
    }
  }
}

class _StatusConfig {
  final String label;
  final Color bgColor;
  final Color borderColor;
  final Color dotColor;
  final Color textColor;

  _StatusConfig({
    required this.label,
    required this.bgColor,
    required this.borderColor,
    required this.dotColor,
    required this.textColor,
  });
}
