import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testovoecz/themes/app_colors.dart';

abstract class TextStyles {
  static final main = GoogleFonts.raleway(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static final mainBlue = GoogleFonts.raleway(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: AppColors.accentPrimaryBase,
  );

  static final body = GoogleFonts.raleway(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static final bodyHint = GoogleFonts.raleway(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.textPlaceHolder,
  );
}
