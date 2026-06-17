import '../../../core/app_export.dart';

class LoginHeaderWidget extends StatelessWidget {
  final Animation<double> logoScale;
  final Animation<double> logoOpacity;
  final Animation<Offset> titleSlide;
  final Animation<double> titleOpacity;
  final double height;

  const LoginHeaderWidget({
    required this.logoScale,
    required this.logoOpacity,
    required this.titleSlide,
    required this.titleOpacity,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF003B2A),
            Color(0xFF0B5D3B),
            Color(0xFF137A4F),
            Color(0xFF69C12F),
          ],
          stops: [0.0, 0.35, 0.65, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Water wave decoration
          Positioned(
            bottom: -20,
            left: -30,
            right: -30,
            child: CustomPaint(
              size: Size(double.infinity, 80),
              painter: _WavePainter(),
            ),
          ),
          // Bubble decorations
          Positioned(
            top: 20,
            right: 40,
            child: _BubbleDecoration(size: 8, opacity: 0.2),
          ),
          Positioned(
            top: 60,
            right: 80,
            child: _BubbleDecoration(size: 5, opacity: 0.15),
          ),
          Positioned(
            top: 40,
            left: 30,
            child: _BubbleDecoration(size: 6, opacity: 0.15),
          ),
          Positioned(
            bottom: 60,
            left: 50,
            child: _BubbleDecoration(size: 10, opacity: 0.12),
          ),
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                FadeTransition(
                  opacity: logoOpacity,
                  child: ScaleTransition(
                    scale: logoScale,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(38),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: CustomImageWidget(
                          imageUrl:
                              'assets/images/club-master-logo-1781003224586.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                          semanticLabel:
                              'ClubMaster swimming pool club logo with athlete silhouettes',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                FadeTransition(
                  opacity: titleOpacity,
                  child: SlideTransition(
                    position: titleSlide,
                    child: Column(
                      children: [
                        Text(
                          'ClubMaster',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Portail Adhérent',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withAlpha(217),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
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

class _BubbleDecoration extends StatelessWidget {
  final double size;
  final double opacity;

  const _BubbleDecoration({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(opacity),
          width: 1.5,
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha(15)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 40);
    path.quadraticBezierTo(size.width * 0.25, 10, size.width * 0.5, 40);
    path.quadraticBezierTo(size.width * 0.75, 70, size.width, 40);
    path.lineTo(size.width, 80);
    path.lineTo(0, 80);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
