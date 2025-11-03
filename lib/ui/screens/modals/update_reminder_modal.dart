// // lib/ui/screens/reminders/update_reminder_modal.dart
// import 'package:flutter/material.dart';
// import 'package:pmgt/core/theme.dart';

// /// Payload you get back when the dialog closes (update or delete).
// enum ModalAction { update, delete }

// class ModalReminderResult {
//   final ModalAction action;
//   final ModalReminder? data; // present for update
//   ModalReminderResult(this.action, this.data);
// }

// /// Minimal model the modal edits.
// class ModalReminder {
//   final int id;
//   String projectName;
//   String type; // 'Team' | 'Personal'
//   String dateDDMMYYYY; // e.g. 23/07/2025
//   String timeHHMMAP;   // e.g. 10:00 AM
//   String description;

//   ModalReminder({
//     required this.id,
//     required this.projectName,
//     required this.type,
//     required this.dateDDMMYYYY,
//     required this.timeHHMMAP,
//     required this.description,
//   });
// }

// class UpdateReminderModal extends StatefulWidget {
//   final ModalReminder initial;
//   final List<String> projectOptions;

//   const UpdateReminderModal({
//     super.key,
//     required this.initial,
//     required this.projectOptions,
//   });

//   @override
//   State<UpdateReminderModal> createState() => _UpdateReminderModalState();
// }

// class _UpdateReminderModalState extends State<UpdateReminderModal> {
//   late ModalReminder form;

//   @override
//   void initState() {
//     super.initState();
//     form = ModalReminder(
//       id: widget.initial.id,
//       projectName: widget.initial.projectName,
//       type: widget.initial.type,
//       dateDDMMYYYY: widget.initial.dateDDMMYYYY,
//       timeHHMMAP: widget.initial.timeHHMMAP,
//       description: widget.initial.description,
//     );
//   }

//   Future<void> _pickDate() async {
//     // parse DD/MM/YYYY
//     final parts = form.dateDDMMYYYY.split('/');
//     final now = DateTime.now();
//     final init = parts.length == 3
//         ? DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]))
//         : now;

//     final picked = await showDatePicker(
//       context: context,
//       initialDate: init,
//       firstDate: DateTime(now.year - 1),
//       lastDate: DateTime(now.year + 3),
//     );
//     if (picked != null) {
//       setState(() {
//         form.dateDDMMYYYY =
//             '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
//       });
//     }
//   }

//   Future<void> _pickTime() async {
//     // try parse "hh:mm AM/PM"
//     TimeOfDay initial;
//     try {
//       final t = form.timeHHMMAP.split(' ');
//       final hm = t[0].split(':');
//       var h = int.parse(hm[0]);
//       final m = int.parse(hm[1]);
//       final isPM = (t.length > 1 ? t[1].toUpperCase() : 'AM') == 'PM';
//       if (isPM && h < 12) h += 12;
//       if (!isPM && h == 12) h = 0;
//       initial = TimeOfDay(hour: h, minute: m);
//     } catch (_) {
//       initial = TimeOfDay.now();
//     }

