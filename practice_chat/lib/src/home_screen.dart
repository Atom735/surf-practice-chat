import 'package:flutter/material.dart';

void kVoid() {}

class ScreenBackgroundWidget extends StatelessWidget {
  const ScreenBackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Image.asset(
        'assets/images/bg.png',
        fit: BoxFit.cover,
      );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning',
                  style: styleTitle,
                ),
                Text(
                  'Gilyazeev Adel',
                  style: styleUserName,
                ),
              ],
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
        child: CircleAvatar(
          radius: 32,
          child: Text('#'),
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
          'lorem epsum dolor sit amet, consectetur adipiscing elementary',
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

class HomeScreenWidgetB extends StatelessWidget {
  const HomeScreenWidgetB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: const WelcomeUserTile(),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              pinned: true,
              expandedHeight: 256,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: const StoriesTileWidget(),
            ),
          ),
        ],
        body: Builder(
          builder: (context) => DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
      );
}

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          const ScreenBackgroundWidget(),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: PageView(
              children: const [
                HomeScreenWidgetA(),
                HomeScreenWidgetB(),
              ],
            ),
          ),
        ],
      );
}
