import 'package:flutter/material.dart';

import '../components/bottom_sheet/bottom_sheet_widget.dart';
import '../home_screen.dart';
import '../utils/scroll_physics/custom_clamping.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  _HomeScreenWidgetState() {
    vn.addListener(() {
      print(vn.value);
    });
  }

  final vn = ValueNotifier<bool>(false);

  @override
  void dispose() {
    vn.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    _nestedHeaderBuilderCache = null;
    _nestedBodyCache = null;
    _nestedInnerBodySliversCache = null;
    super.reassemble();
  }

  List<Widget>? _nestedHeaderBuilderCache;

  List<Widget> nestedHeaderBuilder(
      BuildContext context, bool innerBoxIsScrolled) {
    vn.value = innerBoxIsScrolled;
    return _nestedHeaderBuilderCache ??= [
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: const SliverAppBar(
          title: WelcomeUserTile(),
          // backgroundColor: Colors.black26,
          pinned: true,
          // floating: true,
          // collapsedHeight: 64,
          expandedHeight: 400,
          flexibleSpace: AppBarFlexRenderer2(),
        ),
      ),
    ];
  }

  Widget? _nestedBodyCache;

  List<Widget>? _nestedInnerBodySliversCache;

  Widget bottomSheetBuilder(BuildContext context, Widget? child) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(4),
                  bottom: Radius.circular(4),
                ),
              ),
              child: const SizedBox(
                height: 8,
                width: 96,
              ),
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              CustomScrollView(
                // controller: PrimaryScrollController.of(context),
                physics: const CustomClampingScrollPhysics(
                  AxisDirection.down,
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  // SliverToBoxAdapter(
                  //   child:
                  // ),
                  SliverPrototypeExtentList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) => const ChatPreviewTileWidget(),
                      childCount: 32,
                    ),
                    prototypeItem: const ChatPreviewTileWidget(),
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
                        theme.colorScheme.surface,
                        theme.colorScheme.surface.withAlpha(0),
                      ],
                    ),
                  ),
                  child: const SizedBox(
                    height: 128,
                    width: double.infinity,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  final sc = CustomScrollController();

  @override
  Widget build(BuildContext context) => PrimaryScrollController(
        controller: sc,
        child: Scaffold(
          body: NestedScrollView(
            // controller: sc,
            physics: const CustomClampingScrollPhysics(
              AxisDirection.up,
              parent: BouncingScrollPhysics(),
            ),
            headerSliverBuilder: nestedHeaderBuilder,
            body: _nestedBodyCache ??= Builder(
              builder: (context) {
                final theme = Theme.of(context);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context)
                          .layoutExtent,
                    ),
                    Expanded(
                      child: BottomSheetWidget(
                              child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ListView.builder(
                                primary: true,
                                padding: EdgeInsets.zero,
                                // controller: sc,
                                physics: const CustomClampingScrollPhysics(
                                  AxisDirection.down,
                                  parent: BouncingScrollPhysics(),
                                ),
                                itemBuilder: (context, index) =>
                                    const ChatPreviewTileWidget(),
                                prototypeItem: const ChatPreviewTileWidget(),
                                itemCount: 20,
                              ),
                              if (vn.value)
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        theme.colorScheme.surface,
                                        theme.colorScheme.surface.withAlpha(0),
                                      ],
                                    ),
                                  ),
                                  child: const SizedBox(
                                    height: 128,
                                    width: double.infinity,
                                  ),
                                ),
                            ],
                          )) ??
                          DecoratedBox(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surface,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(32),
                              ),
                              boxShadow: kElevationToShadow[6],
                            ),
                            child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(32),
                                  ),
                                  // child: AnimatedBuilder(
                                  //   animation: vn,
                                  //   builder: bottomSheetBuilder,
                                  // ),
                                ) ??
                                CustomScrollView(
                                  controller:
                                      PrimaryScrollController.of(context),
                                  physics: const CustomClampingScrollPhysics(
                                    AxisDirection.up,
                                    parent: BouncingScrollPhysics(),
                                  ),
                                  slivers:
                                      _nestedInnerBodySliversCache ??= <Widget>[
                                    SliverLayoutBuilder(
                                      builder: (context, constraints) {
                                        final h = NestedScrollView
                                            .sliverOverlapAbsorberHandleFor(
                                          context,
                                        );
                                        final theme = Theme.of(context);
                                        return SliverFillRemaining(
                                          // fillOverscroll: true,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: SizedBox(
                                              width: double.infinity,
                                              height: constraints
                                                      .remainingPaintExtent -
                                                  (h.layoutExtent ?? 0),
                                              child: DecoratedBox(
                                                decoration: BoxDecoration(
                                                  color:
                                                      theme.colorScheme.surface,
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top: Radius.circular(32),
                                                  ),
                                                  boxShadow:
                                                      kElevationToShadow[6],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius
                                                          .vertical(
                                                    top: Radius.circular(32),
                                                  ),
                                                  // child: AnimatedBuilder(
                                                  //   animation: vn,
                                                  //   builder: bottomSheetBuilder,
                                                  // ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                          ),
                    ),
                  ],
                );
              },
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
            '''A FlexibleSpaceBar must be wrapped in the widget returned by FlexibleSpaceBar.createSettings().''',
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

class CustomScrollController extends ScrollController {
  CustomScrollController() {
    addListener(posListner);
  }
  final sp = <ScrollPosition>[];

  void posListner() {
    print(this);
    for (var i = 0; i < sp.length; i++) {
      print('$i: ${sp[i]}');
    }
  }

  @override
  void attach(ScrollPosition position) {
    sp.add(position);
    position.addListener(posListner);
    super.attach(position);
  }

  /// Unregister the given position with this controller.
  ///
  /// After this function returns, the [animateTo] and [jumpTo] methods on this
  /// controller will not manipulate the given position.
  @override
  void detach(ScrollPosition position) {
    sp.remove(position);
    position.removeListener(posListner);
    super.detach(position);
  }
}
