import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _selectedDayIndex = 1;

  final List<String> _days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  final List<int> _dates = [9, 10, 11, 12, 13, 14, 15];

  final List<Map<String, dynamic>> _sessions = [
    {
      'time': '06:00 - 08:00',
      'name': 'Natation Matinale',
      'available': 8,
      'total': 20,
      'type': 'Libre',
      'color': const Color(0xFF29B6F6),
    },
    {
      'time': '09:00 - 11:00',
      'name': 'Aquagym',
      'available': 3,
      'total': 15,
      'type': 'Cours',
      'color': const Color(0xFF1976D2),
    },
    {
      'time': '12:00 - 14:00',
      'name': 'Natation Midi',
      'available': 12,
      'total': 20,
      'type': 'Libre',
      'color': const Color(0xFF29B6F6),
    },
    {
      'time': '15:00 - 17:00',
      'name': 'Natation Enfants',
      'available': 5,
      'total': 12,
      'type': 'Cours',
      'color': const Color(0xFF4CAF50),
    },
    {
      'time': '18:00 - 20:00',
      'name': 'Natation Soirée',
      'available': 15,
      'total': 20,
      'type': 'Libre',
      'color': const Color(0xFF29B6F6),
    },
    {
      'time': '20:00 - 21:30',
      'name': 'Natation Avancée',
      'available': 0,
      'total': 10,
      'type': 'Cours',
      'color': const Color(0xFFE53935),
    },
  ];

  final List<Map<String, dynamic>> _upcomingSessions = [
    {
      'day': 'Demain',
      'time': '18:00',
      'name': 'Natation Soirée',
      'date': 'Mar 10 Juin',
    },
    {
      'day': 'Jeudi',
      'time': '06:00',
      'name': 'Natation Matinale',
      'date': 'Jeu 12 Juin',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Planning',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Week Calendar
            Container(
              color: theme.colorScheme.surface,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Juin 2025',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      final isSelected = index == _selectedDayIndex;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedDayIndex = index),
                        child: Container(
                          width: 11.w,
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF0B5D3B)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _days[index],
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : theme.colorScheme.onSurface.withAlpha(
                                          153,
                                        ),
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                '${_dates[index]}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.h),

            // Sessions List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Séances disponibles',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  ..._sessions.map((session) {
                    final isFull = session['available'] == 0;
                    return Container(
                      margin: EdgeInsets.only(bottom: 1.5.h),
                      padding: EdgeInsets.all(3.w),
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
                      child: Row(
                        children: [
                          Container(
                            width: 4,
                            height: 7.h,
                            decoration: BoxDecoration(
                              color: isFull
                                  ? const Color(0xFFE53935)
                                  : session['color'] as Color,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  session['name'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 0.3.h),
                                Text(
                                  session['time'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10.sp,
                                    color: theme.colorScheme.onSurface
                                        .withAlpha(153),
                                  ),
                                ),
                                SizedBox(height: 0.3.h),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 0.3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: (session['color'] as Color)
                                        .withAlpha(26),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Text(
                                    session['type'] as String,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w600,
                                      color: session['color'] as Color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                isFull
                                    ? 'Complet'
                                    : '${session['available']} places',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                  color: isFull
                                      ? const Color(0xFFE53935)
                                      : const Color(0xFF4CAF50),
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                '/ ${session['total']}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 9.sp,
                                  color: theme.colorScheme.onSurface.withAlpha(
                                    102,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 2.h),

                  // Upcoming Sessions
                  Text(
                    'Mes prochaines séances',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  ..._upcomingSessions.map((session) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 1.5.h),
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0B5D3B), Color(0xFF69C12F)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(51),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Icon(
                              Icons.pool_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  session['name'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  session['date'] as String,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 9.sp,
                                    color: Colors.white.withAlpha(204),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                session['day'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 9.sp,
                                  color: Colors.white.withAlpha(179),
                                ),
                              ),
                              Text(
                                session['time'] as String,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
