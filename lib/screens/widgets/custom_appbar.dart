import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testovoecz/themes/app_colors.dart';
import 'package:testovoecz/themes/text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? trailing;
  final String? title;

  const CustomAppBar(this.leading, this.trailing, this.title, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: AppColors.textPlaceHolder,
          height: 1.0,
        ),
      ),
      elevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.background,
      ),
      centerTitle: true,
      backgroundColor: AppColors.background,
      leading: leading ?? const SizedBox.shrink(),
      title: Text(
        title ?? '',
        style: TextStyles.main,
      ),
      actions: [trailing ?? const SizedBox.shrink()],
    );
  }
}

//
//
// class CustomAppBar extends StatelessWidget {
//   final String title;
//   final Widget? leading;
//   final Widget? trailing;
//
//   const CustomAppBar({
//     super.key,
//     required this.title,
//     this.leading,
//     this.trailing,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       bottom: PreferredSize(
//         preferredSize: const Size.fromHeight(4.0),
//         child: Container(
//           color: AppColors.textPlaceHolder,
//           height: 1.0,
//         ),
//       ),
//       elevation: 0,
//       systemOverlayStyle: const SystemUiOverlayStyle(
//         statusBarColor: AppColors.background,
//       ),
//       centerTitle: true,
//       backgroundColor: AppColors.background,
//       leading: leading ?? const SizedBox.shrink(),
//       title: Text(
//         title,
//         style: TextStyles.main,
//       ),
//       actions: [trailing ?? const SizedBox.shrink()],
//     );
//   }
// }
