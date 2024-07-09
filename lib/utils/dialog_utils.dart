import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:openalbion_weaponry/constants/app_dimens.dart';
import 'package:openalbion_weaponry/data/vos/debug_vo.dart';
import 'package:openalbion_weaponry/data/vos/report_vo.dart';
import 'package:openalbion_weaponry/data/vos/version_result_vo.dart';
import 'package:openalbion_weaponry/features/global/inter_text.dart';
import 'package:openalbion_weaponry/features/global/simple_dropdown.dart';
import 'package:openalbion_weaponry/features/global/simple_numberfield.dart';
import 'package:openalbion_weaponry/features/global/simple_textfield.dart';
import 'package:openalbion_weaponry/theme/app_color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DialogUtils {
  // TODO: dialog replacement

  // static YYDialog showDebugReport(
  //     {required BuildContext context,
  //     required List<String> titleList,
  //     required Function onDimissied,
  //     required Function(ReportVO reportVO) onSubmited}) {
  //   var yyDialog = YYDialog();
  //   var selectedCategory = titleList.first;
  //   var selectedDescription = "";

  //   return yyDialog.build()
  //     ..width = 320
  //     ..backgroundColor = Theme.of(context).scaffoldBackgroundColor
  //     ..borderRadius = MARGIN_MEDIUM
  //     ..showCallBack = () {}
  //     ..dismissCallBack = () {
  //       onDimissied();
  //     }
  //     ..widget(Builder(builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2, horizontal: MARGIN_MEDIUM_2),
  //         child: SizedBox(
  //           width: double.infinity,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               InterText(AppLocalizations.of(context)!.bug_report,
  //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: TEXT_REGULAR_2X)),
  //               SizedBox(height: MARGIN_MEDIUM),
  //               Divider(height: MARGIN_MEDIUM_2),
  //               InterText(
  //                 AppLocalizations.of(context)!.bug_category,
  //                 style: TextStyle(fontWeight: FontWeight.w600),
  //               ),
  //               SizedBox(height: MARGIN_MEDIUM_2),
  //               SimpleDropDown(
  //                   itemList: titleList,
  //                   onSelected: (item) {
  //                     selectedCategory = item;
  //                   }),
  //               SizedBox(height: MARGIN_MEDIUM_2),
  //               InterText(AppLocalizations.of(context)!.bug_detail, style: TextStyle(fontWeight: FontWeight.w600)),
  //               SizedBox(height: MARGIN_MEDIUM_2),
  //               SimpleTextField(
  //                   hint: AppLocalizations.of(context)!.bug_detail_example,
  //                   onChanged: (text) {
  //                     selectedDescription = text;
  //                   }),
  //               SizedBox(height: MARGIN_LARGE),
  //               Row(
  //                 children: [
  //                   Spacer(),
  //                   TextButton(
  //                     style: ButtonStyle(
  //                       overlayColor: MaterialStateColor.resolveWith((states) => blackBackground.withOpacity(0.1)),
  //                       shape: MaterialStatePropertyAll(
  //                         RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
  //                         ),
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       yyDialog.dismiss();
  //                     },
  //                     child: InterText(AppLocalizations.of(context)!.cancel),
  //                   ),
  //                   SizedBox(width: MARGIN_MEDIUM_2),
  //                   FilledButton(
  //                     style: ButtonStyle(
  //                         backgroundColor: MaterialStatePropertyAll(primaryRed),
  //                         shape: MaterialStatePropertyAll(
  //                             RoundedRectangleBorder(borderRadius: BorderRadius.circular(MARGIN_MEDIUM)))),
  //                     onPressed: () async {
  //                       var hasNetwork = await Connectivity().checkConnectivity() != ConnectivityResult.none;
  //                       if (!hasNetwork) {
  //                         Fluttertoast.showToast(msg: AppLocalizations.of(context)!.no_internet);
  //                       } else if (selectedCategory.isNotEmpty && selectedDescription.isNotEmpty) {
  //                         var packageInfo = await PackageInfo.fromPlatform();
  //                         onSubmited(
  //                           ReportVO(
  //                               category: selectedCategory,
  //                               description: selectedDescription,
  //                               debug: DebugVO(
  //                                 version: packageInfo.version.toString(),
  //                               )),
  //                         );
  //                         yyDialog.dismiss();
  //                       } else {
  //                         Fluttertoast.showToast(msg: AppLocalizations.of(context)!.invalid_information);
  //                       }
  //                     },
  //                     child: InterText(
  //                       AppLocalizations.of(context)!.submit,
  //                       style: TextStyle(color: whiteText, fontSize: TEXT_REGULAR - 1),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     }))
  //     // ..animatedFunc = (child, animation) {
  //     //   return ScaleTransition(
  //     //     scale: Tween(begin: 0.0, end: 1.0).animate(animation),
  //     //     child: child,
  //     //   );
  //     // }
  //     ..animatedFunc = (child, animation) {
  //       return FadeTransition(
  //         opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
  //         child: child,
  //       );
  //     }
  //     ..show();
  // }

  // static YYDialog showVersionUpdateDialog(
  //     {required BuildContext context, required VersionResultVO versionResult, required Function onUpdate}) {
  //   var yyDialog = YYDialog();
  //   return yyDialog.build()
  //     ..width = 320
  //     ..barrierDismissible = !versionResult.force
  //     ..backgroundColor = Theme.of(context).scaffoldBackgroundColor
  //     ..borderRadius = MARGIN_MEDIUM
  //     ..showCallBack = () {}
  //     ..dismissCallBack = () {}
  //     ..widget(Builder(builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2, horizontal: MARGIN_MEDIUM_2),
  //         child: SizedBox(
  //           width: double.infinity,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               InterText(versionResult.title,
  //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: TEXT_REGULAR_2X)),
  //               SizedBox(height: MARGIN_MEDIUM),
  //               Divider(height: MARGIN_MEDIUM_2),
  //               InterText(
  //                 versionResult.description,
  //               ),
  //               SizedBox(height: MARGIN_MEDIUM_2),
  //               versionResult.force
  //                   ? Padding(
  //                       padding: const EdgeInsets.only(bottom: MARGIN_MEDIUM_2),
  //                       child: InterText(
  //                         AppLocalizations.of(context)!.you_need_to_upgrade,
  //                         style: TextStyle(fontSize: TEXT_SMALL),
  //                       ),
  //                     )
  //                   : SizedBox(),
  //               Row(
  //                 children: [
  //                   Spacer(),
  //                   !versionResult.force
  //                       ? TextButton(
  //                           style: ButtonStyle(
  //                             overlayColor:
  //                                 MaterialStateColor.resolveWith((states) => blackBackground.withOpacity(0.1)),
  //                             shape: MaterialStatePropertyAll(
  //                               RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
  //                               ),
  //                             ),
  //                           ),
  //                           onPressed: () {
  //                             yyDialog.dismiss();
  //                           },
  //                           child: InterText(AppLocalizations.of(context)!.cancel),
  //                         )
  //                       : SizedBox(),
  //                   SizedBox(width: MARGIN_MEDIUM_2),
  //                   FilledButton(
  //                     style: ButtonStyle(
  //                         backgroundColor: MaterialStatePropertyAll(primaryRed),
  //                         shape: MaterialStatePropertyAll(
  //                             RoundedRectangleBorder(borderRadius: BorderRadius.circular(MARGIN_MEDIUM)))),
  //                     onPressed: () {
  //                       onUpdate();
  //                     },
  //                     child: InterText(
  //                       AppLocalizations.of(context)!.update,
  //                       style: TextStyle(color: whiteText, fontSize: TEXT_REGULAR - 1),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     }))
  //     // ..animatedFunc = (child, animation) {
  //     //   return ScaleTransition(
  //     //     scale: Tween(begin: 0.0, end: 1.0).animate(animation),
  //     //     child: child,
  //     //   );
  //     // }
  //     ..animatedFunc = (child, animation) {
  //       return FadeTransition(
  //         opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
  //         child: child,
  //       );
  //     }
  //     ..show();
  // }

  // static YYDialog showAlredyHaveDialog({required BuildContext context, required Function(int) onUpdate}) {
  //   var yyDialog = YYDialog();
  //   var amount = "";

  //   return yyDialog.build()
  //     ..width = 320
  //     ..backgroundColor = Theme.of(context).scaffoldBackgroundColor
  //     ..borderRadius = MARGIN_MEDIUM
  //     ..showCallBack = () {}
  //     ..dismissCallBack = () {}
  //     ..widget(Builder(builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(vertical: MARGIN_MEDIUM_2, horizontal: MARGIN_MEDIUM_2),
  //         child: SizedBox(
  //           width: double.infinity,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               InterText("Update Already Have Amount",
  //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: TEXT_REGULAR_2X)),
  //               SizedBox(height: MARGIN_MEDIUM),
  //               Divider(height: MARGIN_MEDIUM_2),
  //               SizedBox(height: MARGIN_MEDIUM),
  //               SimpleNumberField(
  //                   hint: "100",
  //                   onChanged: (text) {
  //                     amount = text;
  //                   }),
  //               SizedBox(height: MARGIN_MEDIUM_2),
  //               Row(
  //                 children: [
  //                   Spacer(),
  //                   TextButton(
  //                     style: ButtonStyle(
  //                       overlayColor: MaterialStateColor.resolveWith((states) => blackBackground.withOpacity(0.1)),
  //                       shape: MaterialStatePropertyAll(
  //                         RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
  //                         ),
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       yyDialog.dismiss();
  //                     },
  //                     child: InterText(AppLocalizations.of(context)!.cancel),
  //                   ),
  //                   SizedBox(width: MARGIN_MEDIUM_2),
  //                   FilledButton(
  //                     style: ButtonStyle(
  //                         backgroundColor: MaterialStatePropertyAll(primaryRed),
  //                         shape: MaterialStatePropertyAll(
  //                             RoundedRectangleBorder(borderRadius: BorderRadius.circular(MARGIN_MEDIUM)))),
  //                     onPressed: () {
  //                       if (amount.trim().isNotEmpty) {
  //                         onUpdate(int.parse(amount));
  //                       }
  //                       yyDialog.dismiss();
  //                     },
  //                     child: InterText(
  //                       AppLocalizations.of(context)!.update,
  //                       style: TextStyle(color: whiteText, fontSize: TEXT_REGULAR - 1),
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       );
  //     }))
  //     // ..animatedFunc = (child, animation) {
  //     //   return ScaleTransition(
  //     //     scale: Tween(begin: 0.0, end: 1.0).animate(animation),
  //     //     child: child,
  //     //   );
  //     // }
  //     ..animatedFunc = (child, animation) {
  //       return FadeTransition(
  //         opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
  //         child: child,
  //       );
  //     }
  //     ..show();
  // }

}
