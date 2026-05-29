import 'package:flutter/material.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/features/auth/data/models/auth_response.dart';
import 'package:crichere_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'cric/cric_widgets.dart';

/// Searches users (`GET /users/search`) and lets the caller pick one.
/// Returns the selected [AuthResponse], or null if dismissed.
Future<AuthResponse?> showUserPicker(
  BuildContext context,
  AuthRepository repo, {
  String title = 'Select a user',
}) {
  return showDialog<AuthResponse>(
    context: context,
    builder: (_) => _UserPickerDialog(repo: repo, title: title),
  );
}

class _UserPickerDialog extends StatefulWidget {
  final AuthRepository repo;
  final String title;
  const _UserPickerDialog({required this.repo, required this.title});

  @override
  State<_UserPickerDialog> createState() => _UserPickerDialogState();
}

class _UserPickerDialogState extends State<_UserPickerDialog> {
  final _controller = TextEditingController();
  List<AuthResponse> _results = const [];
  bool _loading = false;
  String? _error;

  Future<void> _search() async {
    final q = _controller.text.trim();
    if (q.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final page = await widget.repo.searchUsers(q, page: 0, size: 20);
      if (mounted) setState(() => _results = page.content);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CricColor.slate2,
      title: Text(widget.title, style: CricTextStyle.headingMd),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              style: CricTextStyle.body,
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _search(),
              decoration: CricDecoration.textField(hint: 'Search by name or phone').copyWith(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: CricColor.gold),
                  onPressed: _search,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 280,
              child: _loading
                  ? const Center(child: CircularProgressIndicator(color: CricColor.gold))
                  : _error != null
                      ? Center(child: Text(_error!, style: CricTextStyle.caption))
                      : _results.isEmpty
                          ? Center(child: Text('Search to find users', style: CricTextStyle.caption))
                          : ListView.builder(
                              itemCount: _results.length,
                              itemBuilder: (context, index) {
                                final u = _results[index];
                                return ListTile(
                                  leading: AvatarCircle(name: u.name ?? u.phone ?? '?', radius: 16),
                                  title: Text(u.name ?? 'Unnamed', style: CricTextStyle.body),
                                  subtitle: Text(u.phone ?? '', style: CricTextStyle.caption),
                                  onTap: () => Navigator.pop(context, u),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('CANCEL', style: CricTextStyle.badge.copyWith(color: CricColor.textDim)),
        ),
      ],
    );
  }
}
