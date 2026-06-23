import 'dart:developer';

import 'package:clubmaster/core/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../routes/app_routes.dart';

// ── Pre-computed alpha colors — zero allocation at runtime ──────
// onSurface light (0xFF1A1A1A) with various alphas
const Color _onSurfaceLight50 = Color(0x801A1A1A); // withAlpha(128)
const Color _onSurfaceLight30 = Color(0x4D1A1A1A); // withAlpha(77)
const Color _onSurfaceLight40 = Color(0x661A1A1A); // withAlpha(102)
// onSurface dark (0xFFE6E6F0) with various alphas
const Color _onSurfaceDark50  = Color(0x80E6E6F0); // withAlpha(128)
const Color _onSurfaceDark30  = Color(0x4DE6E6F0); // withAlpha(77)
const Color _onSurfaceDark40  = Color(0x66E6E6F0); // withAlpha(102)
// Shadow colors
const Color _shadowLight       = Color(0x0A000000); // withAlpha(10)
const Color _shadowDark        = Color(0x1A000000); // withAlpha(26)

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage   = 'fr';
  bool _notificationsEnabled = true;
  bool _membershipReminders  = true;
  bool _sessionReminders     = true;

  // ── Cached static styles — built ONCE, never rebuilt ───────────
  static final TextStyle _sectionHeaderStyle = GoogleFonts.plusJakartaSans(
    fontWeight: FontWeight.w700,
    color: const Color(0xFF0B5D3B),
    letterSpacing: 0.5,
  );

  @override
  Widget build(BuildContext context) {
    Timeline.startSync('SettingsScreen build');
    try {
    final theme  = Theme.of(context);
    final cs     = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // ── Pre-resolve per-theme colors ONCE at top of build() ──────
    final onSurface     = cs.onSurface;
    final onSurface50   = isDark ? _onSurfaceDark50  : _onSurfaceLight50;
    final onSurface30   = isDark ? _onSurfaceDark30  : _onSurfaceLight30;
    final onSurface40   = isDark ? _onSurfaceDark40  : _onSurfaceLight40;
    final shadowColor   = isDark ? _shadowDark        : _shadowLight;
    final surfaceColor  = cs.surface;
    final dividerColor  = cs.outlineVariant;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Paramètres',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: surfaceColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Langue ──────────────────────────────────────────────
            _buildSectionHeader(),
            SizedBox(height: 1.h),
            _Card(
              surfaceColor: surfaceColor,
              shadowColor:  shadowColor,
              child: Column(children: [
                _LanguageOption(
                  code: 'fr', name: 'Français', flag: '🇫🇷',
                  selectedLanguage: _selectedLanguage,
                  onSurface: onSurface,
                  onTap: () => setState(() => _selectedLanguage = 'fr'),
                ),
                _Divider(color: dividerColor),
                _LanguageOption(
                  code: 'ar', name: 'العربية', flag: '🇩🇿',
                  selectedLanguage: _selectedLanguage,
                  onSurface: onSurface,
                  isLast: true,
                  onTap: () => setState(() => _selectedLanguage = 'ar'),
                ),
              ]),
            ),
            SizedBox(height: 3.h),

            // ── Apparence — Selector rebuilds ONLY this Switch ──────
            _buildSectionHeader(title: 'Apparence'),
            SizedBox(height: 1.h),
            _Card(
              surfaceColor: surfaceColor,
              shadowColor:  shadowColor,
              child: Selector<ThemeNotifier, bool>(
                selector: (_, n) => n.isDark,
                builder: (ctx, isDarkMode, _) => _ToggleRow(
                  icon:       Icons.dark_mode_rounded,
                  iconColor:  const Color(0xFF0B5D3B),
                  title:      'Mode sombre',
                  subtitle:   'Activer le thème sombre',
                  value:      isDarkMode,
                  onChanged:  (val) => context.read<ThemeNotifier>().toggleTheme(val),
                  onSurface:  onSurface,
                  onSurface50: onSurface50,
                  isLast:     true,
                ),
              ),
            ),
            SizedBox(height: 3.h),

            // ── Notifications ────────────────────────────────────────
            _buildSectionHeader(title: 'Notifications'),
            SizedBox(height: 1.h),
            _Card(
              surfaceColor: surfaceColor,
              shadowColor:  shadowColor,
              child: Column(children: [
                _ToggleRow(
                  icon: Icons.notifications_rounded,
                  iconColor: const Color(0xFF69C12F),
                  title: 'Notifications',
                  subtitle: 'Activer toutes les notifications',
                  value: _notificationsEnabled,
                  onChanged: (val) => setState(() => _notificationsEnabled = val),
                  onSurface: onSurface,
                  onSurface50: onSurface50,
                ),
                _Divider(color: dividerColor),
                _ToggleRow(
                  icon: Icons.card_membership_rounded,
                  iconColor: const Color(0xFFF59E0B),
                  title: 'Rappels abonnement',
                  subtitle: "Rappels d'expiration",
                  value: _membershipReminders,
                  onChanged: (val) => setState(() => _membershipReminders = val),
                  onSurface: onSurface,
                  onSurface50: onSurface50,
                ),
                _Divider(color: dividerColor),
                _ToggleRow(
                  icon: Icons.pool_rounded,
                  iconColor: const Color(0xFF29B6F6),
                  title: 'Rappels séances',
                  subtitle: 'Rappels avant chaque séance',
                  value: _sessionReminders,
                  onChanged: (val) => setState(() => _sessionReminders = val),
                  onSurface: onSurface,
                  onSurface50: onSurface50,
                  isLast: true,
                ),
              ]),
            ),
            SizedBox(height: 3.h),

            // ── À propos ─────────────────────────────────────────────
            _buildSectionHeader(title: 'À propos & Support'),
            SizedBox(height: 1.h),
            _Card(
              surfaceColor: surfaceColor,
              shadowColor:  shadowColor,
              child: Column(children: [
                _NavRow(
                  icon: Icons.info_rounded,
                  iconColor: const Color(0xFF0B5D3B),
                  title: 'À propos',
                  subtitle: 'Informations sur le club',
                  onTap: () => context.push(AppRoutes.aboutScreen),
                  onSurface: onSurface,
                  onSurface50: onSurface50,
                  onSurface30: onSurface30,
                ),
                _Divider(color: dividerColor),
                _NavRow(
                  icon: Icons.help_rounded,
                  iconColor: const Color(0xFF69C12F),
                  title: 'Aide & Support',
                  subtitle: 'FAQ et contact',
                  onTap: () {},
                  onSurface: onSurface,
                  onSurface50: onSurface50,
                  onSurface30: onSurface30,
                ),
                _Divider(color: dividerColor),
                _NavRow(
                  icon: Icons.privacy_tip_rounded,
                  iconColor: const Color(0xFF69C12F),
                  title: 'Confidentialité',
                  subtitle: 'Politique de confidentialité',
                  onTap: () {},
                  onSurface: onSurface,
                  onSurface50: onSurface50,
                  onSurface30: onSurface30,
                  isLast: true,
                ),
              ]),
            ),
            SizedBox(height: 3.h),

            // ── Logout ───────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showLogoutDialog(context, onSurface),
                icon: const Icon(Icons.logout_rounded, size: 18),
                label: Text(
                  'Se déconnecter',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11.sp, fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 1.5.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Center(
              child: Text(
                'ClubMaster v1.0.0',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.sp,
                  color: onSurface40, // ← was withAlpha(102)
                ),
              ),
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
    }finally {

    Timeline.finishSync();

  }
    
}

  // ── Logout dialog — colors passed in, no Theme.of inside ───────
  void _showLogoutDialog(BuildContext context, Color onSurface) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Déconnexion',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        content: Text('Êtes-vous sûr de vouloir vous déconnecter?',
            style: GoogleFonts.plusJakartaSans()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Annuler',
                style: GoogleFonts.plusJakartaSans(color: onSurface)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.go(AppRoutes.loginScreen);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935)),
            child: Text('Déconnecter',
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({String title = 'Langue / اللغة'}) => Text(
    title,
    style: _sectionHeaderStyle.copyWith(fontSize: 11.sp),
  );
}