//     final picked = await showTimePicker(context: context, initialTime: initial);
//     if (picked != null) {
//       final local = picked.format(context); // already returns 10:00 AM, etc.
//       setState(() => form.timeHHMMAP = local);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Dialog(
//       insetPadding: const EdgeInsets.symmetric(horizontal: 20),
//       backgroundColor: cs.surface,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 520),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Title
//               Row(
//                 children: [
//                   Text('Update Reminder',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.w800,
//                             color: cs.onSurface,
//                           )),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // Form grid
//               LayoutBuilder(builder: (context, c) {
//                 final twoCol = c.maxWidth > 440;
//                 final children = [
//                   _LabeledBox(
//                     label: 'Date',
//                     child: _BoxButton(
//                       text: form.dateDDMMYYYY,
//                       icon: Icons.event,
//                       onTap: _pickDate,
//                     ),
//                   ),
//                   _LabeledBox(
//                     label: 'Time',
//                     child: _BoxButton(
//                       text: form.timeHHMMAP,
//                       icon: Icons.access_time,
//                       onTap: _pickTime,
//                     ),
//                   ),
//                   _LabeledBox(
//                     label: 'Project',
//                     child: _DropdownBox<String>(
//                       value: form.projectName.isEmpty ? null : form.projectName,
//                       items: widget.projectOptions,
//                       onChanged: (v) => setState(() => form.projectName = v ?? ''),
//                     ),
//                   ),
//                   _LabeledBox(
//                     label: 'Type',
//                     child: _DropdownBox<String>(
//                       value: form.type,
//                       items: const ['Team', 'Personal'],
//                       onChanged: (v) => setState(() => form.type = v ?? 'Team'),
//                     ),
//                   ),
//                   _LabeledBox(
//                     label: 'Description',
//                     spanFull: true,
//                     child: TextField(
//                       controller: TextEditingController(text: form.description)
//                         ..selection = TextSelection.fromPosition(
//                           TextPosition(offset: form.description.length),
//                         ),
//                       onChanged: (v) => form.description = v,
//                       minLines: 2,
//                       maxLines: 4,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: cs.surfaceVariant.withOpacity(0.2),
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: cs.outlineVariant),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: cs.outlineVariant),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: AppTheme.accentColor),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ];

//                 if (!twoCol) {
//                   return Column(children: children.map((w) => Padding(padding: const EdgeInsets.only(bottom: 10), child: w)).toList());
//                 }
//                 // simple two column grid
//                 return Wrap(
//                   runSpacing: 10,
//                   spacing: 10,
//                   children: children.map((w) {
//                     if (w is _LabeledBox && w.spanFull) {
//                       return SizedBox(width: c.maxWidth, child: w);
//                     }
//                     return SizedBox(width: (c.maxWidth - 10) / 2, child: w);
//                   }).toList(),
//                 );
//               }),

//               const SizedBox(height: 12),

//               // Footer actions
//               Row(
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: const Text('Cancel'),
//                   ),
//                   const Spacer(),
//                   TextButton(
//                     onPressed: () => Navigator.pop(
//                       context,
//                       ModalReminderResult(ModalAction.delete, form),
//                     ),
//                     style: TextButton.styleFrom(foregroundColor: Colors.red),
//                     child: const Text('Delete'),
//                   ),
//                   const SizedBox(width: 8),
//                   ElevatedButton(
//                     onPressed: () => Navigator.pop(
//                       context,
//                       ModalReminderResult(ModalAction.update, form),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppTheme.accentColor,
//                       foregroundColor: Colors.black,
//                     ),
//                     child: const Text('Update'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /* ---------- small helpers ---------- */

// class _LabeledBox extends StatelessWidget {
//   final String label;
//   final Widget child;
//   final bool spanFull;
//   const _LabeledBox({required this.label, required this.child, this.spanFull = false});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         child,
//       ],
//     );
//   }
// }

// class _BoxButton extends StatelessWidget {
//   final String text;
//   final IconData icon;
//   final VoidCallback onTap;
//   const _BoxButton({required this.text, required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(10),
//       child: Container(
//         height: 46,
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//           color: cs.surfaceVariant.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         child: Row(
//           children: [
//             Expanded(child: Text(text, style: TextStyle(color: cs.onSurface))),
//             Icon(icon, color: cs.onSurfaceVariant),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _DropdownBox<T> extends StatelessWidget {
//   final T? value;
//   final List<T> items;
//   final ValueChanged<T?> onChanged;
//   const _DropdownBox({required this.value, required this.items, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       height: 46,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         color: cs.surfaceVariant.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: cs.outlineVariant),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<T>(
//           value: value,
//           isExpanded: true,
//           iconEnabledColor: cs.onSurfaceVariant,
//           dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//           style: TextStyle(color: cs.onSurface),
//           items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pmgt/core/api_client.dart';
import 'package:pmgt/state/user_session.dart';
import 'package:pmgt/core/theme.dart';

class ModalReminder {
  final int id;
  String projectName;
  String type; // 'Team' | 'Personal'
  String? ownerEmail;
  String reminderDate; // YYYY-MM-DD (input)
  String reminderTime; // HH:mm (input)
  String description;

