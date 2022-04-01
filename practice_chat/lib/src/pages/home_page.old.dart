import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../profile_screen.dart';
import '../widgets/w_background.dart';

class HomePage extends MaterialPage {
  @literal
  const HomePage() : super(child: const HomeScreenWidget());
}

void kVoid() {
  print('aa');
}

class ProfileButtonWidget extends StatelessWidget {
  const ProfileButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const CircleAvatar();
}

class WelcomeUserTile extends StatelessWidget {
  const WelcomeUserTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styleTitle = theme.typography.englishLike.titleMedium!
        .copyWith(color: theme.colorScheme.onBackground.withOpacity(0.5));
    final styleUserName = theme.typography.englishLike.titleLarge!
        .copyWith(color: theme.colorScheme.onBackground);
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Good morning',
                  style: styleTitle,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
                Text(
                  'Gilyazeev Adel',
                  style: styleUserName,
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                ),
              ],
            ),
          ),
        ),
        const IconButton(onPressed: kVoid, icon: Icon(Icons.search)),
        const SizedBox(width: 16),
        const ProfileButtonWidget(),
        const SizedBox(width: 16),
      ],
    );
  }
}

class StoryOpenBtn extends StatelessWidget {
  const StoryOpenBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(8),
        child: AvatarAnimated(
          child: CircleAvatar(
            radius: 32,
            child: Text('#'),
          ),
        ),
      );
}

class StoriesTileWidget extends StatelessWidget {
  const StoriesTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        scrollDirection: Axis.horizontal,
        prototypeItem: const StoryOpenBtn(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemBuilder: (context, index) => const StoryOpenBtn(),
        itemCount: 16,
      );
}

class ChatPreviewTileWidget extends StatelessWidget {
  const ChatPreviewTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const ListTile(
        isThreeLine: true,
        onTap: kVoid,
        title: Text(
          'Chat name some people',
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
        subtitle: Text(
          '''orem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.''',
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      );
}

class HomeScreenWidgetA extends StatelessWidget {
  const HomeScreenWidgetA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SafeArea(child: WelcomeUserTile()),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(),
                SliverPrototypeExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => const StoriesTileWidget(),
                    childCount: 1,
                  ),
                  prototypeItem: const StoryOpenBtn(),
                ),
                SliverPrototypeExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => const ChatPreviewTileWidget(),
                    childCount: 32,
                  ),
                  prototypeItem: const ChatPreviewTileWidget(),
                ),
              ],
            ),
          ),
        ],
      );
}

const kAppBarPainterRounds = 24;
const kAppBarPainterFade = 48;

class AppBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

class AppBarBackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size);
    return Path.combine(
      PathOperation.difference,
      Path()
        ..addRect(
          Rect.fromPoints(
            Offset.zero,
            Offset(size.width, size.height + kAppBarPainterRounds),
          ),
        ),
      Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromPoints(
              Offset(0, size.height),
              Offset(size.width, size.height + kAppBarPainterRounds * 2),
            ),
            Radius.circular(kAppBarPainterRounds.toDouble()),
          ),
        ),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class AppBarFadeClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    print(size);
    return Rect.fromPoints(
      Offset(0, size.height),
      Offset(size.width, size.height + kAppBarPainterFade),
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}

class AppBarFlexRenderer extends StatelessWidget {
  const AppBarFlexRenderer(this.ins, {Key? key}) : super(key: key);