// ─────────────────────────────────────────────────────────────────
// Extracted widgets — colors passed as params = no Theme.of inside
// ─────────────────────────────────────────────────────────────────

/// Card container — receives colors, never calls Theme.of
class _Card extends StatelessWidget {
  final Widget child;
  final Color surfaceColor;
  final Color shadowColor;
  const _Card({
    required this.child,
    required this.surfaceColor,
    required this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
 
}


/// Divider — receives color directly
class _Divider extends StatelessWidget {
  final Color color;
  const _Divider({required this.color});

  @override
  Widget build(BuildContext context) => Divider(
    color: color,
    height: 1,
    indent: 16,
    endIndent: 16,
  );
}

/// Icon box — pre-computed background color passed in
class _IconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor; // pre-computed color.withAlpha(26)
  const _IconBox({required this.icon, required this.color, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 9.w, height: 9.w,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 18),
    );
  }
}

/// Language option row
class _LanguageOption extends StatelessWidget {
  final String code;
  final String name;
  final String flag;
  final String selectedLanguage;
  final Color onSurface;
  final VoidCallback onTap;
  final bool isLast;

  const _LanguageOption({
    required this.code,
    required this.name,
    required this.flag,
    required this.selectedLanguage,
    required this.onSurface,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedLanguage == code;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(isLast ? 16 : 0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        child: Row(children: [
          Text(flag, style: const TextStyle(fontSize: 24)),
          SizedBox(width: 3.w),
          Expanded(
            child: Text(name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? const Color(0xFF0B5D3B) : onSurface,
              ),
            ),
          ),
          Radio<String>(
            value: code,
            groupValue: selectedLanguage,
            onChanged: (_) => onTap(),
            activeColor: const Color(0xFF0B5D3B),
          ),
        ]),
      ),
    );
  }
}

