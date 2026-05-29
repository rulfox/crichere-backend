import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crichere_flutter/core/theme/crichere_design_tokens.dart';
import 'package:crichere_flutter/shared/widgets/cric/cric_widgets.dart';
import '../providers/admin_providers.dart';
import '../../domain/entities/admin_user.dart';

@RoutePage()
class AdminUsersScreen extends HookConsumerWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = useState<String?>(null);
    final controller = useTextEditingController();
    final usersAsync = ref.watch(adminUsersProvider(search.value));
    final repo = ref.watch(adminRepositoryProvider);

    Future<void> refresh() async => ref.invalidate(adminUsersProvider(search.value));

    Future<void> run(Future<void> Function() action, String ok) async {
      try {
        await action();
        await refresh();
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok)));
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
        }
      }
    }

    return Scaffold(
      backgroundColor: CricColor.appBg,
      appBar: CricAppBar(
        showLogo: false,
        title: 'USER MANAGEMENT',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: CricColor.textPrimary),
          onPressed: () => context.router.maybePop(),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(CricSpacing.page),
            child: TextField(
              controller: controller,
              style: CricTextStyle.body,
              textInputAction: TextInputAction.search,
              onSubmitted: (v) => search.value = v,
              decoration: CricDecoration.textField(hint: 'Search by name or phone').copyWith(
                prefixIcon: const Icon(Icons.search, color: CricColor.textDim),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: CricColor.textDim),
                  onPressed: () {
                    controller.clear();
                    search.value = null;
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: usersAsync.when(
              loading: () => const Center(child: CircularProgressIndicator(color: CricColor.gold)),
              error: (e, _) => CricErrorView(error: e),
              data: (users) {
                if (users.isEmpty) {
                  return Center(child: Text('No users found', style: CricTextStyle.body));
                }
                return RefreshIndicator(
                  color: CricColor.gold,
                  onRefresh: refresh,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: CricSpacing.page),
                    itemCount: users.length,
                    itemBuilder: (context, index) => _UserRow(
                      user: users[index],
                      onSetAdmin: (isAdmin) => run(
                        () => repo.setPlatformAdmin(users[index].id, isAdmin),
                        isAdmin ? 'Granted platform admin.' : 'Removed platform admin.',
                      ),
                      onSetSuspended: (suspended) => run(
                        () => repo.suspendUser(users[index].id, suspended),
                        suspended ? 'User suspended.' : 'User reinstated.',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _UserRow extends StatelessWidget {
  final AdminUser user;
  final void Function(bool isAdmin) onSetAdmin;
  final void Function(bool suspended) onSetSuspended;
  const _UserRow({required this.user, required this.onSetAdmin, required this.onSetSuspended});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CricSpacing.sm),
      child: CricCard(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            AvatarCircle(name: user.name ?? user.phone ?? '?', radius: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name ?? 'Unnamed', style: CricTextStyle.headingMd.copyWith(fontSize: 14)),
                  const SizedBox(height: 2),
                  Text(user.phone ?? user.email ?? '', style: CricTextStyle.caption),
                ],
              ),
            ),
            if (user.suspended)
              const Padding(
                padding: EdgeInsets.only(right: 4),
                child: CricBadge(label: 'SUSPENDED', type: CricBadgeType.red),
              ),
            PopupMenuButton<String>(
              color: CricColor.slate2,
              icon: const Icon(Icons.more_vert, color: CricColor.textDim),
              onSelected: (value) {
                switch (value) {
                  case 'admin_add':
                    onSetAdmin(true);
                  case 'admin_remove':
                    onSetAdmin(false);
                  case 'suspend':
                    onSetSuspended(true);
                  case 'reinstate':
                    onSetSuspended(false);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'admin_add', child: Text('Make platform admin', style: CricTextStyle.body)),
                PopupMenuItem(value: 'admin_remove', child: Text('Remove platform admin', style: CricTextStyle.body)),
                if (user.suspended)
                  PopupMenuItem(value: 'reinstate', child: Text('Reinstate user', style: CricTextStyle.body))
                else
                  PopupMenuItem(
                    value: 'suspend',
                    child: Text('Suspend user', style: CricTextStyle.body.copyWith(color: CricColor.red)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
