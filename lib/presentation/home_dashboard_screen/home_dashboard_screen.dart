import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';
import '../../routes/app_routes.dart';
import './widgets/news_section_widget.dart';
import './widgets/qr_access_card_widget.dart';
import './widgets/stats_row_widget.dart';
import 'widgets/member_hero_widget.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late Animation<double> _heroOpacity;
  late Animation<Offset> _heroSlide;
  late Animation<double> _statsOpacity;
  late Animation<double> _qrOpacity;
  late Animation<double> _newsOpacity;


  // TODO: Replace with [Riverpod/Bloc] for production — member data from API
  final Map<String, dynamic> _memberData = {
    'fullName': 'Karim Benali',
    'membershipType': 'Piscine Municipale',
    'status': 'active',
    'remainingDays': 47,
    'remainingSessions': 12,
    'nextPaymentDate': '15 Juillet 2026',
    'memberSince': '12 Janvier 2024',
    'photoUrl':
        'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=400',
    'memberId': 'CM-2024-0847',
    'expirationDate': '25 Juillet 2026',
  };

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _heroOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    _heroSlide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.0, 0.5, curve: Curves.easeOutCubic),
          ),
        );
    _statsOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.25, 0.6, curve: Curves.easeOut),
      ),
    );
    _qrOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.4, 0.75, curve: Curves.easeOut),
      ),
    );
    _newsOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
      ),
    );

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    // TODO: Replace with [Riverpod/Bloc] for production — refresh member data
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.primary,
          backgroundColor: theme.colorScheme.surface,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // App bar
              SliverAppBar(
                floating: true,
                snap: true,
                backgroundColor: theme.colorScheme.surface,
                elevation: 0,
                scrolledUnderElevation: 1,
                shadowColor: AppTheme.primary.withAlpha(26),
                title: Row(
                  children: [
                    Image.asset(
                      'assets/images/club-master-logo-1781003224586.png',
                      width: 32,
                      height: 32,
                      fit: BoxFit.contain,
                      semanticLabel: 'ClubMaster logo',
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'ClubMaster',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.primary,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                actions: [
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () =>
                            context.push(AppRoutes.notificationsScreen),
                        icon: Icon(
                          Icons.notifications_outlined,
                          color: theme.colorScheme.onSurface,
                        ),
                        tooltip: 'Notifications',
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppTheme.error,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: theme.colorScheme.surface,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                ],
              ),

              // Body content
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 32 : 16,
                  vertical: 16,
                ),
                sliver: isTablet
                    ? _buildTabletContent(theme)
                    : _buildPhoneContent(theme),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneContent(ThemeData theme) {
    return SliverList(
      delegate: SliverChildListDelegate([
        // Greeting
        _buildGreeting(theme),
        const SizedBox(height: 16),

        // Hero member card
        FadeTransition(
          opacity: _heroOpacity,
          child: SlideTransition(
            position: _heroSlide,
            child: MemberHeroCardWidget(memberData: _memberData),
          ),
        ),
        const SizedBox(height: 16),

        // Stats row
        FadeTransition(
          opacity: _statsOpacity,
          child: StatsRowWidget(memberData: _memberData),
        ),
        const SizedBox(height: 20),

        // QR Access card
        FadeTransition(
          opacity: _qrOpacity,
          child: QrAccessCardWidget(memberData: _memberData),
        ),
        const SizedBox(height: 20),

        // News section
        FadeTransition(opacity: _newsOpacity, child: const NewsSectionWidget()),
        const SizedBox(height: 24),
      ]),
    );
  }

  Widget _buildTabletContent(ThemeData theme) {
    return SliverToBoxAdapter(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left column
          Expanded(
            flex: 6,
            child: Column(
              children: [
                _buildGreeting(theme),
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _heroOpacity,
                  child: MemberHeroCardWidget(memberData: _memberData),
                ),
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _statsOpacity,
                  child: StatsRowWidget(memberData: _memberData),
                ),
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _newsOpacity,
                  child: const NewsSectionWidget(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Right column
          Expanded(
            flex: 4,
            child: FadeTransition(
              opacity: _qrOpacity,
              child: QrAccessCardWidget(memberData: _memberData),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(ThemeData theme) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Bonjour';
    } else if (hour < 18) {
      greeting = 'Bon après-midi';
    } else {
      greeting = 'Bonsoir';
    }

    final firstName = _memberData['fullName'].toString().split(' ').first;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting, $firstName 👋',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '${_memberData['remainingDays']} jours restants sur votre abonnement',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