/// Toggle row — all colors passed in, zero Theme.of calls
class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color onSurface;
  final Color onSurface50;
  final bool isLast;

  const _ToggleRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.onSurface,
    required this.onSurface50,
    this.isLast = false,
  });

  // ── Pre-compute icon background once per unique color ──────────
  // Color(iconColor.value) with alpha 0x1A = 10%
  Color get _iconBg => Color(iconColor.value & 0x00FFFFFF | 0x1A000000);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      child: Row(children: [
        _IconBox(icon: icon, color: iconColor, bgColor: _iconBg),
        SizedBox(width: 3.w),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: onSurface,
              ),
            ),
            Text(subtitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9.sp,
                color: onSurface50, // ← was withAlpha(128)
              ),
            ),
          ],
        )),
        Switch(
          value: value,
          onChanged: onChanged,
          activeTrackColor: const Color(0xFF0B5D3B),
          activeThumbColor: Colors.white,
        ),
      ]),
    );
  }
}

/// Nav row — all colors passed in, zero Theme.of calls
class _NavRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color onSurface;
  final Color onSurface50;
  final Color onSurface30;
  final bool isLast;

  const _NavRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onSurface,
    required this.onSurface50,
    required this.onSurface30,
    this.isLast = false,
  });

  Color get _iconBg => Color(iconColor.value & 0x00FFFFFF | 0x1A000000);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(isLast ? 16 : 0),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        child: Row(children: [
          _IconBox(icon: icon, color: iconColor, bgColor: _iconBg),
          SizedBox(width: 3.w),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: onSurface,
                ),
              ),
              Text(subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 9.sp,
                  color: onSurface50, // ← was withAlpha(128)
                ),
              ),
            ],
          )),
          Icon(
            Icons.chevron_right_rounded,
            color: onSurface30, // ← was withAlpha(77)
            size: 18,
          ),
        ]),
      ),
    );
  }
}