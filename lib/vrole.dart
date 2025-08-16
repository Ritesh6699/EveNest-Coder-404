import 'package:flutter/material.dart';

class VrolePage extends StatelessWidget {
  const VrolePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E0E),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 2,
        centerTitle: true,
        title: const Text(
          'VENDORS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.6,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double screenWidth = constraints.maxWidth;
              final int crossAxisCount = screenWidth > 900
                  ? 3
                  : screenWidth > 600
                  ? 3
                  : 2;

              final Color baseShade = const Color(0xFFD4AF37);
              final Color hoverShade = const Color(0xFFF0D680);

              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                children: <Widget>[
                  OptionCard(
                    icon: Icons.home_work,
                    label: 'Community Hall',
                    baseColor: baseShade,
                    hoverColor: hoverShade,
                    onTap: () {
                      // Add navigation or action here
                    },
                  ),
                  OptionCard(
                    icon: Icons.event,
                    label: 'Event Manager',
                    baseColor: baseShade,
                    hoverColor: hoverShade,
                    onTap: () {
                      // Add navigation or action here
                    },
                  ),
                  OptionCard(
                    icon: Icons.person,
                    label: 'Pandit',
                    baseColor: baseShade,
                    hoverColor: hoverShade,
                    onTap: () {
                      // Add navigation or action here
                    },
                  ),
                  OptionCard(
                    icon: Icons.celebration,
                    label: 'Decorator',
                    baseColor: baseShade,
                    hoverColor: hoverShade,
                    onTap: () {
                      // Add navigation or action here
                    },
                  ),
                  OptionCard(
                    icon: Icons.restaurant,
                    label: 'Catering',
                    baseColor: baseShade,
                    hoverColor: hoverShade,
                    onTap: () {
                      // Add navigation or action here
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class OptionCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color baseColor;
  final Color hoverColor;
  final VoidCallback onTap;

  const OptionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.baseColor,
    required this.hoverColor,
    required this.onTap,
  });

  @override
  State<OptionCard> createState() => _OptionCardState();
}

class _OptionCardState extends State<OptionCard> {
  bool _hovering = false;

  void _setHover(bool h) {
    if (mounted) setState(() => _hovering = h);
  }

  @override
  Widget build(BuildContext context) {
    final double lift = _hovering ? -10.0 : 0.0;
    final double scale = _hovering ? 1.02 : 1.0;
    final Color bg = Color.lerp(
      widget.baseColor,
      widget.hoverColor,
      _hovering ? 1.0 : 0.0,
    )!;
    final double blur = _hovering ? 18.0 : 8.0;
    final Offset offset = _hovering ? const Offset(0, 10) : const Offset(0, 6);

    return MouseRegion(
      onEnter: (event) => _setHover(true),
      onExit: (event) => _setHover(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.identity()
          ..translate(0.0, lift)
          ..scale(scale),
        decoration: BoxDecoration(
          color: bg.withOpacity(0.95),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(color: Colors.black54, blurRadius: blur, offset: offset),
          ],
          border: Border.all(color: Colors.black38, width: 1),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 18.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, size: 48, color: Colors.black87),
                  const SizedBox(height: 12),
                  Text(
                    widget.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