  final bool ins;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints);

        final FlexibleSpaceBarSettings settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
        assert(
          settings != null,
          'A FlexibleSpaceBar must be wrapped in the widget returned by FlexibleSpaceBar.createSettings().',
        );

        final List<Widget> children = <Widget>[];

        final double deltaExtent = settings.maxExtent - settings.minExtent;

        // 0.0 -> Expanded
        // 1.0 -> Collapsed to toolbar
        final double t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0);

        print('deltaExtent=$deltaExtent\nt=$t');
        print('settings=${settings.minExtent}');

        return SizedBox(
          height: constraints.maxHeight,
          child: ColoredBox(
            color: Colors.blueAccent,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (ins)
                  ClipRect(
                    clipper: AppBarFadeClipper(),
                    child: OverflowBox(
                        alignment: Alignment.topLeft,
                        minHeight: constraints.maxHeight + kAppBarPainterFade,
                        minWidth: MediaQuery.of(context).size.width,
                        maxHeight: constraints.maxHeight + kAppBarPainterFade,
                        maxWidth: MediaQuery.of(context).size.width,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(
                                0,
                                constraints.maxHeight /
                                        (constraints.maxHeight +
                                            kAppBarPainterFade) *
                                        2.01 -
                                    1,
                              ),
                              end: Alignment
                                  .bottomCenter, // 10% of the width, so there are ten blinds.
                              colors: <Color>[
                                Theme.of(context).colorScheme.background,
                                Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withAlpha(0),
                              ], // red to yellow
                              tileMode: TileMode
                                  .clamp, // repeats the gradient over the canvas
                            ),
                          ),
                        )),
                  ),
                ClipPath(
                  clipper: AppBarBackgroundClipper(),
                  child: OverflowBox(
                    alignment: Alignment.topLeft,
                    minHeight: MediaQuery.of(context).size.height,
                    minWidth: MediaQuery.of(context).size.width,
                    maxHeight: MediaQuery.of(context).size.height,
                    maxWidth: MediaQuery.of(context).size.width,
                    child: const BackgroundWidget(),
                  ),
                ),
                Opacity(
                  opacity: 1.0 - t,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: settings.currentExtent - settings.minExtent,
                      child: StoriesTileWidget(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeScreenWidgetE extends StatelessWidget {
  const HomeScreenWidgetE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const WelcomeUserTile(),
                backgroundColor: Colors.black.withAlpha(10),
                shadowColor: Colors.transparent,
                foregroundColor: Colors.black,
                pinned: true,
                collapsedHeight: kToolbarHeight,
                expandedHeight: 200,
                flexibleSpace: AppBarFlexRenderer(innerBoxIsScrolled),
              ),
            ),
          ],
          body: Builder(
            builder: (context) => CustomScrollView(
              slivers: <Widget>[
                SliverOverlapInjector(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                ),
                SliverPrototypeExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => const ChatPreviewTileWidget(),
                    childCount: 32,
                  ),
                  prototypeItem: const ChatPreviewTileWidget(),
                ),
              ],
            ),
          ),
        ),
      );
}

class HomeScreenWidgetD extends StatelessWidget {
  const HomeScreenWidgetD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: const WelcomeUserTile(),
              backgroundColor: Colors.black.withAlpha(10),
              shadowColor: Colors.transparent,
              foregroundColor: Colors.black,
              pinned: true,
              // collapsedHeight: 64,
              expandedHeight: 200,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: const StoriesTileWidget(),
            ),
          ),
        ],
        body: Builder(
          builder: (context) => CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              SliverFillRemaining(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: CustomScrollView(
                    controller: PrimaryScrollController.of(context),
                    slivers: [
                      SliverPrototypeExtentList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => const ChatPreviewTileWidget(),
                          childCount: 32,
                        ),
                        prototypeItem: const ChatPreviewTileWidget(),
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

class HomeScreenWidgetB extends StatelessWidget {
  const HomeScreenWidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: const WelcomeUserTile(),
              backgroundColor: Colors.black.withAlpha(100),
              shadowColor: Colors.transparent,
              foregroundColor: Colors.black,
              pinned: true,
              // collapsedHeight: 64,
              expandedHeight: 200,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: const StoriesTileWidget(),
            ),
          ),
        ],
        body: Builder(
          builder: (context) => CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              SliverToBoxAdapter(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Column(
                    children: List.filled(32, const ChatPreviewTileWidget()),
                  ),
                ),
              )
            ],
          ),
        ),
      );
}

class HomeScreenWidgetC extends StatelessWidget {
  const HomeScreenWidgetC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          const SafeArea(child: WelcomeUserTile()),
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverPrototypeExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => const StoriesTileWidget(),
                    childCount: 1,
                  ),
                  prototypeItem: const StoryOpenBtn(),
                ),
              ],
              body: Builder(
                builder: (context) => DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 16),
                        sliver: SliverPrototypeExtentList(
                          delegate: SliverChildBuilderDelegate(
                            (ctx, i) => const ChatPreviewTileWidget(),
                            childCount: 32,
                          ),
                          prototypeItem: const ChatPreviewTileWidget(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
}

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView(
          children: [
            const HomeScreenWidgetE(),
            const HomeScreenWidgetD(),
            const HomeScreenWidgetC(),
            const HomeScreenWidgetA(),
            const HomeScreenWidgetB(),
            const ProfileScreenA(),
            Image.asset(
              'assets/images/home-page.jpeg',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft,
            ),
          ],
        ),
      );
}
