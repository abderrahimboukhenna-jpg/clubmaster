import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:go_router/go_router.dart';

class _TabSpec {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final int? branchIndex;

  const _TabSpec({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.branchIndex,
  });
}

class AppNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppNavigation({required this.navigationShell, super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedVisualIndex = 0;
  int _previousVisualIndex = 0;

  static const Color _darkGreen   = Color(0xFF003B2A);
  static const Color _midGreen    = Color(0xFF0B5D3B);
  static const Color _accentGreen = Color(0xFF69C12F);
  static const Color _lightGreen  = Color(0xFFF5FFF0);

  static const List<_TabSpec> _tabs = [
    _TabSpec(label: 'Accueil',    icon: Icons.space_dashboard_outlined,  selectedIcon: Icons.space_dashboard_rounded, branchIndex: 0),
    _TabSpec(label: 'Abonnement', icon: Icons.workspace_premium_outlined, selectedIcon: Icons.workspace_premium,       branchIndex: 1),
    _TabSpec(label: 'Planning',   icon: Icons.event_note_outlined,        selectedIcon: Icons.event_note,              branchIndex: 2),
    _TabSpec(label: 'Carte',      icon: Icons.credit_card_outlined,       selectedIcon: Icons.credit_card,             branchIndex: 3),
    _TabSpec(label: 'Profil',     icon: Icons.account_circle_outlined,    selectedIcon: Icons.account_circle,          branchIndex: 4),
  ];

  void _onTabTap(int visualIndex) {
    if (visualIndex == _selectedVisualIndex) return;
    final tab = _tabs[visualIndex];
    if (tab.branchIndex == null) return;
    HapticFeedback.lightImpact();
    setState(() {
      _previousVisualIndex = _selectedVisualIndex;
      _selectedVisualIndex = visualIndex;
    });
    widget.navigationShell.goBranch(
      tab.branchIndex!,
      initialLocation: tab.branchIndex == widget.navigationShell.currentIndex,
    );
  }

  @override
  void didUpdateWidget(AppNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    final currentBranch = widget.navigationShell.currentIndex;
    for (int i = 0; i < _tabs.length; i++) {
      if (_tabs[i].branchIndex == currentBranch && _selectedVisualIndex != i) {
        setState(() {
          _previousVisualIndex = _selectedVisualIndex;
          _selectedVisualIndex = i;
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: _GlassNavBar(
        selectedIndex: _selectedVisualIndex,
        previousIndex: _previousVisualIndex,
        tabs:          _tabs,
        onTap:         _onTabTap,
        darkGreen:     _darkGreen,
        midGreen:      _midGreen,
        accentGreen:   _accentGreen,
        lightGreen:    _lightGreen,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Glass floating bar
// ─────────────────────────────────────────────────────────────────
class _GlassNavBar extends StatelessWidget {
  final int selectedIndex;
  final int previousIndex;
  final List<_TabSpec> tabs;
  final ValueChanged<int> onTap;
  final Color darkGreen, midGreen, accentGreen, lightGreen;

  const _GlassNavBar({
    required this.selectedIndex,
    required this.previousIndex,
    required this.tabs,
    required this.onTap,
    required this.darkGreen,
    required this.midGreen,
    required this.accentGreen,
    required this.lightGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: darkGreen.withValues(alpha: 0.55),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.20),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
                 child: Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(40),
         
             gradient: const LinearGradient(
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
               colors: [
                 Color(0xFF003B2A),
                 Color(0xFF0B5D3B),
               ],
             ),
           ),

          child: Container(
            decoration: BoxDecoration(
              color: midGreen.withValues(alpha: 0.93),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                color: accentGreen.withValues(alpha: 0.30),
                width: 1,
              ),
            ),
            // ── LayoutBuilder so capsule gets real pixel width ──
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // ── Sliding capsule ──
                    _SlidingCapsule(
                      selectedIndex: selectedIndex,
                      tabCount:      tabs.length,
                      accentGreen:   accentGreen,
                      barWidth:      constraints.maxWidth,
                      barHeight:     64,
                    ),
                    // ── Tabs ──
                    Row(
                      children: List.generate(tabs.length, (i) {
                        return Expanded(
                          child: _NavItem(
                            tab:        tabs[i],
                            isSelected: selectedIndex == i,
                            lightGreen: lightGreen,
                            onTap:      () => onTap(i),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Sliding capsule — sized relative to real tab width
// ─────────────────────────────────────────────────────────────────
class _SlidingCapsule extends StatelessWidget {
  final int selectedIndex;
  final int tabCount;
  final Color accentGreen;
  final double barWidth;
  final double barHeight;

  const _SlidingCapsule({
    required this.selectedIndex,
    required this.tabCount,
    required this.accentGreen,
    required this.barWidth,
    required this.barHeight,
  });

  @override
  Widget build(BuildContext context) {
    final tabW      = barWidth / tabCount;
    // capsule width = 90 % of one tab slot, max 104 px
    final capsuleW = (tabW * 0.97).clamp(0.0, 100.0);
    const capsuleH  = 50.0;
    final left      = tabW * selectedIndex + (tabW - capsuleW) / 2;
    final top       = (barHeight - capsuleH) / 2;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 320),
      curve: const Cubic(0.22, 1, 0.36, 1),
      left: left,
      top:  top,
      child: Container(
        width:  capsuleW,
        height: capsuleH,
        decoration: BoxDecoration(
          color: accentGreen.withValues(alpha: 0.20),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: accentGreen.withValues(alpha: 0.55),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: accentGreen.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────
// Individual tab — Expanded fills equal slot, no fixed width
// ─────────────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final _TabSpec tab;
  final bool isSelected;
  final Color lightGreen;
  final VoidCallback onTap;


  const _NavItem({
    required this.tab,
    required this.isSelected,
    required this.lightGreen,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 64,
        child: Center(
  child: isSelected
      ? _SelectedContent(
          tab: tab,
          lightGreen: lightGreen,
        )
      : _UnselectedIcon(
          tab: tab,
          lightGreen: lightGreen,
        ),
)
      ),
    );
  }
}

class _SelectedContent extends StatelessWidget {
  final _TabSpec tab;
  final Color lightGreen;
  const _SelectedContent({required this.tab, required this.lightGreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(tab.selectedIcon, color: lightGreen, size: 20),
        const SizedBox(height: 3),
        Text(
          tab.label,
          style: TextStyle(
            color:         lightGreen,
            fontSize:      10,
            fontWeight:    FontWeight.w700,
            letterSpacing: 0.1,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}

class _UnselectedIcon extends StatelessWidget {
  final _TabSpec tab;
  final Color lightGreen;
  const _UnselectedIcon({required this.tab, required this.lightGreen});

  @override
  Widget build(BuildContext context) {
    return Icon(tab.icon, color: lightGreen.withValues(alpha: 0.55), size: 22);
  }
}