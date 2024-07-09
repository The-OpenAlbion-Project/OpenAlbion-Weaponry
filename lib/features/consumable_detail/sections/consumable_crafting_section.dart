import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:openalbion_weaponry/constants/app_dimens.dart';
import 'package:openalbion_weaponry/data/vos/app_error.dart';
import 'package:openalbion_weaponry/data/vos/crafting_enchantment_vo.dart';
import 'package:openalbion_weaponry/data/vos/crafting_requirement_vo.dart';
import 'package:openalbion_weaponry/data/vos/item_vo.dart';
import 'package:openalbion_weaponry/features/consumable_detail/widgets/crafting_loading.dart';
import 'package:openalbion_weaponry/features/global/inter_text.dart';
import 'package:openalbion_weaponry/providers/based_provider.dart';
import 'package:openalbion_weaponry/providers/consumable_detail_provider.dart';
import 'package:openalbion_weaponry/providers/crafting_provider.dart';
import 'package:openalbion_weaponry/providers/market_price_provider.dart';
import 'package:openalbion_weaponry/theme/app_color.dart';
import 'package:openalbion_weaponry/theme/app_theme.dart';
import 'package:openalbion_weaponry/utils/dialog_utils.dart';
import 'package:provider/provider.dart';

class ConsumableCraftingSection extends StatelessWidget {
  final ItemVO item;
  const ConsumableCraftingSection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer<CraftingProvider>(builder: (context, provider, child) {
      switch (provider.state) {
        case ViewState.COMPLETE:
          return _buildCompleteUI(context);

        case ViewState.LOADING:
          return CraftingLoading();

        case ViewState.ERROR:
          return _buildCraftingError(provider.appError!);
      }
      return _buildCompleteUI(context);
    });
  }

  Column _buildCompleteUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MARGIN_MEDIUM_2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InterText(AppLocalizations.of(context)!.consumer_crafting_by_product),
              CityDropDownSection(),
            ],
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        ProductSection(item: item),
        SizedBox(height: MARGIN_MEDIUM_2),
        IngredientSection()
      ],
    );
  }

  Widget _buildCraftingError(AppError appError) {
    return Padding(
      padding: const EdgeInsets.only(top: MARGIN_XXLARGE),
      child: Center(
        child: InterText(
          "${appError.code}\n${appError.message}",
          style: TextStyle(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class IngredientSection extends StatelessWidget {
  const IngredientSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CraftingProvider>(builder: (context, craftingProvider, child) {
      return Consumer<ConsumableDetailProvider>(builder: (context, detailProvider, child) {
        var enchantment =
            craftingProvider.getCraftingEnchantment(enchantmentId: detailProvider.selectedEnchantment.enchantment);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: InterText(AppLocalizations.of(context)!.consumer_ingredients),
            ),
            SizedBox(height: MARGIN_MEDIUM_2),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: enchantment?.crafting.requirements.length ?? 0,
                itemBuilder: (context, index) {
                  return enchantment != null
                      ? IngredientItemView(craftingRequirementVO: enchantment.crafting.requirements[index])
                      : SizedBox();
                })
          ],
        );
      });
    });
  }
}

class IngredientItemView extends StatelessWidget {
  final CraftingRequirementVO craftingRequirementVO;
  const IngredientItemView({
    required this.craftingRequirementVO,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CraftingProvider>(builder: (context, craftingProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
        child: GestureDetector(
          onTap: () {
            // TODO: dialog replacement

            // DialogUtils.showAlredyHaveDialog(
            //     context: context,
            //     onUpdate: (amount) {
            //       craftingProvider.alreadyHaveMap[craftingRequirementVO.identifier] = amount;
            //       craftingProvider.notifyListeners();
            //     });
          },
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            decoration: BoxDecoration(
                color: getCardColor(context).withOpacity(0.5), borderRadius: BorderRadius.circular(MARGIN_MEDIUM)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: MARGIN_MEDIUM_2),
              Row(
                children: [
                  SizedBox(width: MARGIN_MEDIUM_2),
                  CachedNetworkImage(
                    imageUrl: craftingRequirementVO.icon,
                    width: 75,
                    filterQuality: FilterQuality.high,
                  ),
                  SizedBox(width: MARGIN_MEDIUM_2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InterText(craftingRequirementVO.name),
                      SizedBox(height: MARGIN_MEDIUM),
                      InterText("x ${craftingRequirementVO.value * craftingProvider.selectedCraftAmount}")
                    ],
                  ),
                ],
              ),
              SizedBox(height: MARGIN_MEDIUM_2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: InterText("Already Have")),
                    InterText("-   ${craftingProvider.getAlreadyHaveAmount(craftingRequirementVO.identifier)}")
                  ],
                ),
              ),
              SizedBox(height: MARGIN_MEDIUM_2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: InterText("Need To Buy")),
                    InterText(
                        "-   ${craftingProvider.getNeedToBuyAmount(identifier: craftingRequirementVO.identifier, value: craftingRequirementVO.value)}")
                  ],
                ),
              ),
              SizedBox(height: MARGIN_MEDIUM_2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: InterText("Estimate Cost")),
                    InterText(
                        "-   ${craftingProvider.getCostForIngredient(identifier: craftingRequirementVO.identifier, value: craftingRequirementVO.value)}")
                  ],
                ),
              ),
              SizedBox(height: MARGIN_MEDIUM_2),
            ]),
          ),
        ),
      );
    });
  }
}

