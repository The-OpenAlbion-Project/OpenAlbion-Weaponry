import 'package:flutter/material.dart';
import 'package:openalbion_weaponry/constants/app_dimens.dart';
import 'package:openalbion_weaponry/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class ItemListLoading extends StatelessWidget {
  const ItemListLoading({super.key});

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        height: 1000,
        child: Shimmer.fromColors(
          baseColor: getCardColor(context),
          highlightColor: Colors.grey.withOpacity(0.4),
          child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return LoadingTierGroupView();
          },
          separatorBuilder: (_, index) => Divider(
          endIndent: 140,
          color: get80PercentColor(context),
        ),
          itemCount: 3),
        ),
      );
    }


  }


class LoadingItemView extends StatelessWidget {
  const LoadingItemView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                // CachedNetworkImage(
                //   imageUrl: item.icon,
                //   width: 70,
                // ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: getCardColor(context), borderRadius: BorderRadius.circular(MARGIN_SMALL)),
                ),
                SizedBox(width: MARGIN_MEDIUM_2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 20,
                      decoration: BoxDecoration(
                          color: getCardColor(context),
                          borderRadius: BorderRadius.circular(MARGIN_SMALL)),
                    ),
                    SizedBox(height: MARGIN_CARD_MEDIUM_2),
                    Container(
                      width: 120,
                      height: 20,
                      decoration: BoxDecoration(
                          color: getCardColor(context),
                          borderRadius: BorderRadius.circular(MARGIN_SMALL)),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoadingTierGroupView extends StatelessWidget {
  const LoadingTierGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MARGIN_MEDIUM),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Container(
            width: 120,
            height: 20,
            decoration: BoxDecoration(
                color: getCardColor(context), borderRadius: BorderRadius.circular(MARGIN_SMALL)),
          ),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => LoadingItemView())
      ],
    );
  }
}
