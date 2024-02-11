// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';

// class FadeAnimation extends StatelessWidget {
//   final double delay;
//   final Widget child;

//   FadeAnimation(this.delay, this.child);

//   @override
//   Widget build(BuildContext context) {
//     final tween = MultiTrackTween([
//       Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
//       Track("translateY").add(
//         Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
//         curve: Curves.easeOut)
//     ]);

//     return ControlledAnimation(
//       delay: Duration(milliseconds: (500 * delay).round()),
//       duration: tween.duration,
//       tween: tween,
//       child: child,
//       builderWithChild: (context, child, animation) => Opacity(
//         opacity: (animation as Map)["opacity"],
//         child: Transform.translate(
//           offset: Offset(0, animation["translateY"]),
//           child: child
//         ),
//       ),
//     );
//   }
// }
// class FadeAnimation extends StatefulWidget {
//   final double delay;
//   final Widget child;

//   FadeAnimation(this.delay, this.child);

//   @override
//   _FadeAnimationState createState() => _FadeAnimationState();
// }

// class _FadeAnimationState extends State<FadeAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _opacityAnimation;
//   late Animation<double> _translateYAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(milliseconds: 500),
//       vsync: this,
//     );

//     _opacityAnimation =
//         Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//     _translateYAnimation = Tween<double>(begin: -30.0, end: 0.0).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeOut),
//     );

//     Future.delayed(Duration(milliseconds: (500 * widget.delay).round()), () {
//       if (mounted) _controller.forward();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) => Opacity(
//         opacity: _opacityAnimation.value,
//         child: Transform.translate(
//           offset: Offset(0, _translateYAnimation.value),
//           child: widget.child,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

//class MultiTrackTween {
//}
