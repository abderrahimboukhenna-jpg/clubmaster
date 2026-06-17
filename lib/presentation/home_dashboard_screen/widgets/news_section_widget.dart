import '../../../core/app_export.dart';

class NewsSectionWidget extends StatelessWidget {
  const NewsSectionWidget({super.key});

  // TODO: Replace with [Riverpod/Bloc] for production — fetch from CMS/API
  static final List<Map<String, dynamic>> _newsMaps = [
    {
      'id': '1',
      'title': 'Nouveaux horaires d\'été',
      'summary':
          'La piscine sera ouverte de 7h à 21h durant tout le mois de juillet. Profitez des créneaux matinaux pour nager avant la chaleur.',
      'category': 'Horaires',
      'categoryColor': 0xFF1565C0,
      'date': '8 Juin 2026',
      'imageUrl':
          'https://images.pexels.com/photos/261185/pexels-photo-261185.jpeg?auto=compress&cs=tinysrgb&w=600',
      'semanticLabel':
          'Vue aérienne d\'une piscine olympique avec couloirs de nage bleus',
      'isImportant': true,
    },
    {
      'id': '2',
      'title': 'Cours de natation adultes',
      'summary':
          'Inscription ouverte pour les cours de natation du mois de juillet. Places limitées à 12 participants par groupe.',
      'category': 'Cours',
      'categoryColor': 0xFF2E7D32,
      'date': '5 Juin 2026',
      'imageUrl':
          'https://images.pixabay.com/photo/2016/11/23/15/48/audience-1853662_1280.jpg',
      'semanticLabel':
          'Nageurs adultes s\'entraînant dans une piscine avec un entraîneur au bord',
      'isImportant': false,
    },
    {
      'id': '3',
      'title': 'Fermeture pour maintenance',
      'summary':
          'La piscine sera fermée le 20 juin pour entretien annuel du système de filtration. Reprise le 21 juin.',
      'category': 'Avis',
      'categoryColor': 0xFFF57F17,
      'date': '3 Juin 2026',
      'imageUrl':
          'https://images.unsplash.com/photo-1675789245441-8c31d6b85f67',
      'semanticLabel':
          'Piscine vide en cours de maintenance avec équipement de nettoyage',
      'isImportant': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Actualités du Club',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
                letterSpacing: -0.2,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
              ),
              child: Text(
                'Voir tout',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ..._newsMaps.asMap().entries.map((entry) {
          final i = entry.key;
          final item = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: i < _newsMaps.length - 1 ? 10 : 0),
            child: _NewsCard(item: item, theme: theme),
          );
        }),
      ],
    );
  }
}

class _NewsCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final ThemeData theme;

  const _NewsCard({required this.item, required this.theme});

  @override
  Widget build(BuildContext context) {
    final categoryColor = Color(item['categoryColor'] as int);
    final isImportant = item['isImportant'] as bool;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(16),
      splashColor: AppTheme.primary.withAlpha(15),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isImportant
                ? categoryColor.withAlpha(64)
                : theme.colorScheme.outlineVariant,
            width: isImportant ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withAlpha(13),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(15),
              ),
              child: CustomImageWidget(
                imageUrl: item['imageUrl'] as String,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                semanticLabel: item['semanticLabel'] as String,
              ),
            ),
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: categoryColor.withAlpha(26),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            item['category'] as String,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: categoryColor,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ),
                        if (isImportant) ...[
                          const SizedBox(width: 5),
                          Icon(
                            Icons.priority_high_rounded,
                            size: 12,
                            color: AppTheme.warning,
                          ),
                        ],
                        const Spacer(),
                        Text(
                          item['date'] as String,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 10,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item['title'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                        letterSpacing: -0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item['summary'] as String,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
