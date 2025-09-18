// import 'package:flutter/material.dart';

// class GradientButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final double height;
//   final double fontSize;

//   const GradientButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.height = 50,
//     this.fontSize = 16,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         height: height,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xFFF8DF6C),
//               Color(0xFFEDD545),
//               Color(0xFFE4C303),
//               Color(0xFFCDB004),
//               Color(0xFFC8AC08),
//             ],
//             stops: [0.0, 0.24, 0.47, 0.67, 1.0],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: fontSize,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// class GradientButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final double height;
//   final double fontSize;

//   const GradientButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.height = 50,
//     this.fontSize = 16,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         height: height,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xFFF8DF6C),
//               Color(0xFFEDD545),
//               Color(0xFFE4C303),
//               Color(0xFFCDB004),
//               Color(0xFFC8AC08),
//             ],
//             stops: [0.0, 0.24, 0.47, 0.67, 1.0],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             if (!isDark)
//               const BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
//           ],
//         ),
//         alignment: Alignment.center,
//         child: Text(
//           text,
//           style: TextStyle(
//             color: Colors.black, // readable on the gold gradient
//             fontSize: fontSize,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double fontSize;
  final BorderRadiusGeometry borderRadius;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 50,
    this.fontSize = 16,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Semantics(
      button: true,
      label: text,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFF8DF6C),
                Color(0xFFEDD545),
                Color(0xFFE4C303),
                Color(0xFFCDB004),
                Color(0xFFC8AC08),
              ],
              stops: [0.0, 0.24, 0.47, 0.67, 1.0],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: borderRadius,
            boxShadow: [if (!isDark) const BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
