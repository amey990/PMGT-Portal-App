// import 'package:flutter/material.dart';

// class CustomTextField extends StatefulWidget {
//   final String label;
//   final TextEditingController controller;
//   final bool readOnly;
//   final bool showAction;            // whether to show EDIT/SAVE
//   final VoidCallback? onActionTap;  // callback when tapping EDIT/SAVE
//   final String actionLabel;         // “EDIT” or “SAVE”
//   final TextInputType keyboardType;

//   const CustomTextField({
//     super.key,
//     required this.label,
//     required this.controller,
//     this.readOnly = false,
//     this.showAction = false,
//     this.onActionTap,
//     this.actionLabel = '',
//     this.keyboardType = TextInputType.text,
//   });

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.label,
//             style: const TextStyle(color: Colors.white70, fontSize: 14)),
//         const SizedBox(height: 8),
//         TextField(
//           controller: widget.controller,
//           readOnly: widget.readOnly,
//           keyboardType: widget.keyboardType,
//           style: const TextStyle(color: Colors.white, fontSize: 16),
//           decoration: InputDecoration(
//             hintText: widget.label,
//             hintStyle: const TextStyle(color: Colors.white30),
//             filled: true,
//             fillColor: Colors.white12,
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide.none,
//             ),
//             suffix: widget.showAction
//                 ? GestureDetector(
//                     onTap: widget.onActionTap,
//                     child: Text(
//                       widget.actionLabel,
//                       style: const TextStyle(
//                         color: Color(0xFFFFD700),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class CustomTextField extends StatefulWidget {
//   final String label;
//   final TextEditingController controller;
//   final bool readOnly;
//   final bool showAction;            // whether to show EDIT/SAVE
//   final VoidCallback? onActionTap;  // callback when tapping EDIT/SAVE
//   final String actionLabel;         // “EDIT” or “SAVE”
//   final TextInputType keyboardType;

//   const CustomTextField({
//     super.key,
//     required this.label,
//     required this.controller,
//     this.readOnly = false,
//     this.showAction = false,
//     this.onActionTap,
//     this.actionLabel = '',
//     this.keyboardType = TextInputType.text,
//   });

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(widget.label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
//         const SizedBox(height: 8),
//         TextField(
//           controller: widget.controller,
//           readOnly: widget.readOnly,
//           keyboardType: widget.keyboardType,
//           style: TextStyle(color: cs.onSurface, fontSize: 16),
//           decoration: InputDecoration(
//             hintText: widget.label,
//             hintStyle: TextStyle(color: cs.onSurfaceVariant),
//             filled: true,
//             // Use M3 container color that adapts to light/dark
//             fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide: BorderSide.none,
//             ),
//             suffix: widget.showAction
//                 ? GestureDetector(
//                     onTap: widget.onActionTap,
//                     child: Text(
//                       widget.actionLabel,
//                       style: TextStyle(
//                         color: cs.primary,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool readOnly;
  final bool showAction;            // whether to show EDIT/SAVE
  final VoidCallback? onActionTap;  // callback when tapping EDIT/SAVE
  final String actionLabel;         // “EDIT” or “SAVE”
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.readOnly = false,
    this.showAction = false,
    this.onActionTap,
    this.actionLabel = '',
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    OutlineInputBorder b(Color c, [double w = 1]) =>
        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: c, width: w));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          readOnly: widget.readOnly,
          keyboardType: widget.keyboardType,
          style: TextStyle(color: cs.onSurface, fontSize: 16),
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: TextStyle(color: cs.onSurfaceVariant),
            filled: true,
            // safer fill for both modes
            fillColor: cs.surfaceContainerHigh,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: b(cs.outline),
            disabledBorder: b(cs.outlineVariant),
            focusedBorder: b(cs.primary, 1.4),
            border: b(cs.outline),
            suffix: widget.showAction
                ? GestureDetector(
                    onTap: widget.onActionTap,
                    child: Text(
                      widget.actionLabel,
                      style: TextStyle(color: cs.primary, fontWeight: FontWeight.bold),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