  ModalReminder({
    required this.id,
    required this.projectName,
    required this.type,
    required this.ownerEmail,
    required this.reminderDate,
    required this.reminderTime,
    required this.description,
  });

  // factory ModalReminder.fromReminder(dynamic r) => ModalReminder(
  //   id: r.id,
  //   projectName: r.projectName,
  //   type:
  //       r.enumType == null
  //           ? 'Team'
  //           : (r.enumType == null
  //               ? 'Team'
  //               : (r.enumType.toString().endsWith('personal')
  //                   ? 'Personal'
  //                   : 'Team')),
  //   ownerEmail: r.ownerEmail,
  //   reminderDate: r.reminderDate, // already YYYY-MM-DD from API model
  //   reminderTime: _to24h(r.reminderTime),
  //   description: r.description,
  // );

  factory ModalReminder.fromReminder(dynamic r) => ModalReminder(
    id: r.id,
    projectName: r.projectName,
    // use raw string type if present; else fall back to enum
    type:
        (('${r.type}'.toLowerCase() == 'personal') ||
                ('${r.enumType}'.toLowerCase().endsWith('personal')))
            ? 'Personal'
            : 'Team',
    ownerEmail: r.ownerEmail,
    // normalize for a TextField/date input
    reminderDate: _toDateInput(r.reminderDate),
    // convert "hh:mm AM/PM" -> "HH:mm" for the TextField/time input
    reminderTime: _to24h(r.reminderTime),
    description: r.description,
  );

  static String _to24h(String display) {
    // "hh:mm AM/PM" -> "HH:mm"
    if (!display.contains(' ')) return display;
    final parts = display.split(' ');
    final hm = parts[0].split(':');
    int h = int.tryParse(hm[0]) ?? 0;
    final m = hm[1];
    final ampm = parts[1].toUpperCase();
    if (ampm == 'PM' && h < 12) h += 12;
    if (ampm == 'AM' && h == 12) h = 0;
    return '${h.toString().padLeft(2, '0')}:$m';
  }

  // "2025-11-03T00:00:00.000Z" or "2025-11-03" -> "2025-11-03"
  static String _toDateInput(String raw) {
    if (raw.isEmpty) return raw;
    try {
      final dt = DateTime.parse(raw).toLocal();
      final y = dt.year.toString().padLeft(4, '0');
      final m = dt.month.toString().padLeft(2, '0');
      final d = dt.day.toString().padLeft(2, '0');
      return '$y-$m-$d';
    } catch (_) {
      // Fallback: take date part before 'T' if present
      return raw.split('T').first;
    }
  }
}

class UpdateReminderModal extends StatefulWidget {
  final ModalReminder reminder;
  final List<String> projectOptions;
  final Future<void> Function(dynamic fresh)? onUpdated;
  final Future<void> Function()? onDeleted;

  const UpdateReminderModal({
    super.key,
    required this.reminder,
    required this.projectOptions,
    this.onUpdated,
    this.onDeleted,
  });

  @override
  State<UpdateReminderModal> createState() => _UpdateReminderModalState();
}

class _UpdateReminderModalState extends State<UpdateReminderModal> {
  late ModalReminder form;
  bool _busy = false;

  ApiClient get _api => context.read<ApiClient>();
  UserSession get _session => context.read<UserSession>();

  @override
  void initState() {
    super.initState();
    form = ModalReminder(
      id: widget.reminder.id,
      projectName: widget.reminder.projectName,
      type: widget.reminder.type,
      ownerEmail: widget.reminder.ownerEmail,
      reminderDate: widget.reminder.reminderDate,
      reminderTime: widget.reminder.reminderTime,
      description: widget.reminder.description,
    );
  }

  String _fmtTimeForDisplay(String hhmm) {
    // "HH:mm" -> "hh:mm AM/PM"
    final sp = hhmm.split(':');
    int h = int.tryParse(sp[0]) ?? 0;
    final m = sp[1];
    final mer = h >= 12 ? 'PM' : 'AM';
    int h12 = h % 12;
    if (h12 == 0) h12 = 12;
    return '${h12.toString().padLeft(2, '0')}:$m $mer';
  }

