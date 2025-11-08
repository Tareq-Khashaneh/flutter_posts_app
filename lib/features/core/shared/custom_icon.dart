// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import '../constants/app_colors.dart';
//
// class CustomIcon extends StatelessWidget {
//   CustomIcon(
//       {super.key,
//       this.image,
//       this.circleColor,
//       this.imageColor,
//       this.icon,
//       this.padding,
//         this.heightCircle,
//         this.widthCircle,
//         this.onTap,
//       this.imageWidth = 40.0});
//   String? image;
//   Color? circleColor;
//   Color? imageColor;
//   Widget? icon;
//   double imageWidth;
//   double? heightCircle;
//   double? widthCircle;
//   EdgeInsets? padding;
//   Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: heightCircle,
//           width: widthCircle,
//         padding: padding ?? const EdgeInsets.all(10),
//         decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             // border: circleColor != null
//             //     ? Border.all(color: AppColors.kSecondColorGrey2)
//             //     : null,
//             color: circleColor ?? AppColors.primary),
//         child: image == null
//             ? icon
//             : SvgPicture.asset(
//                 image!,
//                 width: imageWidth,
//                 color: imageColor ?? Colors.white,
//               ),
//       ),
//     );
//   }
// }
