import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../components/bottom_sheet/bottom_sheet_widget.dart';
import '../../home_screen.dart';
import '../../utils/scroll_physics/custom_clamping.dart';
import '../home_page.dart';
import 'home_wm_factory.dart';
import 'home_wm_interface.dart';

class HomeScreen extends ElementaryWidget<IHomeWidgetModel> {
  const HomeScreen({
    Key? key,
    WidgetModelFactory wmFactory = homeWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IHomeWidgetModel wm) => Scaffold(
        body: NestedScrollView(
          // controller: sc,
          physics: const CustomClampingScrollPhysics(
            AxisDirection.up,
            parent: BouncingScrollPhysics(),
          ),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            wm.scrollOverlaped.value = innerBoxIsScrolled;

            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
          },
          body: Builder(
            builder: (context) {
              final theme = Theme.of(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height:
                        NestedScrollView.sliverOverlapAbsorberHandleFor(context)
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
                          _OverlapFadeWidget(
                            enabled: wm.scrollOverlaped,
                            color: wm.theme.colorScheme.surface,
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
      );
}

class _OverlapFadeWidget extends StatelessWidget {
  const _OverlapFadeWidget({
    required this.color,
    required this.enabled,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<bool> enabled;
  final Color color;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: enabled,
        builder: (context, enabled, child) =>
            Offstage(offstage: !enabled, child: child),
        child: Align(
          alignment: Alignment.topCenter,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  color,
                  color.withOpacity(0),
                ],
              ),
            ),
            child: const SizedBox(
              height: 64,
              width: double.infinity,
            ),
          ),
        ),
      );
}
