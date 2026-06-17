import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool showBack;
  final Color? backgroundColor;
  final double elevation;

  const AppBarWidget({
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.showBack = false,
    this.backgroundColor,
    this.elevation = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      elevation: elevation,
      scrolledUnderElevation: 1,
      shadowColor: theme.colorScheme.shadow,
      centerTitle: centerTitle,
      leading: showBack
          ? IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: theme.colorScheme.primary,
              ),
            )
          : leading,
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.onSurface,
          letterSpacing: -0.2,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