  Future<void> _update() async {
    setState(() => _busy = true);
    try {
      final payload = {
        'project_name': form.projectName,
        'type': form.type.toLowerCase(), // team/personal
        'reminder_date': form.reminderDate,
        'reminder_time': _fmtTimeForDisplay(form.reminderTime),
        'description': form.description.trim(),
        if (form.type == 'Personal' && (_session.email ?? '').isNotEmpty)
          'owner_email': _session.email,
      };

      final res = await _api.put('/api/reminders/${form.id}', body: payload);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final fresh = jsonDecode(res.body);
        if (mounted) Navigator.pop(context);
        if (widget.onUpdated != null) await widget.onUpdated!(fresh);
      } else {
        _toast('Update failed');
      }
    } catch (_) {
      _toast('Update failed');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _delete() async {
    setState(() => _busy = true);
    try {
      final isPersonal = form.type == 'Personal';
      final res = await _api.delete(
        '/api/reminders/${form.id}',
        query: isPersonal ? {'owner_email': _session.email ?? ''} : null,
      );
      if (res.statusCode >= 200 && res.statusCode < 300) {
        if (mounted) Navigator.pop(context);
        if (widget.onDeleted != null) await widget.onDeleted!();
      } else {
        _toast('Delete failed');
      }
    } catch (_) {
      _toast('Delete failed');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String msg) {
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg, style: TextStyle(color: cs.onSurface))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final body = Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        top: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: cs.outlineVariant,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(
            'Update Reminder',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),

          // grid-ish
          Row(
            children: [
              Expanded(
                child: _Labeled(
                  label: 'Date',
                  child: TextField(
                    controller: TextEditingController(text: form.reminderDate),
                    onChanged: (v) => form.reminderDate = v,
                    keyboardType: TextInputType.datetime,
                    decoration: _boxDeco(context, hint: 'YYYY-MM-DD'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Labeled(
                  label: 'Time',
                  child: TextField(
                    controller: TextEditingController(text: form.reminderTime),
                    onChanged: (v) => form.reminderTime = v,
                    keyboardType: TextInputType.datetime,
                    decoration: _boxDeco(context, hint: 'HH:mm'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _Labeled(
                  label: 'Project',
                  child: Container(
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: cs.outlineVariant),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value:
                            form.projectName.isEmpty ? null : form.projectName,
                        isExpanded: true,
                        items:
                            widget.projectOptions
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                        hint: Text(
                          'Select',
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                        onChanged:
                            (v) => setState(() => form.projectName = v ?? ''),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Labeled(
                  label: 'Type',
                  child: Container(
                    decoration: BoxDecoration(
                      color: cs.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: cs.outlineVariant),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: form.type,
                        isExpanded: true,
                        items: const [
                          DropdownMenuItem(value: 'Team', child: Text('Team')),
                          DropdownMenuItem(
                            value: 'Personal',
                            child: Text('Personal'),
                          ),
                        ],
                        onChanged:
                            (v) => setState(() => form.type = v ?? 'Team'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          _Labeled(
            label: 'Description',
            child: TextField(
              controller: TextEditingController(text: form.description),
              onChanged: (v) => form.description = v,
              maxLines: 3,
              decoration: _boxDeco(context),
            ),
          ),
          const SizedBox(height: 14),

          Row(
            children: [
              OutlinedButton(
                onPressed: _busy ? null : _delete,
                style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _busy ? null : _update,
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: Colors.black,
                ),
                child: const Text('Update'),
              ),
            ],
          ),
        ],
      ),
    );

    return SafeArea(child: body);
  }

  InputDecoration _boxDeco(BuildContext context, {String? hint}) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      hintText: hint,
      isDense: true,
      filled: true,
      fillColor: cs.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppTheme.accentColor),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}

class _Labeled extends StatelessWidget {
  final String label;
  final Widget child;
  const _Labeled({required this.label, required this.child});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: cs.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
