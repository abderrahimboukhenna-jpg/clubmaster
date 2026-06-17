import '../../../core/app_export.dart';

class MemberHeroCardWidget extends StatelessWidget {
  final Map<String, dynamic> memberData;

  const MemberHeroCardWidget({required this.memberData, super.key});

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF003B2A), Color(0xFF0B5D3B), Color(0xFF69C12F)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(89),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Wave decoration
          Positioned(
            right: -20,
            top: -20,
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
            right: 20,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(10),
              ),
            ),
          ),
          // Card content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    // Member photo
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withAlpha(77),
                          width: 2.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(51),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: CustomImageWidget(
                          imageUrl: memberData['photoUrl'] as String,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          semanticLabel:
                              'Photo de profil de ${memberData['fullName']}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Name and type
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            memberData['fullName'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            memberData['membershipType'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withAlpha(191),
                            ),
                          ),
                          const SizedBox(height: 6),
                          StatusBadgeWidget(status: MembershipStatus.active),
                        ],
                      ),
                    ),
                    // Pool icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(31),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.pool_rounded,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Divider
                Container(height: 1, color: Colors.white.withAlpha(31)),
                const SizedBox(height: 16),
                // Next payment info
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white.withAlpha(179),
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Prochain paiement: ',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withAlpha(179),
                      ),
                    ),
                    Text(
                      memberData['nextPaymentDate'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'N° ${memberData['memberId']}',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withAlpha(153),
                        letterSpacing: 0.3,
                      ),
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
