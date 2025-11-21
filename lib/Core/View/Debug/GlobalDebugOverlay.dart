import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../../Services/DebugLoggerService.dart';

class GlobalDebugOverlay extends StatefulWidget {
  final Widget child;

  const GlobalDebugOverlay({
    super.key,
    required this.child,
  });

  @override
  State<GlobalDebugOverlay> createState() => _GlobalDebugOverlayState();
}

class _GlobalDebugOverlayState extends State<GlobalDebugOverlay> {
  bool _showDebugPanel = false;
  int _tapCount = 0;
  Timer? _tapTimer;
  Timer? _refreshTimer;
  Timer? _statusTimer;
  String? _statusMessage;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize the debug logger
    DebugLoggerService.instance.initialize();
    
    // Start a timer to refresh the UI every second (for countdown timer)
    if (!kDebugMode) {
      _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted && _showDebugPanel) {
          setState(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    _tapTimer?.cancel();
    _refreshTimer?.cancel();
    _statusTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleTripleClick(TapDownDetails details) {
    // Check if click is in top-right corner (50x50 area)
    final size = MediaQuery.of(context).size;
    final clickPosition = details.globalPosition;
    
    if (clickPosition.dx > size.width - 50 && clickPosition.dy < 50) {
      _tapCount++;
      
      _tapTimer?.cancel();
      _tapTimer = Timer(const Duration(milliseconds: 500), () {
        _tapCount = 0;
      });
      
      if (_tapCount >= 3) {
        _toggleDebugPanel();
        _tapCount = 0;
      }
    }
  }

  void _toggleDebugPanel() {
    setState(() {
      _showDebugPanel = !_showDebugPanel;
    });
    
    // Auto-scroll to bottom when opening
    if (_showDebugPanel) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _setStatusMessage(String message) {
    _statusTimer?.cancel();
    setState(() {
      _statusMessage = message;
    });
    _statusTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _statusMessage = null;
        });
      }
    });
  }

  void _copyLastNLogs(int n) {
    final logs = DebugLoggerService.instance.exportLastNLogs(n);
    Clipboard.setData(ClipboardData(text: logs));
    _setStatusMessage('Copied last $n logs to clipboard');
  }

  void _exportAllLogs() {
    final logs = DebugLoggerService.instance.exportLogs();
    Clipboard.setData(ClipboardData(text: logs));
    _setStatusMessage('All logs copied to clipboard');
  }

  void _clearLogs() {
    DebugLoggerService.instance.clearLogs();
    setState(() {});
    _setStatusMessage('Logs cleared');
  }

  Color _getLogColor(String message) {
    final lowerMessage = message.toLowerCase();
    if (lowerMessage.contains('error') || lowerMessage.contains('exception')) {
      return Colors.redAccent;
    } else if (lowerMessage.contains('warning') || lowerMessage.contains('warn')) {
      return Colors.orangeAccent;
    }
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    // In debug mode, don't show the overlay, just return the child
    if (kDebugMode) {
      return widget.child;
    }

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyD, control: true, shift: true): _toggleDebugPanel,
        const SingleActivator(LogicalKeyboardKey.keyD, meta: true, shift: true): _toggleDebugPanel,
      },
      child: GestureDetector(
        onTapDown: _handleTripleClick,
        child: Stack(
            children: [
              widget.child,
              if (_showDebugPanel) ...[
                // Semi-transparent overlay to dismiss panel when tapping outside
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _toggleDebugPanel,
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                // Debug panel
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {}, // Prevent taps on panel from closing it
                    child: TweenAnimationBuilder<double>(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(460 * (1 - value), 0),
                          child: child,
                        );
                      },
                      child: _buildDebugPanel(),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
    );
  }

  Widget _buildDebugPanel() {
    final logs = DebugLoggerService.instance.logs;
    
    return Container(
      width: 460,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(-2, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              border: Border(
                bottom: BorderSide(color: Colors.grey[700]!),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.bug_report,
                  color: Colors.greenAccent,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Debug Logs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${logs.length} entries',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.white70, size: 20),
                  onPressed: _clearLogs,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                  onPressed: _toggleDebugPanel,
                ),
              ],
            ),
          ),
          // Logs content
          Expanded(
            child: logs.isEmpty
                ? Center(
                    child: Text(
                      'No logs yet',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      final color = _getLogColor(log.message);
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SelectableText(
                          log.toString(),
                          style: TextStyle(
                            color: color,
                            fontSize: 11,
                            fontFamily: 'monospace',
                            decoration: TextDecoration.none,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          // Footer
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              border: Border(
                top: BorderSide(color: Colors.grey[700]!),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_statusMessage != null) ...[
                  Text(
                    _statusMessage!,
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                ],
                // Quick copy buttons
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildQuickCopyButton('Last 10', 10),
                    _buildQuickCopyButton('Last 20', 20),
                    _buildQuickCopyButton('Last 30', 30),
                  ],
                ),
                const SizedBox(height: 8),
                // Export all button
                ElevatedButton.icon(
                  onPressed: _exportAllLogs,
                  icon: const Icon(Icons.file_download, size: 16),
                  label: const Text('Export All Logs'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
                const SizedBox(height: 8),
                // Archive countdown
                Text(
                  'Next archive in: ~30 min',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCopyButton(String label, int count) {
    return SizedBox(
      width: 85,
      child: ElevatedButton(
        onPressed: () => _copyLastNLogs(count),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          textStyle: const TextStyle(fontSize: 11),
        ),
        child: Text(label),
      ),
    );
  }
}

