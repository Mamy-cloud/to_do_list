import 'package:flutter/material.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> tasks = [
      {'id': 1, 'title': 'Se lever', 'done': false},
      {'id': 2, 'title': 'Manger', 'done': false},
      {'id': 3, 'title': 'Se laver', 'done': false},
      {'id': 4, 'title': 'Aller au marché', 'done': false},
      {'id': 5, 'title': 'Regarder la télé', 'done': false},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Mes tâches du jour',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              '${tasks.length} tâches à accomplir',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return _TaskCard(
                    id: task['id'],
                    title: task['title'],
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

class _TaskCard extends StatefulWidget {
  final int id;
  final String title;

  const _TaskCard({required this.id, required this.title});

  @override
  State<_TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<_TaskCard> {
  bool _done = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _done ? Colors.deepPurple.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _done ? Colors.deepPurple.shade200 : Colors.grey.shade200,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),

            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: GestureDetector(
          onTap: () => setState(() => _done = !_done),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _done ? Colors.deepPurple : Colors.transparent,
              border: Border.all(
                color:
                    _done ? Colors.deepPurple : Colors.grey.shade400,
                width: 2,
              ),
            ),
            child: _done
                ? const Icon(Icons.check, size: 16, color: Colors.white)
                : null,
          ),
        ),
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: _done ? Colors.grey : Colors.black87,
            decoration: _done ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '#${widget.id}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.deepPurple.shade300,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}