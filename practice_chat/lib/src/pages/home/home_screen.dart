import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import '../../components/bottom_sheet_widget.dart';
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
          // physics: BouncingScrollPhysics(),
          // physics: const CustomClampingScrollPhysics(
          //   AxisDirection.up,
          //   parent: BouncingScrollPhysics(),
          // ),

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
                  expandedHeight: 200,
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
                  AnimatedBuilder(
                    animation: NestedScrollView.sliverOverlapAbsorberHandleFor(
                      context,
                    ),
                    builder: (context, child) => SizedBox(
                      height: NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context)
                          .scrollExtent,
                    ),
                  ),
                  Expanded(
                    child: BottomSheetWidget(
                      pinColor: theme.colorScheme.surfaceVariant,
                      backgroundColor: theme.colorScheme.surface,
                      shadows: kElevationToShadow[6],
                      fadeEnabled: wm.scrollOverlaped,
                      child: ListView.builder(
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
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
}
