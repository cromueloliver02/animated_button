import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String label;
  final Color color;

  const AnimatedButton({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  Color _darkenColor(Color color, [double amount = 0.3]) {
    assert(amount >= 0 && amount <= 1);

    final HSLColor hsl = HSLColor.fromColor(color);
    final HSLColor hslDark =
        hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  void _animationStatusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _controller.reverse();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _animation = _controller.drive(CurveTween(curve: Curves.easeInOut));
    _animation.addStatusListener(_animationStatusListener);
  }

  @override
  void dispose() {
    _animation.removeStatusListener(_animationStatusListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, child) => Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 75,
            width: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _darkenColor(widget.color),
              borderRadius: BorderRadius.circular(70),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 10 + _animation.value * -10),
                  blurRadius: 10,
                ),
              ],
            ),
          ),
          Positioned(
            top: -10 + (_animation.value * 10),
            child: GestureDetector(
              onTap: () => _controller.forward(),
              child: Container(
                height: 75,
                width: 300,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(70),
                ),
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
