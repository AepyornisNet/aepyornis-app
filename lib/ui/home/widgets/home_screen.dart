import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:aepyornis_app/domain/models/workout/workout.dart';
import 'package:aepyornis_app/domain/models/workout_reply/workout_reply.dart';
import 'package:aepyornis_app/l10n/app_localizations.dart';
import 'package:aepyornis_app/routing/routes.dart';
import 'package:aepyornis_app/ui/core/utils/formatters.dart';
import 'package:aepyornis_app/ui/home/view_models/home_viewmodel.dart';
import 'package:aepyornis_app/ui/workout/detail/widgets/workout_detail_map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: widget.viewModel.savedScrollOffset,
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    widget.viewModel.savedScrollOffset = _scrollController.offset;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      widget.viewModel.loadMoreFeed();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, _) {
                  final unreadCount = widget.viewModel.unreadNotificationsCount;
                  return Row(
                    children: [
                      SegmentedButton<String>(
                        segments: [
                          ButtonSegment<String>(
                            value: 'following',
                            label: Text(l10n?.following ?? 'Following'),
                            icon: const Icon(Icons.people_outline, size: 18),
                          ),
                          ButtonSegment<String>(
                            value: 'global',
                            label: Text(l10n?.global ?? 'Global'),
                            icon: const Icon(Icons.public, size: 18),
                          ),
                        ],
                        selected: {widget.viewModel.feedScope},
                        onSelectionChanged: (Set<String> newSelection) {
                          if (newSelection.isNotEmpty) {
                            widget.viewModel.setFeedScope(newSelection.first);
                          }
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Badge(
                          isLabelVisible: unreadCount > 0,
                          label: Text('$unreadCount'),
                          child: const Icon(Icons.notifications_outlined),
                        ),
                        tooltip: l10n?.notifications ?? 'Notifications',
                        onPressed: () async {
                          await context.push(Routes.notifications);
                          widget.viewModel.loadUnreadNotificationsCount();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: ListenableBuilder(
                listenable: widget.viewModel,
                builder: (context, _) {
                  final vm = widget.viewModel;

                  if (vm.isLoading && vm.workouts.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (vm.errorMessage != null && vm.workouts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 48, color: colorScheme.error),
                            const SizedBox(height: 12),
                            Text(
                              l10n?.failedToLoadFeed ?? 'Failed to load feed',
                              style: theme.textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              vm.errorMessage!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: vm.loadInitialFeed,
                              icon: const Icon(Icons.refresh),
                              label: Text(l10n?.tryAgain ?? 'Try Again'),
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  if (vm.workouts.isEmpty) {
                    return RefreshIndicator(
                      onRefresh: vm.loadInitialFeed,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.fitness_center_outlined,
                                      size: 64,
                                      color: colorScheme.onSurfaceVariant
                                          .withValues(alpha: 0.5)),
                                  const SizedBox(height: 16),
                                  Text(
                                    l10n?.noActivitiesFound ??
                                        'No activities found',
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    vm.feedScope == 'following'
                                        ? (l10n?.emptyFeedFollowing ??
                                            'Follow users to see their activities here.')
                                        : (l10n?.emptyFeedGlobal ??
                                            'No global activities yet.'),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: vm.loadInitialFeed,
                    child: ListView.separated(
                      key: const PageStorageKey('home_feed_list'),
                      controller: _scrollController,
                      padding: const EdgeInsets.only(top: 4, bottom: 24),
                      itemCount:
                          vm.workouts.length + (vm.isLoadingMore ? 1 : 0),
                      separatorBuilder: (context, index) => Container(
                        height: 8,
                        color: colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.3),
                      ),
                      itemBuilder: (context, index) {
                        if (index == vm.workouts.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final workout = vm.workouts[index];
                        return _FeedPostItem(
                          workout: workout,
                          viewModel: vm,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedPostItem extends StatefulWidget {
  const _FeedPostItem({
    required this.workout,
    required this.viewModel,
  });

  final Workout workout;
  final HomeViewModel viewModel;

  @override
  State<_FeedPostItem> createState() => _FeedPostItemState();
}

class _FeedPostItemState extends State<_FeedPostItem> {
  bool _commentsExpanded = false;

  void _toggleComments() {
    setState(() {
      _commentsExpanded = !_commentsExpanded;
    });

    if (_commentsExpanded && widget.workout.id != null) {
      widget.viewModel.loadReplies(widget.workout.id!);
    }
  }

  String _formatAuthorName(Workout workout, BuildContext context) {
    final user = workout.user;
    if (user != null) {
      final name = user.name.trim();
      if (name.isNotEmpty) return name;
      final handle = user.handle.trim();
      if (handle.isNotEmpty) return handle;
      final username = user.username.trim();
      if (username.isNotEmpty) return username;
    }
    return AppLocalizations.of(context)?.athlete ?? 'Athlete';
  }

  String? _getAttachmentUrl(Workout workout) {
    if (workout.attachments.isNotEmpty &&
        workout.attachments.first.url != null) {
      return widget.viewModel.resolveUrl(workout.attachments.first.url);
    }
    return null;
  }

  String? _getUserAvatarUrl(Workout workout) {
    return widget.viewModel.resolveUrl(workout.user?.iconUrl);
  }

  bool _hasMapData(Workout workout) {
    final points = workout.data?.details?.points;
    if (points != null && points.isNotEmpty) {
      return points.any((p) => p.lat != 0.0 || p.lng != 0.0);
    }
    return workout.data?.center != null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final workout = widget.workout;
    final attachmentUrl = _getAttachmentUrl(workout);
    final avatarUrl = _getUserAvatarUrl(workout);

    final authHeaders = widget.viewModel.authHeaders;

    final l10n = AppLocalizations.of(context);

    final isOwn = widget.viewModel.isOwnWorkout(workout);

    return InkWell(
      onTap: workout.id != null
          ? () => context.push(Routes.workoutWithId(workout.id!))
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User header
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: colorScheme.primaryContainer,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(
                          avatarUrl,
                          headers: authHeaders.isNotEmpty ? authHeaders : null,
                        )
                      : null,
                  child: avatarUrl == null
                      ? Text(
                          _formatAuthorName(workout, context)
                              .characters
                              .first
                              .toUpperCase(),
                          style: TextStyle(
                            color: colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatAuthorName(workout, context),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (workout.addressString != null &&
                          workout.addressString!.isNotEmpty)
                        Text(
                          workout.addressString!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat.yMMMd().format(workout.date.toLocal()),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color:
                            colorScheme.primaryContainer.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(workout.type.icon,
                              size: 14, color: colorScheme.primary),
                          const SizedBox(width: 4),
                          Text(
                            workout.type.value.replaceAll('-', ' '),
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Title
            Text(
              workout.name,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: -0.3,
              ),
            ),

            const SizedBox(height: 12),

            // Key Stats Row
            Wrap(
              spacing: 10,
              runSpacing: 8,
              children: [
                if (workout.totalDistance > 0)
                  _StatBadge(
                    icon: Icons.straighten,
                    value:
                        '${(workout.totalDistance / 1000).toStringAsFixed(2)} km',
                  ),
                if (workout.totalDuration > 0)
                  _StatBadge(
                    icon: Icons.timer_outlined,
                    value: formatWorkoutDuration(workout.totalDuration),
                  ),
                if (workout.totalUp > 0)
                  _StatBadge(
                    icon: Icons.landscape,
                    value: '${workout.totalUp.toStringAsFixed(0)} m',
                  ),
                if (workout.totalWeight > 0)
                  _StatBadge(
                    icon: Icons.fitness_center,
                    value: '${workout.totalWeight.toStringAsFixed(1)} kg',
                  ),
                if (workout.totalRepetitions > 0)
                  _StatBadge(
                    icon: Icons.repeat,
                    value: '${workout.totalRepetitions}',
                  ),
              ],
            ),

            // Preview Image or Map Route
            if (attachmentUrl != null) ...[
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  attachmentUrl,
                  headers: authHeaders.isNotEmpty ? authHeaders : null,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 220,
                      color: colorScheme.surfaceContainerHighest,
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120,
                    color: colorScheme.surfaceContainerHighest,
                    child: Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ] else if (_hasMapData(workout)) ...[
              const SizedBox(height: 14),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: IgnorePointer(
                    child: WorkoutDetailMap(
                      workout: workout,
                      mapPadding: const EdgeInsets.all(20),
                    ),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 10),

            // Social Action Footer
            Row(
              children: [
                Text(
                  l10n?.likesAndComments(
                          workout.likesCount, workout.repliesCount) ??
                      '${workout.likesCount} likes • ${workout.repliesCount} comments',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (!isOwn)
                  IconButton(
                    icon: Icon(
                      workout.likedByMe
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: workout.likedByMe ? Colors.red : null,
                    ),
                    onPressed: () => widget.viewModel.toggleLike(workout),
                    tooltip: l10n?.like ?? 'Like',
                  ),
                IconButton(
                  icon: Icon(
                    _commentsExpanded
                        ? Icons.chat_bubble
                        : Icons.chat_bubble_outline,
                    color: _commentsExpanded ? colorScheme.primary : null,
                  ),
                  onPressed: _toggleComments,
                  tooltip: l10n?.comments ?? 'Comments',
                ),
              ],
            ),

            // Expanded Comments Drawer
            if (_commentsExpanded && workout.id != null) ...[
              const SizedBox(height: 8),
              _CommentSection(
                workoutId: workout.id!,
                viewModel: widget.viewModel,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({
    required this.icon,
    required this.value,
  });

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 6),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentSection extends StatefulWidget {
  const _CommentSection({
    required this.workoutId,
    required this.viewModel,
  });

  final int workoutId;
  final HomeViewModel viewModel;

  @override
  State<_CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<_CommentSection> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String _cleanHtml(String html) {
    return html
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .trim();
  }

  String _getReplyAuthor(WorkoutReply reply) {
    if (reply.user != null) {
      final name = reply.user!.name.trim();
      if (name.isNotEmpty) return name;
      if (reply.user!.username.isNotEmpty) return reply.user!.username;
    }
    if (reply.actorName != null && reply.actorName!.isNotEmpty) {
      return reply.actorName!;
    }
    return 'User';
  }

  String? _getReplyAvatarUrl(WorkoutReply reply) {
    final raw = reply.avatarUrl ?? reply.user?.iconUrl;
    return widget.viewModel.resolveUrl(raw);
  }

  Future<void> _submitComment() async {
    final text = _commentController.text;
    if (text.trim().isEmpty) return;

    final success = await widget.viewModel.postReply(widget.workoutId, text);
    if (success) {
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final replies = widget.viewModel.workoutReplies[widget.workoutId] ?? [];
    final isLoading =
        widget.viewModel.loadingReplies[widget.workoutId] ?? false;
    final isReplying =
        widget.viewModel.replyingState[widget.workoutId] ?? false;

    final authHeaders = widget.viewModel.authHeaders;

    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isLoading && replies.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            )
          else if (replies.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                l10n?.noCommentsYet ??
                    'No comments yet. Be the first to comment!',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: replies.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final reply = replies[index];
                final authorName = _getReplyAuthor(reply);
                final avatarUrl = _getReplyAvatarUrl(reply);
                final content = _cleanHtml(reply.content);

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: colorScheme.secondaryContainer,
                      backgroundImage: avatarUrl != null
                          ? NetworkImage(
                              avatarUrl,
                              headers:
                                  authHeaders.isNotEmpty ? authHeaders : null,
                            )
                          : null,
                      child: avatarUrl == null
                          ? Text(
                              authorName.characters.first.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.onSecondaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              authorName,
                              style: theme.textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              content,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: l10n?.addComment ?? 'Add a comment...',
                    isDense: true,
                    filled: true,
                    fillColor: colorScheme.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) => _submitComment(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                icon: isReplying
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.send, size: 18),
                onPressed: isReplying ? null : _submitComment,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
