import 'package:flutter/material.dart';
import 'package:studentprj/ProfileScreen.dart';

class TodoTask {
  String text;
  bool done;
  TodoTask({required this.text, this.done = false});
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  static const Color primaryBlue = Color(0xFF246BFD);
  static const Color backgroundColor = Color(0xFFF4F7FC);

  final TextEditingController _ctrl = TextEditingController();
  final List<TodoTask> _tasks = [];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _addTask() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: const Text('Please enter a task first'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      return;
    }
    setState(() {
      _tasks.insert(0, TodoTask(text: text));
      _ctrl.clear();
    });
    FocusScope.of(context).unfocus();
  }

  void _toggle(int i) => setState(() => _tasks[i].done = !_tasks[i].done);

  /* ────────────────────────────────────────────────────────
   Shared confirmation dialog
   Returns true if user taps the confirm button.
   ──────────────────────────────────────────────────────── */
Future<bool> _confirm({
  required String title,
  required String message,
  required String confirmLabel,
  Color confirmColor = Colors.red,
}) async {
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade700,
          height: 1.4,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(
            confirmLabel,
            style: TextStyle(
              color: confirmColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
  return result ?? false;   // dialog dismissed = treat as cancel
}

/* ────────────────────────────────────────────────────────
   Delete ONE task — with confirmation
   ──────────────────────────────────────────────────────── */
Future<void> _delete(int i) async {
  if (i < 0 || i >= _tasks.length) return;   // safety: stale index

  final task = _tasks[i];
  final ok = await _confirm(
    title: 'Delete task?',
    message: '"${task.text}" will be removed from your list.',
    confirmLabel: 'Delete',
  );
  if (!ok || !mounted) return;

  setState(() => _tasks.removeAt(i));

  if (!mounted) return;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: const Text('Task deleted'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF323232),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
}

/* ────────────────────────────────────────────────────────
   Clear ALL tasks — with confirmation
   ──────────────────────────────────────────────────────── */
Future<void> _clearAll() async {
  if (_tasks.isEmpty) return;

  final ok = await _confirm(
    title: 'Clear all tasks?',
    message:
        'This will remove all ${_tasks.length} task${_tasks.length == 1 ? '' : 's'}. '
        'This action cannot be undone.',
    confirmLabel: 'Clear All',
  );
  if (!ok || !mounted) return;

  setState(() => _tasks.clear());

  if (!mounted) return;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: const Text('All tasks cleared'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF323232),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'My To-Do List',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Stay productive today',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.white),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person_outline_rounded,
              color: Colors.white,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const StudentProfile()),
            ),
          ),
          const SizedBox(width: 8),
        ],
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        toolbarHeight: 75,
        elevation: 4,
        shadowColor: Colors.black26,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(),
            const SizedBox(height: 25),
            _buildHeader(),
            const SizedBox(height: 15),
            _buildInput(),
            const SizedBox(height: 12),
            _buildAddButton(),
            const SizedBox(height: 25),
            _buildTasksHeader(),
            const SizedBox(height: 12),
            _buildTaskList(),
          ],
        ),
      ),
    );
  }

  // ─── Stay productive banner (network image + book & cap icons)
  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: primaryBlue,
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1000&q=80&auto=format&fit=crop',
          ),
          fit: BoxFit.cover,
          opacity: 0.35,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.menu_book_rounded, color: Colors.white, size: 36),
              SizedBox(width: 10),
              Icon(Icons.school_rounded, color: Colors.white, size: 36),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Stay productive!',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Complete your tasks on time and\nachieve more every single day.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ─── To-Do List header (checkmark logo)
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: primaryBlue.withOpacity(0.12),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.check_circle_rounded,
            color: primaryBlue,
            size: 26,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To-Do List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Add, complete and manage your tasks',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─── Text form: enter your task
  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _ctrl,
        onSubmitted: (_) => _addTask(),
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          hintText: 'Enter your task...',
          border: InputBorder.none,
          icon: Icon(Icons.edit_note_rounded, color: primaryBlue),
          contentPadding: EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  // ─── Add Task button with add icon
  Widget _buildAddButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: _addTask,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text(
          'Add Task',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  // ─── My Tasks header + Clear All
  Widget _buildTasksHeader() {
    return Row(
      children: [
        const Text(
          'My Tasks',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: primaryBlue.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${_tasks.length}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: primaryBlue,
            ),
          ),
        ),
        const Spacer(),
        if (_tasks.isNotEmpty)
          TextButton.icon(
            onPressed: _clearAll,
            icon: const Icon(
              Icons.delete_sweep_outlined,
              size: 18,
              color: Colors.red,
            ),
            label: const Text(
              'Clear All',
              style: TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  // ─── Task list (delete per task, tap to cross-line)
  Widget _buildTaskList() {
    if (_tasks.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              Icons.checklist_rtl_rounded,
              size: 48,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 12),
            Text(
              'No tasks yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Add your first task above to get started',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: List.generate(_tasks.length, (i) {
        final task = _tasks[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => _toggle(i),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.done ? primaryBlue : Colors.transparent,
                      border: Border.all(
                        color: task.done
                            ? primaryBlue
                            : Colors.grey.shade400,
                        width: 2,
                      ),
                    ),
                    child: task.done
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 180),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        decoration: task.done
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.done
                            ? Colors.grey.shade500
                            : Colors.black87,
                      ),
                      child: Text(task.text),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => _delete(i),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}