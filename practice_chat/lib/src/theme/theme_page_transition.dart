import 'package:flutter/material.dart';

const themePageTransition = PageTransitionsTheme(builders: {
  /// Android: <https://www.android.com/>
  TargetPlatform.android: AppPageTransitionBuilder(),

  /// Fuchsia: <https://fuchsia.dev/fuchsia-src/concepts>
  TargetPlatform.fuchsia: AppPageTransitionBuilder(),

  /// iOS: <https://www.apple.com/ios/>
  TargetPlatform.iOS: AppPageTransitionBuilder(),

  /// Linux: <https://www.linux.org>
  TargetPlatform.linux: AppPageTransitionBuilder(),

  /// macOS: <https://www.apple.com/macos>
  TargetPlatform.macOS: AppPageTransitionBuilder(),

  /// Windows: <https://www.windows.com>
  TargetPlatform.windows: AppPageTransitionBuilder(),
});

class AppPageTransitionBuilder extends PageTransitionsBuilder {
  const AppPageTransitionBuilder();
  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return _ZoomPageTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
    final textDirection = Directionality.of(context);
    return SlideTransition(
      position: Tween<Offset>(begin: Offset.zero, end: const Offset(0, 0.5))
          .animate(secondaryAnimation),
      textDirection: textDirection,
      transformHitTests: false,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0.5, 0), end: Offset.zero)
            .animate(animation),
        textDirection: textDirection,
        child: FadeTransition(
          opacity: Tween<double>(begin: 1, end: 0).animate(secondaryAnimation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
      ),
    );
  }
}

// Zooms and fades a new page in, zooming out the previous page. This transition
// is designed to match the Android 10 activity transition.
class _ZoomPageTransition extends StatelessWidget {
  /// Creates a [_ZoomPageTransition].
  ///
  /// The [animation] and [secondaryAnimation] argument are required and must
  /// not be null.
  const _ZoomPageTransition({
    required this.animation,
    required this.secondaryAnimation,
    Key? key,
    this.child,
  }) : super(key: key);

  // A curve sequence that is similar to the 'fastOutExtraSlowIn' curve used in
  // the native transition.
  static final List<TweenSequenceItem<double>>
      fastOutExtraSlowInTweenSequenceItems = <TweenSequenceItem<double>>[
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0, end: 0.4)
          .chain(CurveTween(curve: const Cubic(0.05, 0, 0.133333, 0.06))),
      weight: 0.166666,
    ),
    TweenSequenceItem<double>(
      tween: Tween<double>(begin: 0.4, end: 1)
          .chain(CurveTween(curve: const Cubic(0.208333, 0.82, 0.25, 1))),
      weight: 1.0 - 0.166666,
    ),
  ];
  static final TweenSequence<double> _scaleCurveSequence =
      TweenSequence<double>(fastOutExtraSlowInTweenSequenceItems);

  /// The animation that drives the [child]'s entrance and exit.
  ///
  /// See also:
  ///
  ///  * [TransitionRoute.animation], which is the value given to this property
  ///    when the [_ZoomPageTransition] is used as a page transition.
  final Animation<double> animation;

  /// The animation that transitions [child] when new content is pushed on top
  /// of it.
  ///
  /// See also:
  ///
  ///  * [TransitionRoute.secondaryAnimation], which is the value given to this
  ///    property when the [_ZoomPageTransition] is used as a page transition.
  final Animation<double> secondaryAnimation;

  /// The widget below this widget in the tree.
  ///
  /// This widget will transition in and out as driven by [animation] and
  /// [secondaryAnimation].
  final Widget? child;

  @override
  Widget build(BuildContext context) => DualTransitionBuilder(
        animation: animation,
        forwardBuilder: (
          context,
          animation,
          child,
        ) =>
            _ZoomEnterTransition(
          animation: animation,
          child: child,
        ),
        reverseBuilder: (
          context,
          animation,
          child,
        ) =>
            _ZoomExitTransition(
          animation: animation,
          reverse: true,
          child: child,
        ),
        child: DualTransitionBuilder(
          animation: ReverseAnimation(secondaryAnimation),
          forwardBuilder: (
            context,
            animation,
            child,
          ) =>
              _ZoomEnterTransition(
            animation: animation,
            reverse: true,
            child: child,
          ),
          reverseBuilder: (
            context,
            animation,
            child,
          ) =>
              _ZoomExitTransition(
            animation: animation,
            child: child,
          ),
          child: child,
        ),
      );
}

class _ZoomEnterTransition extends StatelessWidget {
  const _ZoomEnterTransition({
    required this.animation,
    Key? key,
    this.reverse = false,
    this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Widget? child;
  final bool reverse;

  static final Animatable<double> _fadeInTransition = Tween<double>(
    begin: 0,
    end: 1,
  ).chain(CurveTween(curve: const Interval(0.125, 0.250)));

  static final Animatable<double> _scaleDownTransition = Tween<double>(
    begin: 1.40,
    end: 1,
  ).chain(_ZoomPageTransition._scaleCurveSequence);

  static final Animatable<double> _scaleUpTransition = Tween<double>(
    begin: 0.35,
    end: 1,
  ).chain(_ZoomPageTransition._scaleCurveSequence);

  static final Animatable<double?> _scrimOpacityTween = Tween<double?>(
    begin: 0,
    end: 0.10,
  ).chain(CurveTween(curve: const Interval(0.2075, 0.4175)));

  @override
  Widget build(BuildContext context) {
    var opacity = 0.0;
    // The transition's scrim opacity only increases on the forward transition. In the reverse
    // transition, the opacity should always be 0.0.
    //
    // Therefore, we need to only apply the scrim opacity animation when the transition
    // is running forwards.
    //
    // The reason that we check that the animation's status is not `completed` instead
    // of checking that it is `forward` is that this allows the interrupted reversal of the
    // forward transition to smoothly fade the scrim away. This prevents a disjointed
    // removal of the scrim.
    if (!reverse && animation.status != AnimationStatus.completed) {
      opacity = _scrimOpacityTween.evaluate(animation)!;
    }

    final fadeTransition = _fadeInTransition.animate(animation);

    final scaleTransition =
        (reverse ? _scaleDownTransition : _scaleUpTransition)
            .animate(animation);

    return FadeTransition(
      opacity: fadeTransition,
      child: ScaleTransition(
        scale: scaleTransition,
        child: child,
      ),
    );
  }
}

class _ZoomExitTransition extends StatelessWidget {
  const _ZoomExitTransition({
    required this.animation,
    Key? key,
    this.reverse = false,
    this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final bool reverse;
  final Widget? child;

  static final Animatable<double> _fadeOutTransition = Tween<double>(
    begin: 1,
    end: 0,
  ).chain(CurveTween(curve: const Interval(0.0825, 0.2075)));

  static final Animatable<double> _scaleUpTransition = Tween<double>(
    begin: 1,
    end: 1.35,
  ).chain(_ZoomPageTransition._scaleCurveSequence);

  static final Animatable<double> _scaleDownTransition = Tween<double>(
    begin: 1,
    end: 0.60,
  ).chain(_ZoomPageTransition._scaleCurveSequence);

  @override
  Widget build(BuildContext context) {
    final fadeTransition = _fadeOutTransition.animate(animation);
    final scaleTransition =
        (reverse ? _scaleDownTransition : _scaleUpTransition)
            .animate(animation);

    return FadeTransition(
      opacity: fadeTransition,
      child: ScaleTransition(
        scale: scaleTransition,
        child: child,
      ),
    );
  }
}