class ProductSection extends StatelessWidget {
  final ItemVO item;

  const ProductSection({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Consumer<CraftingProvider>(builder: (context, craftProvider, child) {
      return Consumer<ConsumableDetailProvider>(builder: (context, detailProvider, child) {
        var enchantment =
            craftProvider.getCraftingEnchantment(enchantmentId: detailProvider.selectedEnchantment.enchantment);
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          decoration: BoxDecoration(
              color: getCardColor(context).withOpacity(0.5), borderRadius: BorderRadius.circular(MARGIN_MEDIUM)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: MARGIN_MEDIUM_2),
            Row(
              children: [
                SizedBox(width: MARGIN_MEDIUM_2),
                CachedNetworkImage(
                  imageUrl: detailProvider.enchanmentList.isEmpty ? item.icon : detailProvider.selectedEnchantment.icon,
                  width: 75,
                  filterQuality: FilterQuality.high,
                ),
                SizedBox(width: MARGIN_MEDIUM_2),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InterText(item.name),
                    SizedBox(height: MARGIN_MEDIUM),
                    enchantment != null
                        ? InterText("x ${craftProvider.selectedCraftAmount * enchantment.crafting.perCraft}")
                        : SizedBox()
                  ],
                ),
              ],
            ),
            SizedBox(height: MARGIN_MEDIUM_2),
            enchantment != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                    child: InterText(
                      "Per Craft (x${craftProvider.getCraftingEnchantment(enchantmentId: detailProvider.selectedEnchantment.enchantment)?.crafting.perCraft}) :",
                      style: TextStyle(fontSize: TEXT_SMALL),
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: FlutterSlider(
                values: [craftProvider.selectedCraftAmount.toDouble()],
                min: 1.0,
                max: 100.0,
                touchSize: 22,
                trackBar: FlutterSliderTrackBar(
                    activeTrackBar: BoxDecoration(color: secondaryRed),
                    inactiveTrackBar: BoxDecoration(color: secondaryRed.withOpacity(0.1))),
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  craftProvider.updateSelectedCraftAmount(lowerValue as double);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: Row(
                children: [
                  InterText("Profit - ${craftProvider.getTotalProfit()}"),
                  Spacer(),
                  SimpleButton(
                      onTap: () {
                        if (craftProvider.selectedCraftAmount > 1) {
                          craftProvider.selectedCraftAmount -= 1;
                          craftProvider.notifyListeners();
                        }
                      },
                      svgIcon: "assets/images/svgs/ic_minus.svg"),
                  SizedBox(width: MARGIN_MEDIUM_2),
                  SimpleButton(
                      onTap: () {
                        if (craftProvider.selectedCraftAmount < 100) {
                          craftProvider.selectedCraftAmount += 1;
                          craftProvider.notifyListeners();
                        }
                      },
                      svgIcon: "assets/images/svgs/ic_plus.svg")
                ],
              ),
            ),
            SizedBox(height: MARGIN_MEDIUM_2)
          ]),
        );
      });
    });
  }
}

class CityDropDownSection extends StatelessWidget {
  const CityDropDownSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CraftingProvider>(builder: (context, provider, child) {
      return SizedBox(
        width: 150,
        child: DropdownButtonFormField2(
          value: provider.selectedCity,
          decoration: InputDecoration(
            filled: true,
            fillColor: getCardColor(context),

            //Add isDense true and zero Padding.
            //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide.none),
            //Add more decoration as you want here
            //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
          ),
          buttonStyleData: const ButtonStyleData(height: 30, padding: EdgeInsets.only(right: MARGIN_MEDIUM)),
          dropdownStyleData: DropdownStyleData(
            offset: Offset(0, -10),
            decoration:
                BoxDecoration(color: getCardColor(context), borderRadius: BorderRadius.circular(4), boxShadow: []),
          ),
          onChanged: (city) {
            if (city != null) {
              provider.updateSelectedCity(city);
            }
          },
          items: provider.availableCityList
              .map(
                (city) => DropdownMenuItem(
                  value: city,
                  child: InterText(
                    city,
                    style: TextStyle(fontSize: TEXT_SMALL),
                  ),
                ),
              )
              .toList(),
          // items: [].map((e) => e).toList(),
        ),
      );
    });
  }
}

class SimpleButton extends StatelessWidget {
  final String svgIcon;
  final Function onTap;
  const SimpleButton({super.key, required this.onTap, required this.svgIcon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 30,
        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(MARGIN_MEDIUM), color: getCardColor(context)
            // border: Border.all(
            //   color: get60PercentColor(context),
            // ),
            ),
        child: SvgPicture.asset(
          svgIcon,
          width: 10,
          colorFilter: ColorFilter.mode(Theme.of(context).iconTheme.color!, BlendMode.srcIn),
        ),
      ),
    );
  }
}
