import 'package:flutter/material.dart';

// ======================== Directional padding =======================
/// Extension to get the same padding from all the sides
extension PaddingAllDirectionalExt on num {
  EdgeInsetsDirectional get allPaddingDirectional {
    return EdgeInsetsDirectional.all(
      toDouble(),
    );
  }
}

/// Extension to get different padding from all the sides
extension PaddingOnlyDirectionalExt on (num, num, num, num) {
  EdgeInsetsDirectional get onlyPaddingDirectional {
    return EdgeInsetsDirectional.only(
      start: $1.toDouble(),
      end: $2.toDouble(),
      top: $3.toDouble(),
      bottom: $4.toDouble(),
    );
  }
}

/// Extension to get Symmertic padding from the sides
extension PaddingSymmetricDirectionalExt on (num, num) {
  EdgeInsetsDirectional get symmetricPaddingDirectional {
    return EdgeInsetsDirectional.symmetric(
      horizontal: $1.toDouble(),
      vertical: $2.toDouble(),
    );
  }
}

// =========================== Simple padding ========================
extension PaddingAllExt on num {
  EdgeInsets get allPadding {
    return EdgeInsets.all(
      toDouble(),
    );
  }
}

/// Extension to get different padding from all the sides
extension PaddingOnlyExt on (num, num, num, num) {
  EdgeInsets get onlyPadding {
    return EdgeInsets.only(
      right: $1.toDouble(),
      left: $2.toDouble(),
      top: $3.toDouble(),
      bottom: $4.toDouble(),
    );
  }
}

/// Extension to get Symmertic padding from the sides
extension PaddingSymmetricExt on (num, num) {
  EdgeInsets get symmetricPadding {
    return EdgeInsets.symmetric(
      horizontal: $1.toDouble(),
      vertical: $2.toDouble(),
    );
  }
}
