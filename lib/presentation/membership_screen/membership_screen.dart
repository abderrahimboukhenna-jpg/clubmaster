import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';


class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Mon Abonnement',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0B5D3B), Color(0xFF69C12F)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1565C0).withAlpha(51),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Abonnement Annuel',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          'ACTIF',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Piscine Municipale',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withAlpha(204),
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      _buildDateInfo('Début', '15/01/2025'),
                      SizedBox(width: 6.w),
                      _buildDateInfo('Expiration', '15/01/2026'),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '45 jours restants',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white.withAlpha(204),
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: LinearProgressIndicator(
                      value: 45 / 365,
                      backgroundColor: Colors.white.withAlpha(51),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF29B6F6),
                      ),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),

            // Details Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(isDark ? 26 : 13),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Détails de l\'abonnement',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  _buildDetailRow(
                    context,
                    Icons.pool_rounded,
                    'Type',
                    'Piscine Municipale',
                  ),
                  _buildDetailRow(
                    context,
                    Icons.calendar_today_rounded,
                    'Date de début',
                    '15 Janvier 2025',
                  ),
                  _buildDetailRow(
                    context,
                    Icons.event_rounded,
                    'Date d\'expiration',
                    '15 Janvier 2026',
                  ),
                  _buildDetailRow(
                    context,
                    Icons.timer_rounded,
                    'Jours restants',
                    '45 jours',
                  ),
                  _buildDetailRow(
                    context,
                    Icons.fitness_center_rounded,
                    'Séances restantes',
                    '12 séances',
                    isLast: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),

            // Renewal History
            Text(
              'Historique des renouvellements',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 2.h),
            _buildTimelineItem(
              context,
              '15/01/2025',
              'Renouvellement',
              'Abonnement annuel renouvelé',
              isFirst: true,
            ),
            _buildTimelineItem(
              context,
              '15/01/2024',
              'Renouvellement',
              'Abonnement annuel renouvelé',
            ),
            _buildTimelineItem(
              context,
              '15/01/2023',
              'Renouvellement',
              'Abonnement annuel renouvelé',
            ),
            _buildTimelineItem(
              context,
              '15/01/2022',
              'Première inscription',
              'Inscription initiale au club',
              isLast: true,
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDateInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white.withAlpha(153),
            fontSize: 9.sp,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            color: Colors.white,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool isLast = false,
  }) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          child: Row(
            children: [
              Container(
                width: 9.w,
                height: 9.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF0B5D3B).withAlpha(20),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(icon, color: const Color(0xFF0B5D3B), size: 18),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9.sp,
                        color: theme.colorScheme.onSurface.withAlpha(128),
                      ),
                    ),
                    Text(
                      value,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(color: theme.colorScheme.outlineVariant, height: 1),
      ],
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    String date,
    String title,
    String subtitle, {
    bool isFirst = false,
    bool isLast = false,
  }) {
    final theme = Theme.of(context);
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 4.w),
          Column(
            children: [
              if (!isFirst)
                Container(
                  width: 2,
                  height: 1.h,
                  color: const Color(0xFF0B5D3B).withAlpha(51),
                ),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isFirst
                      ? const Color(0xFF69C12F)
                      : const Color(0xFF69C12F).withAlpha(102),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF69C12F),
                    width: isFirst ? 0 : 1.5,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFF1565C0).withAlpha(51),
                  ),
                ),
            ],
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 2.h),
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 0.3.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9.sp,
                      color: theme.colorScheme.onSurface.withAlpha(153),
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    date,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 9.sp,
                      color: const Color(0xFF1565C0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 4.w),
        ],
      ),
    );
  }
}
