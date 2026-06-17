import '../../../core/app_export.dart';

class DigitalCardWidget extends StatelessWidget {
  final Map<String, dynamic> memberData;

  const DigitalCardWidget({required this.memberData, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF022C22),
            Color(0xFF0B5D3B),
            Color(0xFF1E7A3A),
            Color(0xFF8BC34A),
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(102),
            blurRadius: 28,
            offset: const Offset(0, 12),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: AppTheme.accent.withAlpha(38),
            blurRadius: 40,
            offset: const Offset(0, 20),
            spreadRadius: -8,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Water wave decorations
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(13),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -50,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(10),
              ),
            ),
          ),
          Positioned(
            left: -20,
            bottom: 10,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(10),
              ),
            ),
          ),
          // Card chip decoration
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withAlpha(51),
                    Colors.white.withAlpha(20),
                  ],
                ),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.white.withAlpha(38), width: 1),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Logo + Club name
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(38),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: 'member-avatar',
                        child: ClipOval(
                          child: CustomImageWidget(
                            imageUrl: 'assets/images/club-master-logo-1781003224586.png',
                            width: 36,
                            height: 36,
                            fit: BoxFit.contain,
                            semanticLabel: 'ClubMaster logo',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CLUBMASTER',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 2.0,
                          ),
                        ),
                        Text(
                          memberData['membershipType'] as String,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withAlpha(191),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    StatusBadgeWidget(
                      status: MembershipStatus.active,
                      compact: true,
                    ),
                  ],
                ),
                const Spacer(),

                // Bottom row: Photo + Name + ID
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Member photo
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withAlpha(102),
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: CustomImageWidget(
                          imageUrl: memberData['photoUrl'] as String,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          semanticLabel:
                              'Photo de profil de ${memberData['fullName']}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            memberData['fullName'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            memberData['memberId'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withAlpha(179),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Expiration
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'EXPIRE',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withAlpha(153),
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          '07/2026',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
