import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 20.h,
            pinned: true,
            backgroundColor: theme.colorScheme.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0B5D3B), Color(0xFF69C12F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 2.h),
                      Container(
                        width: 18.w,
                        height: 18.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(51),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(1.5.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/images/club-master-logo-1781003224586.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'ClubMaster',
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              'À propos',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.h),

                  // Club Description
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 26 : 10),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Piscine Municipale ClubMaster',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'La Piscine Municipale ClubMaster est un complexe aquatique moderne offrant des installations de premier ordre pour la natation, l\'aquagym et les loisirs aquatiques. Fondée en 2010, notre piscine accueille des milliers de membres chaque année dans un environnement sûr et convivial.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10.sp,
                            color: theme.colorScheme.onSurface.withAlpha(179),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Contact Information
                  Text(
                    'Coordonnées',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 26 : 10),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildContactRow(
                          context,
                          Icons.phone_rounded,
                          const Color(0xFF4CAF50),
                          'Téléphone',
                          '+213 7 05 95 84 84',
                        ),
                        _buildDivider(context),
                        _buildContactRow(
                          context,
                          Icons.email_rounded,
                          const Color(0xFF1565C0),
                          'Email',
                          'contact@clubmaster.dz',
                        ),
                        _buildDivider(context),
                        _buildContactRow(
                          context,
                          Icons.location_on_rounded,
                          const Color(0xFFE53935),
                          'Adresse',
                          '123 Rue de la Piscine, Alger, Algérie',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Opening Hours
                  Text(
                    'Horaires d\'ouverture',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 26 : 10),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildHoursRow(
                          context,
                          'Lundi - Vendredi',
                          '06:00 - 21:00',
                        ),
                        _buildDivider(context),
                        _buildHoursRow(context, 'Samedi', '07:00 - 20:00'),
                        _buildDivider(context),
                        _buildHoursRow(
                          context,
                          'Dimanche',
                          '08:00 - 18:00',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Map Placeholder
                  Container(
                    width: double.infinity,
                    height: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 26 : 10),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Stack(
                        children: [
                          Image.network(
                            'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=600&h=300&fit=crop',
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            semanticLabel:
                                'Aerial view of city map showing streets and buildings in Algiers',
                          ),
                          Container(color: Colors.black.withAlpha(77)),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.location_on_rounded,
                                  color: Colors.white,
                                  size: 36,
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  'Voir sur la carte',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),

                  // Social Media
                  Text(
                    'Réseaux sociaux',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      _buildSocialButton(
                        context,
                        'Facebook',
                        Icons.facebook_rounded,
                        const Color(0xFF1877F2),
                      ),
                      SizedBox(width: 3.w),
                      _buildSocialButton(
                        context,
                        'Instagram',
                        Icons.camera_alt_rounded,
                        const Color(0xFFE1306C),
                      ),
                      SizedBox(width: 3.w),
                      _buildSocialButton(
                        context,
                        'Twitter',
                        Icons.alternate_email_rounded,
                        const Color(0xFF1DA1F2),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(
    BuildContext context,
    IconData icon,
    Color iconColor,
    String label,
    String value, {
    bool isLast = false,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Row(
        children: [
          Container(
            width: 9.w,
            height: 9.w,
            decoration: BoxDecoration(
              color: iconColor.withAlpha(26),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: iconColor, size: 18),
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
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoursRow(
    BuildContext context,
    String day,
    String hours, {
    bool isLast = false,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Text(
            hours,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1565C0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final theme = Theme.of(context);
    return Divider(
      color: theme.colorScheme.outlineVariant,
      height: 1,
      indent: 4.w,
      endIndent: 4.w,
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    String name,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(isDark ? 26 : 10),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            SizedBox(height: 0.5.h),
            Text(
              name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9.sp,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withAlpha(179),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
