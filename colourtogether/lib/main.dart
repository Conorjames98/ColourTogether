import 'package:flutter/material.dart';

void main() {
  runApp(const ColourTogetherApp());
}

class ColourTogetherApp extends StatelessWidget {
  const ColourTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColourTogether',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00A896)),
        useMaterial3: true,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: const Color(0xFF1D262D),
          displayColor: const Color(0xFF1D262D),
        ),
      ),
      home: const LobbyScreen(),
    );
  }
}

class LobbyScreen extends StatefulWidget {
  const LobbyScreen({super.key});

  @override
  State<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  final TextEditingController _codeController = TextEditingController(
    text: 'SUNSET-123',
  );

  late final Map<String, RoomTemplate> _templates = {
    'SUNSET-123': RoomTemplate(
      code: 'SUNSET-123',
      name: 'Sunset Courtyard',
      description:
          'A warm layout split into sky, mountains, a calm river, and a cluster of trees.',
      gridRows: 4,
      gridCols: 3,
      zones: const [
        ColorZone(id: 'sky', label: 'Sky Band', row: 0, col: 0, colSpan: 3),
        ColorZone(id: 'sun', label: 'Sun Halo', row: 1, col: 0, colSpan: 1),
        ColorZone(id: 'mountain-left', label: 'Left Ridge', row: 1, col: 1),
        ColorZone(id: 'mountain-right', label: 'Right Ridge', row: 1, col: 2),
        ColorZone(id: 'river', label: 'River Run', row: 2, col: 0, colSpan: 2),
        ColorZone(id: 'trees', label: 'Tree Line', row: 2, col: 2, rowSpan: 2),
        ColorZone(
          id: 'meadow',
          label: 'Meadow Floor',
          row: 3,
          col: 0,
          colSpan: 2,
        ),
      ],
      tags: const ['Invite only', 'Collaborative', 'Cozy start'],
    ),
    'COAST-456': RoomTemplate(
      code: 'COAST-456',
      name: 'Coastal Mosaic',
      description:
          'A breezy beach scene divided into sky, water, dunes, rocks, and umbrellas.',
      gridRows: 3,
      gridCols: 4,
      zones: const [
        ColorZone(
          id: 'coast-sky',
          label: 'Skyline',
          row: 0,
          col: 0,
          colSpan: 4,
        ),
        ColorZone(id: 'clouds', label: 'Cloud Drift', row: 1, col: 0),
        ColorZone(id: 'sea', label: 'Sea Stretch', row: 1, col: 1, colSpan: 2),
        ColorZone(id: 'rocks', label: 'Rocks', row: 1, col: 3),
        ColorZone(id: 'dunes', label: 'Sand Dunes', row: 2, col: 0, colSpan: 2),
        ColorZone(id: 'umbrellas', label: 'Beach Umbrellas', row: 2, col: 2),
        ColorZone(id: 'shoreline', label: 'Shoreline', row: 2, col: 3),
      ],
      tags: const ['Invite only', 'Bright palette', 'Playful'],
    ),
  };

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _openRoom(RoomTemplate template) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => RoomScreen(template: template)));
  }

  void _handleJoin() {
    final typedCode = _codeController.text.trim().toUpperCase();
    final template = _templates[typedCode] ?? _templates.values.first;
    _openRoom(
      template.copyWith(code: typedCode.isEmpty ? template.code : typedCode),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ColourTogether'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroBanner(onStart: _handleJoin),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Join a room',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Enter an invite code to step into a shared canvas. We use predefined areas so every collaborator colors in the same places.',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _codeController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          labelText: 'Invite code',
                          hintText: 'e.g. SUNSET-123',
                          prefixIcon: const Icon(Icons.key_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onSubmitted: (_) => _handleJoin(),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              icon: const Icon(Icons.meeting_room_outlined),
                              label: const Text('Join room'),
                              onPressed: _handleJoin,
                            ),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            tooltip: 'Use demo code',
                            onPressed: () => setState(
                              () => _codeController.text = 'SUNSET-123',
                            ),
                            icon: const Icon(Icons.restart_alt_outlined),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Sample rooms',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _templates.values
                    .map(
                      (template) => _RoomPreviewCard(
                        template: template,
                        onTap: () => _openRoom(template),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFd6fffc), Color(0xFFf1fff8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Colour together. \\nJoin together.',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rooms use predefined areas so every stroke stays in sync. Edge-detection will arrive in later builds.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: const [
              _InfoChip(icon: Icons.palette_outlined, label: 'Shared palette'),
              _InfoChip(icon: Icons.grid_view_rounded, label: 'Defined zones'),
              _InfoChip(icon: Icons.lock_outline, label: 'Invite codes'),
            ],
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onStart,
            child: const Text('Start colouring'),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
    );
  }
}

