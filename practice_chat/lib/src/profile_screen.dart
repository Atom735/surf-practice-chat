import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import 'home_screen.dart';

class ProfileSettingsTitle extends StatelessWidget {
  const ProfileSettingsTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styleTitle = theme.typography.englishLike.titleMedium!
        .copyWith(color: theme.colorScheme.onBackground.withOpacity(0.5));
    final styleUserName = theme.typography.englishLike.titleLarge!
        .copyWith(color: theme.colorScheme.onBackground);
    return Row(
      children: [
        const SizedBox(width: 16),
        const BackButton(),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Profile settings',
              style: styleUserName,
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const IconButton(onPressed: kVoid, icon: Icon(Icons.search)),
        const SizedBox(width: 16),
      ],
    );
  }
}

class AvatarPainter extends CustomPainter {
  AvatarPainter(this.bg, [this.loading]);

  final ui.Image bg;
  final AnimationController? loading;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path.combine(
      PathOperation.difference,
      Path()
        ..addOval(
          Rect.fromCircle(
            center: size.center(Offset.zero),
            radius: size.height / 2,
          ),
        ),
      Path()
        ..addOval(
          Rect.fromCircle(
            center: size.center(Offset.zero),
            radius: size.height / 2 - 5,
          ),
        ),
    );
    if (loading != null) {
      for (var i = 0; i < 24; i++) {
        final radians = (loading!.value + (i / 24)) * pi * 2;
        path = Path.combine(
          PathOperation.difference,
          path,
          Path()
            ..addOval(
              Rect.fromCircle(
                center: size.center(Offset.zero).translate(
                      cos(radians) * size.height / 2,
                      sin(radians) * size.height / 2,
                    ),
                radius: size.height / 36,
              ),
            ),
        );
      }
    }
    canvas
      ..save()
      ..clipPath(path)
      ..translate((size.width - size.height) / 2, 0)
      ..scale(size.height / bg.width, size.height / bg.height)
      ..drawImage(bg, Offset.zero,
          Paint()..imageFilter = ui.ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5))
      ..restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AvatarAnimated extends StatefulWidget {
  const AvatarAnimated({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<AvatarAnimated> createState() => _AvatarAnimatedState();
}

class _AvatarAnimatedState extends State<AvatarAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  ui.Image? bg;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
      animationBehavior: AnimationBehavior.preserve,
    )..repeat();
    const AssetImage('assets/images/bg 2.png')
        .resolve(ImageConfiguration.empty)
        .addListener(ImageStreamListener(
      (image, synchronousCall) {
        setState(() => bg = image.image);
      },
    ));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
      animation: controller,
      child: widget.child,
      builder: (context, child) => CustomPaint(
            foregroundPainter:
                bg == null ? null : AvatarPainter(bg!, controller),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: child,
            ),
          ));
}

class ProfileScreenA extends StatelessWidget {
  const ProfileScreenA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styleUserName = theme.typography.englishLike.titleLarge!
        .copyWith(color: theme.colorScheme.onBackground);

    final styleDescription = theme.typography.englishLike.titleMedium!
        .copyWith(color: theme.colorScheme.onBackground.withOpacity(0.9));
    return Column(
      children: [
        const SafeArea(child: ProfileSettingsTitle()),
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverAppBar(
                flexibleSpace: Padding(
                  padding: EdgeInsets.all(24),
                  child: SizedBox.expand(
                    child: AvatarAnimated(
                      child: CircleAvatar(
                        child: Text('Photo!'),
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.transparent,
                expandedHeight: 200,
              ),
            ],
            body: Builder(
              builder: (context) => DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate.fixed(
                        [
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: TextFormField(
                              style: styleUserName,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Name',
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer
                                  .withOpacity(0.05),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(24),
                                bottom: Radius.circular(24),
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: TextFormField(
                              style: styleDescription,
                              maxLines: null,
                              textAlign: TextAlign.justify,
                              decoration: const InputDecoration.collapsed(
                                hintText: 'Description\n\n',
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer
                                    .withOpacity(0.05),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                  bottom: Radius.circular(20),
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                '03/31/2022',
                                style: styleDescription,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer
                                    .withOpacity(0.05),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                  bottom: Radius.circular(20),
                                ),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.location_pin),
                                  Text(
                                    '42.360°N 71.092°W',
                                    style: styleDescription,
                                    maxLines: null,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
