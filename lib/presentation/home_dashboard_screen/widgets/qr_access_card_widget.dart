import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_theme.dart';

class QrAccessCardWidget extends StatefulWidget {
  final Map<String, dynamic> memberData;

  const QrAccessCardWidget({required this.memberData, super.key});

  @override
  State<QrAccessCardWidget> createState() => _QrAccessCardWidgetState();
}

class _QrAccessCardWidgetState extends State<QrAccessCardWidget> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(20),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer.withAlpha(102),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Accès Rapide',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                        ),
                      ),
                      Text(
                        'Présentez ce QR code à l\'entrée',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.successContainer,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.success.withAlpha(77),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: AppTheme.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Valide',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // QR Code area
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppTheme.primary.withAlpha(31),
        blurRadius: 20,
        offset: const Offset(0, 6),
        spreadRadius: 2,
      ),
    ],
  ),
  child: CustomPaint(
    size: const Size(160, 160),
    painter: _QrCodePainter(
      memberId: widget.memberData['memberId'] as String,
    ),
  ),
),
                const SizedBox(height: 14),
                Text(
                  widget.memberData['memberId'] as String,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurfaceVariant,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Expire le ${widget.memberData['expirationDate']}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => context.go(AppRoutes.memberCardScreen),
                    icon: const Icon(Icons.badge_rounded, size: 18),
                    label: Text(
                      'Voir ma carte complète',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QrCodePainter extends CustomPainter {
  final String memberId;

  _QrCodePainter({required this.memberId});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A1A2E)
      ..style = PaintingStyle.fill;

    final bgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final cellSize = size.width / 21;

    // Simplified QR code pattern — finder patterns + data modules
    final pattern = _generatePattern();

    for (int row = 0; row < 21; row++) {
      for (int col = 0; col < 21; col++) {
        if (pattern[row][col]) {
          final rect = Rect.fromLTWH(
            col * cellSize + 0.5,
            row * cellSize + 0.5,
            cellSize - 1,
            cellSize - 1,
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, const Radius.circular(1)),
            paint,
          );
        }
      }
    }

    // Draw finder pattern corners with rounded outer border
    _drawFinderPattern(canvas, paint, 0, 0, cellSize);
    _drawFinderPattern(canvas, paint, 14, 0, cellSize);
    _drawFinderPattern(canvas, paint, 0, 14, cellSize);

    // ClubMaster logo in center
    final logoPaint = Paint()
      ..color = AppTheme.primary
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final logoSize = cellSize * 3;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: logoSize + 6,
          height: logoSize + 6,
        ),
        const Radius.circular(4),
      ),
      Paint()..color = Colors.white,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: logoSize,
          height: logoSize,
        ),
        const Radius.circular(3),
      ),
      logoPaint,
    );
  }

  void _drawFinderPattern(
    Canvas canvas,
    Paint paint,
    int startRow,
    int startCol,
    double cellSize,
  ) {
    // Outer 7x7
    for (int r = 0; r < 7; r++) {
      for (int c = 0; c < 7; c++) {
        if (r == 0 || r == 6 || c == 0 || c == 6) {
          final rect = Rect.fromLTWH(
            (startCol + c) * cellSize + 0.5,
            (startRow + r) * cellSize + 0.5,
            cellSize - 1,
            cellSize - 1,
          );
          canvas.drawRRect(
            RRect.fromRectAndRadius(rect, const Radius.circular(1)),
            paint,
          );
        }
      }
    }
    // Inner 3x3
    for (int r = 2; r <= 4; r++) {
      for (int c = 2; c <= 4; c++) {
        final rect = Rect.fromLTWH(
          (startCol + c) * cellSize + 0.5,
          (startRow + r) * cellSize + 0.5,
          cellSize - 1,
          cellSize - 1,
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(1)),
          paint,
        );
      }
    }
  }

  List<List<bool>> _generatePattern() {
    // 21x21 grid with realistic QR-like data pattern
    final grid = List.generate(21, (_) => List.generate(21, (_) => false));

    // Seed from memberId for consistent pattern
    final seed = memberId.codeUnits.fold(0, (a, b) => a + b);
    final rng = seed;

    for (int r = 0; r < 21; r++) {
      for (int c = 0; c < 21; c++) {
        // Skip finder pattern areas
        if ((r < 8 && c < 8) || (r < 8 && c >= 13) || (r >= 13 && c < 8)) {
          continue;
        }
        // Skip timing patterns
        if (r == 6 || c == 6) continue;
        grid[r][c] = ((r * 31 + c * 17 + rng) % 3) != 0;
      }
    }

    // Timing patterns
    for (int i = 8; i < 13; i++) {
      grid[6][i] = i % 2 == 0;
      grid[i][6] = i % 2 == 0;
    }

    return grid;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
