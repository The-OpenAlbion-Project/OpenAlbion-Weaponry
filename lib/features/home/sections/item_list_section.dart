import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openalbion_weaponry/constants/app_dimens.dart';
import 'package:openalbion_weaponry/data/vos/item_vo.dart';
import 'package:openalbion_weaponry/data/vos/tier_group_vo.dart';
import 'package:openalbion_weaponry/features/global/image_loading_placeholder.dart';
import 'package:openalbion_weaponry/features/global/inter_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:openalbion_weaponry/features/home/widgets/item_list_loading.dart';
import 'package:openalbion_weaponry/providers/home_provider.dart';
import 'package:openalbion_weaponry/theme/app_theme.dart';
import 'package:provider/provider.dart';

class ItemListSection extends StatelessWidget {
  final Function(String type, ItemVO itemVO) onTap;
  const ItemListSection({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      return _renderUI(provider, context);
    });
  }

  Widget _renderUI(HomeProvider provider, BuildContext context) {
    if (provider.itemLoading) {
      return ItemListLoading();
    } else if (provider.itemComplete) {
      return _completeUI(provider, context);
    } else if (provider.appError != null) {
      return Expanded(
        child: Center(
          child: InterText(
            "${provider.appError?.code}\n${provider.appError?.message}",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SizedBox();
  }

  Expanded _completeUI(HomeProvider provider, BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return TierGroupView(
              tierGroup: provider.tierGroupList[index],
              onTap: (item) {
                onTap(provider.selectedSubCategory.type, item);
              },
            );
          },
          separatorBuilder: (_, index) => Divider(
                endIndent: 140,
                color: get80PercentColor(context).withOpacity(0.5),
              ),
          itemCount: provider.tierGroupList.length),
    );
  }
}

class ItemView extends StatelessWidget {
  final ItemVO item;
  final Function() onTap;
  const ItemView({
    required this.item,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap();
      },
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'item${item.name}',
                    child: CachedNetworkImage(
                      imageUrl: item.icon,
                      placeholder: (context, url) => ImageLoadingPlaceholder(size: 70),
                      width: 70,
                    ),
                  ),
                  SizedBox(width: MARGIN_MEDIUM),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InterText(item.name),
                      SizedBox(height: MARGIN_CARD_MEDIUM_2),
                      InterText("IP : ${item.itemPower ?? 'Not Available'}"),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


class TierGroupView extends StatelessWidget {
  final TierGroupVO tierGroup;
  final Function(ItemVO item) onTap;

  const TierGroupView({super.key, required this.tierGroup, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MARGIN_MEDIUM),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: InterText(tierGroup.name),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: tierGroup.itemList.length,
            itemBuilder: (context, index) => ItemView(
                  item: tierGroup.itemList[index],
                  onTap: () {
                    onTap(tierGroup.itemList[index]);
                  },
                ))
      ],
    );
  }
}