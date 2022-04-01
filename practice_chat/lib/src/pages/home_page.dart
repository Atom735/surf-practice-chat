import 'package:flutter/material.dart';

import '../router/route_info.dart';
import 'home_page.old.dart';

class HomePage extends MaterialPage {
  HomePage()
      : super(
          child: const HomeScreenWidget(),
          name: const HomeRouteInfo().path,
          restorationId: const HomeRouteInfo().path,
        );
}

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  final vn = ValueNotifier<bool>(false);

  @override
  void dispose() {
    vn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            vn.value = innerBoxIsScrolled;
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: const SliverAppBar(
                  title: WelcomeUserTile(),
                  // backgroundColor: Colors.black26,
                  pinned: true,
                  // collapsedHeight: 64,
                  expandedHeight: 200,
                  flexibleSpace: AppBarFlexRenderer2(),
                ),
              ),
            ];
          },
          body: Builder(
            builder: (context) => CustomScrollView(
              controller: PrimaryScrollController.of(context),
              physics: const ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final h = NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    );
                    final theme = Theme.of(context);
                    return SliverFillRemaining(
                      // fillOverscroll: true,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          height: constraints.remainingPaintExtent -
                              (h.layoutExtent ?? 0),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(32)),
                              boxShadow: kElevationToShadow[6],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(32)),
                              child: AnimatedBuilder(
                                  animation: vn,
                                  builder: (context, child) => Stack(
                                        children: [
                                          CustomScrollView(
                                            controller:
                                                PrimaryScrollController.of(
                                                    context),
                                            slivers: [
                                              SliverToBoxAdapter(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: Center(
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        color: theme.colorScheme
                                                            .surfaceVariant,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .vertical(
                                                          top: Radius.circular(
                                                              4),
                                                          bottom:
                                                              Radius.circular(
                                                                  4),
                                                        ),
                                                      ),
                                                      child: const SizedBox(
                                                        height: 8,
                                                        width: 96,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SliverPrototypeExtentList(
                                                delegate:
                                                    SliverChildBuilderDelegate(
                                                  (ctx, i) =>
                                                      const ChatPreviewTileWidget(),
                                                  childCount: 32,
                                                ),
                                                prototypeItem:
                                                    const ChatPreviewTileWidget(),
                                              ),
                                            ],
                                          ),
                                          if (vn.value)
                                            DecoratedBox(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: <Color>[
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .surface,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .surface
                                                        .withAlpha(0),
                                                  ],
                                                ),
                                              ),
                                              child: const SizedBox(
                                                height: 128,
                                                width: double.infinity,
                                              ),
                                            ),
                                        ],
                                      )),
                            ),
                          ),
                        ),
                      ),
                    );

                    return SliverToBoxAdapter(
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        child: Column(
                          children:
                              List.filled(32, const ChatPreviewTileWidget()),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

class AppBarFlexRenderer2 extends StatelessWidget {
  const AppBarFlexRenderer2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          assert(
            context.dependOnInheritedWidgetOfExactType<
                    FlexibleSpaceBarSettings>() !=
                null,
            'A FlexibleSpaceBar must be wrapped in the widget returned by FlexibleSpaceBar.createSettings().',
          );
          final settings = context
              .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;

          final deltaExtent = settings.maxExtent - settings.minExtent;

          // 0.0 -> Expanded
          // 1.0 -> Collapsed to toolbar
          final t = (1.0 -
                  (settings.currentExtent - settings.minExtent) / deltaExtent)
              .clamp(0.0, 1.0);

          return SizedBox(
            height: constraints.maxHeight,
            child: Opacity(
              opacity: 1.0 - t,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: settings.currentExtent - settings.minExtent,
                  child: const StoriesTileWidget(),
                ),
              ),
            ),
          );
        },
      );
}
