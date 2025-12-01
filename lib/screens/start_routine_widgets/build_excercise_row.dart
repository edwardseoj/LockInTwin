import 'package:flutter/material.dart';

class BuildExerciseRow extends StatefulWidget {
  final String title;
  final int index;
  final List<Map<String, String>> sets;
  final ValueChanged<void> onUpdate;

  const BuildExerciseRow({
    super.key,
    required this.title,
    required this.index,
    required this.sets,
    required this.onUpdate,
  });

  @override
  State<BuildExerciseRow> createState() => _BuildExerciseRowState();
}

class _BuildExerciseRowState extends State<BuildExerciseRow> {
  late List<bool> _tappedRows;

  @override
  void initState() {
    super.initState();
    _tappedRows = List<bool>.filled(widget.sets.length, false);
  }

  void _toggleTapped(int idx) {
    setState(() {
      _tappedRows[idx] = !_tappedRows[idx];
      widget.sets[idx]['tapped'] = _tappedRows[idx] ? 'true' : 'false';
      widget.onUpdate(null); // notify parent
    });
  }

  @override
  Widget build(BuildContext context) {
    final isRowEven = widget.index % 2;

    return Container(
      decoration: BoxDecoration(
        color: isRowEven == 0 ? Colors.white12 : Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise title
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),

          // Header row
          Row(
            children: const [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Set", style: TextStyle(color: Colors.white70, fontSize: 18)),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Rep", style: TextStyle(color: Colors.white70, fontSize: 18)),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 5),

          // Sets list
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.sets.length,
            itemBuilder: (context, setIdx) {
              final set = widget.sets[setIdx];
              return GestureDetector(
                onTap: () => _toggleTapped(setIdx),
                child: Container(
                  color: _tappedRows[setIdx] ? Colors.lightBlue : Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(set['set'] ?? '', style: const TextStyle(color: Colors.white70, fontSize: 18)),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(set['reps'] ?? '', style: const TextStyle(color: Colors.white70, fontSize: 18)),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            _tappedRows[setIdx] ? Icons.check_box : Icons.check_box_outline_blank,
                            color: _tappedRows[setIdx] ? Colors.green: Colors.black26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
