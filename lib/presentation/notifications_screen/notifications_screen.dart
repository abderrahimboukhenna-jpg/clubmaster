import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': 1,
      'icon': Icons.notifications_active_rounded,
      'color': const Color(0xFFF57F17),
      'title': 'Abonnement bientôt expiré',
      'body': 'Votre abonnement expire dans 45 jours. Pensez à le renouveler.',
      'time': 'Il y a 2h',
      'isRead': false,
      'type': 'reminder',
    },
    {
      'id': 2,
      'icon': Icons.payment_rounded,
      'color': const Color(0xFF1565C0),
      'title': 'Rappel de paiement',
      'body': 'Prochain paiement prévu le 15/07/2025. Montant: 3 500 DA.',
      'time': 'Il y a 5h',
      'isRead': false,
      'type': 'payment',
    },
    {
      'id': 3,
      'icon': Icons.campaign_rounded,
      'color': const Color(0xFF4CAF50),
      'title': 'Fermeture exceptionnelle',
      'body':
          'La piscine sera fermée le 14 juillet pour travaux de maintenance.',
      'time': 'Hier',
      'isRead': true,
      'type': 'announcement',
    },
    {
      'id': 4,
      'icon': Icons.pool_rounded,
      'color': const Color(0xFF29B6F6),
      'title': 'Rappel de séance',
      'body': 'Vous avez une séance de natation demain à 18h00.',
      'time': 'Hier',
      'isRead': true,
      'type': 'session',
    },
    {
      'id': 5,
      'icon': Icons.star_rounded,
      'color': const Color(0xFF9C27B0),
      'title': 'Nouveau cours disponible',
      'body': 'Un nouveau cours d\'aquagym est disponible le samedi matin.',
      'time': '2 jours',
      'isRead': true,
      'type': 'announcement',
    },
    {
      'id': 6,
      'icon': Icons.info_rounded,
      'color': const Color(0xFF1976D2),
      'title': 'Mise à jour des horaires',
      'body': 'Les horaires d\'été sont en vigueur du 1er juillet au 31 août.',
      'time': '3 jours',
      'isRead': true,
      'type': 'info',
    },
  ];

  void _markAllRead() {
    setState(() {
      for (var n in _notifications) {
        n['isRead'] = true;
      }
    });
  }

  void _markRead(int id) {
    setState(() {
      final idx = _notifications.indexWhere((n) => n['id'] == id);
      if (idx != -1) _notifications[idx]['isRead'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final unreadCount = _notifications
        .where((n) => !(n['isRead'] as bool))
        .length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Notifications',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            if (unreadCount > 0) ...[
              SizedBox(width: 2.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF69C12F),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  '$unreadCount',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: Text(
                'Tout lire',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10.sp,
                  color: const Color(0xFF69C12F),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    size: 15.w,
                    color: theme.colorScheme.onSurface.withAlpha(77),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Aucune notification',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      color: theme.colorScheme.onSurface.withAlpha(128),
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(4.w),
              itemCount: _notifications.length,
              separatorBuilder: (_, __) => SizedBox(height: 1.5.h),
              itemBuilder: (context, index) {
                final n = _notifications[index];
                final isRead = n['isRead'] as bool;
                return GestureDetector(
                  onTap: () => _markRead(n['id'] as int),
                  child: Container(
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: isRead
                          ? theme.colorScheme.surface
                          : (isDark
                                ? const Color(0xFF69C12F).withAlpha(26)
                                : const Color(0xFFDFF5E6)),
                      borderRadius: BorderRadius.circular(12.0),
                      border: isRead
                          ? null
                          : Border.all(
                              color: const Color(0xFF69C12F).withAlpha(77),
                              width: 1,
                            ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(isDark ? 26 : 10),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 11.w,
                          height: 11.w,
                          decoration: BoxDecoration(
                            color: (n['color'] as Color).withAlpha(26),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            n['icon'] as IconData,
                            color: n['color'] as Color,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      n['title'] as String,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11.sp,
                                        fontWeight: isRead
                                            ? FontWeight.w600
                                            : FontWeight.w700,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (!isRead)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF69C12F),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                n['body'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 9.sp,
                                  color: theme.colorScheme.onSurface.withAlpha(
                                    153,
                                  ),
                                  height: 1.4,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                n['time'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 9.sp,
                                  color: theme.colorScheme.onSurface.withAlpha(
                                    102,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
