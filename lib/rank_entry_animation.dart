import 'package:flutter/material.dart';

class RankEntryAnimationWidget extends StatefulWidget {
  final Widget child;
  const RankEntryAnimationWidget({Key? key, required this.child}) : super(key: key);

  @override
  State<RankEntryAnimationWidget> createState() => _RankEntryAnimationWidgetState();
}

class _RankEntryAnimationWidgetState extends State<RankEntryAnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconOpacity;
  late Animation<double> _iconScale;
  late Animation<double> _auraSpread;
  late Animation<double> _contentOpacity;

  bool _animationFinished = false;
  static const Color primaryPurple = Color(0xFF9D4EDD);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));

    _iconOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeIn)),
    );

    _iconScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.outBack)),
    );

    _auraSpread = Tween<double>(begin: 5.0, end: 35.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.7, curve: Curves.easeInOut)),
    );

    _contentOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward().then((_) {
      setState(() {
        _animationFinished = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            Container(color: Colors.black),
            if (!_animationFinished)
              Center(
                child: Opacity(
                  opacity: _iconOpacity.value,
                  child: Transform.scale(
                    scale: _iconScale.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF050508),
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryPurple, width: 3),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.95), blurRadius: 30, spreadRadius: 10),
                          BoxShadow(color: primaryPurple.withOpacity(0.8), blurRadius: _auraSpread.value * 1.5, spreadRadius: _auraSpread.value),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.emoji_events, color: primaryPurple, size: 64),
                      ),
                    ),
                  ),
                ),
              ),
            Opacity(opacity: _contentOpacity.value, child: widget.child),
          ],
        );
      },
    );
  }
}