class _RoomPreviewCard extends StatelessWidget {
  const _RoomPreviewCard({required this.template, required this.onTap});

  final RoomTemplate template;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        width: 260,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: const Icon(Icons.brush_outlined),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        template.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        template.code,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              template.description,
              style: theme.textTheme.bodyMedium,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: template.tags
                  .map(
                    (tag) => Chip(
                      label: Text(tag),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomScreen extends StatefulWidget {
  const RoomScreen({super.key, required this.template});

  final RoomTemplate template;

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  static const List<Color> _palette = [
    Color(0xFFFF6B6B),
    Color(0xFFFFC15E),
    Color(0xFF6FE3C1),
    Color(0xFF5DADEC),
    Color(0xFFB072E9),
    Color(0xFF8EAD7B),
    Color(0xFF1D1E2C),
  ];

  late Color _selectedColor = _palette.first;
  late Map<String, Color?> _zoneColours = {
    for (final zone in widget.template.zones) zone.id: zone.initialColor,
  };
  bool _showGrid = true;

  void _updateZone(ColorZone zone) {
    setState(() => _zoneColours[zone.id] = _selectedColor);
  }

  void _clearZone(ColorZone zone) {
    setState(() => _zoneColours[zone.id] = null);
  }

  void _reset() {
    setState(() {
      _selectedColor = _palette.first;
      _zoneColours = {
        for (final zone in widget.template.zones) zone.id: zone.initialColor,
      };
      _showGrid = true;
    });
  }

  int get _filledZonesCount =>
      _zoneColours.values.where((color) => color != null).length;

  double get _completionPercent => widget.template.zones.isEmpty
      ? 0
      : _filledZonesCount / widget.template.zones.length;

  String get _selectedHex => '#${_selectedColor.toRgbHex()}';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Room: ${widget.template.code}'),
        actions: [
          IconButton(
            tooltip: 'Reset colours',
            onPressed: _reset,
            icon: const Icon(Icons.refresh_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.primary,
                        size: 26,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.template.name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(widget.template.description),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: widget.template.tags
                                  .map((tag) => Chip(label: Text(tag)))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              RoomCanvas(
                template: widget.template,
                zoneColours: _zoneColours,
                showGrid: _showGrid,
                onZoneTap: _updateZone,
                onZoneLongPress: _clearZone,
              ),
              const SizedBox(height: 12),
              _RoomStatusBar(
                filledZones: _filledZonesCount,
                totalZones: widget.template.zones.length,
                completion: _completionPercent,
                selectedHex: _selectedHex,
              ),
              const SizedBox(height: 16),
              Text('Palette', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _palette
                    .map(
                      (color) => ChoiceChip(
                        label: const SizedBox(height: 20, width: 8),
                        selected: _selectedColor == color,
                        selectedColor: color.withOpacity(.2),
                        backgroundColor: color.withOpacity(.15),
                        side: BorderSide(color: color, width: 2),
                        onSelected: (_) =>
                            setState(() => _selectedColor = color),
                        avatar: CircleAvatar(backgroundColor: color),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'Long-press an area to clear its colour. Future iterations will allow server-provided edge-detected areas to appear here automatically.',
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                value: _showGrid,
                onChanged: (value) => setState(() => _showGrid = value),
                title: const Text('Show grid overlay'),
                subtitle:
                    const Text('Hide the helper grid if you want a cleaner view'),
              ),
              const SizedBox(height: 8),
              _ZoneLegend(
                template: widget.template,
                zoneColours: _zoneColours,
                selectedColor: _selectedColor,
                onApplySelected: _updateZone,
                onClear: _clearZone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoomCanvas extends StatelessWidget {
  const RoomCanvas({
    super.key,
    required this.template,
    required this.zoneColours,
    required this.showGrid,
    required this.onZoneTap,
    required this.onZoneLongPress,
  });

  final RoomTemplate template;
  final Map<String, Color?> zoneColours;
  final bool showGrid;
  final ValueChanged<ColorZone> onZoneTap;
  final ValueChanged<ColorZone> onZoneLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: template.gridCols / template.gridRows,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cellWidth = constraints.maxWidth / template.gridCols;
          final cellHeight = constraints.maxHeight / template.gridRows;
          return Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.outlineVariant),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                if (showGrid)
                  CustomPaint(
                    size: Size.infinite,
                    painter: _GridPainter(
                      rows: template.gridRows,
                      cols: template.gridCols,
                      color: theme.colorScheme.outlineVariant,
                    ),
                  ),
                ...template.zones.map(
                  (zone) => Positioned(
                    left: zone.col * cellWidth,
                    top: zone.row * cellHeight,
                    width: zone.colSpan * cellWidth,
                    height: zone.rowSpan * cellHeight,
                    child: _ZoneTile(
                      zone: zone,
                      color: zoneColours[zone.id],
                      onTap: () => onZoneTap(zone),
                      onLongPress: () => onZoneLongPress(zone),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _RoomStatusBar extends StatelessWidget {
  const _RoomStatusBar({
    required this.filledZones,
    required this.totalZones,
    required this.completion,
    required this.selectedHex,
  });

  final int filledZones;
  final int totalZones;
  final double completion;
  final String selectedHex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = (completion * 100).round();
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Zones filled: $filledZones / $totalZones',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: completion.clamp(0, 1),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$percentage%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Selected $selectedHex',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ZoneLegend extends StatelessWidget {
  const _ZoneLegend({
    required this.template,
    required this.zoneColours,
    required this.selectedColor,
    required this.onApplySelected,
    required this.onClear,
  });

  final RoomTemplate template;
  final Map<String, Color?> zoneColours;
  final Color selectedColor;
  final ValueChanged<ColorZone> onApplySelected;
  final ValueChanged<ColorZone> onClear;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Zones', style: theme.textTheme.titleMedium),
        const SizedBox(height: 6),
        ...template.zones.map(
          (zone) {
            final color = zoneColours[zone.id];
            return Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: theme.colorScheme.outlineVariant),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color ?? theme.colorScheme.surfaceContainer,
                  child: color == null
                      ? Icon(
                          Icons.palette_outlined,
                          color: theme.colorScheme.onSurfaceVariant,
                        )
                      : null,
                ),
                title: Text(zone.label),
                subtitle: Text(
                  color != null
                      ? '#${color.toRgbHex()}'
                      : 'Not filled yet',
                ),
                trailing: Wrap(
                  spacing: 4,
                  children: [
                    IconButton(
                      tooltip: 'Apply selected colour',
                      onPressed: () => onApplySelected(zone),
                      icon: Icon(
                        Icons.format_color_fill,
                        color: selectedColor,
                      ),
                    ),
                    IconButton(
                      tooltip: 'Clear colour',
                      onPressed: () => onClear(zone),
                      icon: const Icon(Icons.clear_outlined),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ZoneTile extends StatelessWidget {
  const _ZoneTile({
    required this.zone,
    required this.color,
    required this.onTap,
    required this.onLongPress,
  });

  final ColorZone zone;
  final Color? color;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fill = color ?? theme.colorScheme.surfaceContainerHighest;
    final textColor =
        ThemeData.estimateBrightnessForColor(fill) == Brightness.dark
        ? Colors.white
        : Colors.black87;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color != null
              ? fill.withOpacity(.9)
              : theme.colorScheme.outlineVariant,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  zone.label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  color != null ? '#${color!.toRgbHex()}' : 'Tap to fill',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: textColor.withOpacity(.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  _GridPainter({required this.rows, required this.cols, required this.color});

  final int rows;
  final int cols;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    final rowHeight = size.height / rows;
    final colWidth = size.width / cols;

    for (var i = 1; i < rows; i++) {
      final dy = i * rowHeight;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
    for (var j = 1; j < cols; j++) {
      final dx = j * colWidth;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension ColorHex on Color {
  String toRgbHex() {
    final rgb = value & 0x00FFFFFF;
    return rgb.toRadixString(16).padLeft(6, '0').toUpperCase();
  }
}

class ColorZone {
  const ColorZone({
    required this.id,
    required this.label,
    required this.row,
    required this.col,
    this.rowSpan = 1,
    this.colSpan = 1,
    this.initialColor,
  });

  final String id;
  final String label;
  final int row;
  final int col;
  final int rowSpan;
  final int colSpan;
  final Color? initialColor;
}

class RoomTemplate {
  const RoomTemplate({
    required this.code,
    required this.name,
    required this.description,
    required this.gridRows,
    required this.gridCols,
    required this.zones,
    this.tags = const [],
  });

  final String code;
  final String name;
  final String description;
  final int gridRows;
  final int gridCols;
  final List<ColorZone> zones;
  final List<String> tags;

  RoomTemplate copyWith({String? code}) {
    return RoomTemplate(
      code: code ?? this.code,
      name: name,
      description: description,
      gridRows: gridRows,
      gridCols: gridCols,
      zones: zones,
      tags: tags,
    );
  }
}
