import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

class CardQrWidget extends StatefulWidget {
  final Map<String, dynamic> memberData;

  const CardQrWidget({required this.memberData, super.key});

  @override
  State<CardQrWidget> createState() => _CardQrWidgetState();
}

class _CardQrWidgetState extends State<CardQrWidget> {


  

  

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(20),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: theme.colorScheme.outlineVariant, width: 1),
      ),
      child: Column(
        children: [
          // Section header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.qr_code_2_rounded, size: 18, color: AppTheme.primary),
              const SizedBox(width: 8),
              Text(
                'Code QR d\'accès',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Présentez ce code à l\'entrée de la piscine',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // QR with pulse ring
          Stack(
            alignment: Alignment.center,
            children: [
              // QR code
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withAlpha(38),
                      blurRadius: 8,
                      offset: const Offset(0, 8),
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: CustomPaint(
                  size: const Size(180, 180),
                  painter: _QrCodePainter(
                    memberId: widget.memberData['memberId'] as String,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Member ID
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.primaryContainer.withAlpha(102),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              widget.memberData['memberId'] as String,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppTheme.primary,
                letterSpacing: 2.0,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Valid until
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_outlined, size: 14, color: AppTheme.success),
              const SizedBox(width: 5),
              Text(
                'Valide jusqu\'au ${widget.memberData['expirationDate']}',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.success,
                ),
              ),
            ],
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
            RRect.fromRectAndRadius(rect, const Radius.circular(1.2)),
            paint,
          );
        }
      }
    }

    _drawFinderPattern(canvas, paint, 0, 0, cellSize);
    _drawFinderPattern(canvas, paint, 14, 0, cellSize);
    _drawFinderPattern(canvas, paint, 0, 14, cellSize);

    // Center logo placeholder
    final logoPaint = Paint()
      ..color = AppTheme.primary
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final logoSize = cellSize * 3.2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(centerX, centerY),
          width: logoSize + 8,
          height: logoSize + 8,
        ),
        const Radius.circular(5),
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
        const Radius.circular(4),
      ),
      logoPaint,
    );

    // CM initials in center
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'CM',
        style: TextStyle(
          color: Colors.white,
          fontSize: cellSize * 1.2,
          fontWeight: FontWeight.w900,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(centerX - textPainter.width / 2, centerY - textPainter.height / 2),
    );
  }

  void _drawFinderPattern(
    Canvas canvas,
    Paint paint,
    int startRow,
    int startCol,
    double cellSize,
  ) {
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
    final grid = List.generate(21, (_) => List.generate(21, (_) => false));
    final seed = memberId.codeUnits.fold(0, (a, b) => a + b);

    for (int r = 0; r < 21; r++) {
      for (int c = 0; c < 21; c++) {
        if ((r < 8 && c < 8) || (r < 8 && c >= 13) || (r >= 13 && c < 8)) {
          continue;
        }
        if (r == 6 || c == 6) continue;
        grid[r][c] = ((r * 31 + c * 17 + seed) % 3) != 0;
      }
    }

    for (int i = 8; i < 13; i++) {
      grid[6][i] = i % 2 == 0;
      grid[i][6] = i % 2 == 0;
    }

    return grid;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
