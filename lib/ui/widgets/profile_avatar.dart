import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../core/api_client.dart';
import '../../state/user_session.dart';

/// In-memory cache so we don't hit the API on every rebuild.
class _AvatarCache {
  static final Map<String, String?> _byEmail = {};
  static String? get(String email) => _byEmail[email];
  static void set(String email, String? url) => _byEmail[email] = url;
}

/// Small widget that shows the user's profile picture if available,
/// otherwise falls back to the default asset.
class ProfileAvatar extends StatefulWidget {
  final double size;              // e.g. 36
  final BoxFit fit;               // cover by default
  final String fallbackAsset;     // default avatar asset

  const ProfileAvatar({
    super.key,
    this.size = 36,
    this.fit = BoxFit.cover,
    this.fallbackAsset = 'assets/User_profile.png',
  });

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  String? _url;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _maybeLoad();
  }

  Future<void> _maybeLoad() async {
    final session = context.read<UserSession>();
    final api     = context.read<ApiClient>();
    final email   = session.email;

    if (email == null || email.isEmpty) return;

    // serve from memory first
    final cached = _AvatarCache.get(email);
    if (cached != null) {
      setState(() => _url = cached);
      return;
    }

    setState(() => _loading = true);
    try {
      final res = await http.get(
        Uri.parse('${api.baseUrl}/api/user-profile/${Uri.encodeComponent(email)}'),
        headers: {
          // Usually not needed for static files, but OK for the JSON call.
          if ((await api.getToken())?.isNotEmpty == true)
            'Authorization': 'Bearer ${await api.getToken()}',
        },
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        final m   = jsonDecode(res.body) as Map;
        final up  = (m['user_profile'] as Map?) ?? {};
        final pic = (up['profile_picture'] ?? '').toString();
        final url = pic.isEmpty ? null : (api.baseUrl + pic);

        _AvatarCache.set(email, url);
        if (mounted) setState(() => _url = url);
      }
    } catch (_) {
      // ignore; will fall back to asset
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final child = (_url != null && _url!.isNotEmpty)
        ? Image.network(
            _url!,
            width: widget.size,
            height: widget.size,
            fit: widget.fit,
            // if the URL 404s, fall back to asset
            errorBuilder: (_, __, ___) => Image.asset(
              widget.fallbackAsset,
              width: widget.size,
              height: widget.size,
              fit: widget.fit,
            ),
          )
        : Image.asset(
            widget.fallbackAsset,
            width: widget.size,
            height: widget.size,
            fit: widget.fit,
          );

    return ClipOval(
      child: _loading
          ? SizedBox(
              width: widget.size,
              height: widget.size,
              child: const CircularProgressIndicator(strokeWidth: 2),
            )
          : child,
    );
  }
}
