import 'package:flutter/material.dart';

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

class ProfilePhotoSettingButton extends StatelessWidget {
  const ProfilePhotoSettingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const CircleAvatar();
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
                    child: ProfilePhotoSettingButton(),
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
