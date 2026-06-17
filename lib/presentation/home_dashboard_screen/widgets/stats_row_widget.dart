import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class StatsRowWidget extends StatelessWidget {
  final Map<String, dynamic> memberData;

  const StatsRowWidget({required this.memberData, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final stats = [
      _StatItem(
        icon: Icons.timer_outlined,
        value: '${memberData['remainingDays']}',
        unit: 'jours',
        label: 'Restants',
        iconColor: AppTheme.primary,
        iconBg: AppTheme.primaryContainer,
        valueColor: AppTheme.primary,
      ),
      _StatItem(
        icon: Icons.waves_rounded,
        value: '${memberData['remainingSessions']}',
        unit: 'séances',
        label: 'Disponibles',
        iconColor: AppTheme.accent,
        iconBg: AppTheme.accentContainer,
        valueColor: AppTheme.primaryLight,
      ),
      _StatItem(
        icon: Icons.event_available_outlined,
        value: '15',
        unit: 'Juil.',
        label: 'Renouvellement',
        iconColor: AppTheme.success,
        iconBg: AppTheme.successContainer,
        valueColor: AppTheme.success,
      ),
    ];

    return Row(
      children: stats.asMap().entries.map((entry) {
        final i = entry.key;
        final stat = entry.value;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: i == 0 ? 0 : 5,
              right: i == stats.length - 1 ? 0 : 5,
            ),
            child: _StatCard(stat: stat, theme: theme),
          ),
        );
      }).toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final _StatItem stat;
  final ThemeData theme;

  const _StatCard({required this.stat, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: stat.iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(stat.icon, color: stat.iconColor, size: 18),
          ),
          const SizedBox(height: 8),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: stat.value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: stat.valueColor,
                    letterSpacing: -0.5,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                TextSpan(
                  text: ' ${stat.unit}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            stat.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _StatItem {
  final IconData icon;
  final String value;
  final String unit;
  final String label;
  final Color iconColor;
  final Color iconBg;
  final Color valueColor;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.unit,
    required this.label,
    required this.iconColor,
    required this.iconBg,
    required this.valueColor,
  });
}
