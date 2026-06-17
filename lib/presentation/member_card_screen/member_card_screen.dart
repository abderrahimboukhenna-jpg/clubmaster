import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_theme.dart';
import './widgets/card_actions_widget.dart';
import './widgets/card_qr_widget.dart';
import './widgets/digital_card_widget.dart';

class MemberCardScreen extends StatefulWidget {
  const MemberCardScreen({super.key});

  @override
  State<MemberCardScreen> createState() => _MemberCardScreenState();
}

class _MemberCardScreenState extends State<MemberCardScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _cardOpacity;
  late Animation<Offset> _cardSlide;
  late Animation<double> _qrOpacity;
  late Animation<double> _actionsOpacity;
  late Animation<double> _cardScale;

  // TODO: Replace with [Riverpod/Bloc] for production — member data from API
  final Map<String, dynamic> _memberData = {
    'fullName': 'Karim Benali',
    'membershipType': 'Abonnement Piscine',
    'status': 'active',
    'memberId': 'CM-2024-0847',
    'expirationDate': '25 Juillet 2026',
    'startDate': '25 Juillet 2024',
    'memberSince': '12 Janvier 2024',
    'photoUrl':
        'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=400',
    'remainingDays': 47,
  };

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _cardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _cardSlide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
          ),
        );
    _qrOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.35, 0.75, curve: Curves.easeOut),
      ),
    );
    _actionsOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
      ),
    );

    _entranceController.forward();


    _cardScale = Tween<double>(
  begin: 0.92,
  end: 1.0,
   ).animate(
  CurvedAnimation(
    parent: _entranceController,
    curve: const Interval(
      0.0,
      0.6,
      curve: Curves.easeOutBack,
    ),
  ),
);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // AppBar
            SliverAppBar(
              pinned: true,
              backgroundColor: theme.colorScheme.surface,
              elevation: 0,
              scrolledUnderElevation: 1,
              shadowColor: AppTheme.primary.withAlpha(26),
              title: Text(
                'Ma Carte Membre',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -0.2,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Carte partagée avec succès'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.share_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  tooltip: 'Partager',
                ),
                const SizedBox(width: 8),
              ],
            ),

            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? (size.width - 480) / 2 : 16,
                vertical: 20,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Digital card
                  FadeTransition(
  opacity: _cardOpacity,
  child: SlideTransition(
    position: _cardSlide,
    child: ScaleTransition(
      scale: _cardScale,
      child: DigitalCardWidget(
        memberData: _memberData,
      ),
    ),
  ),
),
                  const SizedBox(height: 24),

                  // QR Code section
                  FadeTransition(
                    opacity: _qrOpacity,
                    child: CardQrWidget(memberData: _memberData),
                  ),
                  const SizedBox(height: 20),

                  // Member details
                  FadeTransition(
                    opacity: _qrOpacity,
                    child: _MemberDetailsCard(
                      memberData: _memberData,
                      theme: theme,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Actions
                  FadeTransition(
                    opacity: _actionsOpacity,
                    child: CardActionsWidget(memberData: _memberData),
                  ),
                  const SizedBox(height: 24),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberDetailsCard extends StatelessWidget {
  final Map<String, dynamic> memberData;
  final ThemeData theme;

  const _MemberDetailsCard({required this.memberData, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Détails de l\'abonnement',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 16),
          _DetailRow(
            icon: Icons.card_membership_rounded,
            label: 'Type',
            value: memberData['membershipType'] as String,
            theme: theme,
          ),
          _Divider(theme: theme),
          _DetailRow(
            icon: Icons.calendar_today_outlined,
            label: 'Début',
            value: memberData['startDate'] as String,
            theme: theme,
          ),
          _Divider(theme: theme),
          _DetailRow(
            icon: Icons.event_outlined,
            label: 'Expiration',
            value: memberData['expirationDate'] as String,
            theme: theme,
            valueColor: AppTheme.primary,
          ),
          _Divider(theme: theme),
          _DetailRow(
            icon: Icons.timer_outlined,
            label: 'Jours restants',
            value: '${memberData['remainingDays']} jours',
            theme: theme,
            valueColor: memberData['remainingDays'] as int > 30
                ? AppTheme.success
                : AppTheme.warning,
          ),
          _Divider(theme: theme),
          _DetailRow(
            icon: Icons.history_rounded,
            label: 'Membre depuis',
            value: memberData['memberSince'] as String,
            theme: theme,
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final ThemeData theme;
  final Color? valueColor;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.theme,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer.withAlpha(128),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 15, color: AppTheme.primary),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: valueColor ?? theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final ThemeData theme;

  const _Divider({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: theme.colorScheme.outlineVariant,
      thickness: 1,
      height: 1,
    );
  }
}
