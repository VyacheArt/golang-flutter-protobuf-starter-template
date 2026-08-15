import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectrpc/connect.dart';
import '../../../gen/greet/v1/greet.connect.client.dart';
import '../../../gen/greet/v1/greet.pb.dart';
import '../../../gen/sysinfo/v1/sysinfo.connect.client.dart';
import '../../../gen/sysinfo/v1/sysinfo.pb.dart';

class GreetPage extends StatefulWidget {
  final Transport transport;
  const GreetPage({super.key, required this.transport});

  @override
  State<GreetPage> createState() => _GreetPageState();
}

class _GreetPageState extends State<GreetPage> {
  late final GreetServiceClient _greetClient;
  late final SysInfoServiceClient _sysInfoClient;

  final _controller = TextEditingController();
  String _response = '';
  String _sysInfo = '';
  Stream<WatchMetricsResponse>? _metricsStream;

  // Bidirectional streaming: requests are pushed into _chatRequests while
  // responses arrive concurrently on the same stream.
  final _chatController = TextEditingController();
  StreamController<GreetRequest>? _chatRequests;
  StreamSubscription<GreetResponse>? _chatResponses;
  final List<String> _chatLog = [];

  @override
  void initState() {
    super.initState();
    _greetClient = GreetServiceClient(widget.transport);
    _sysInfoClient = SysInfoServiceClient(widget.transport);
  }

  void _sendRequest() async {
    final name = _controller.text;
    if (name.isEmpty) return;

    try {
      final res = await _greetClient.greet(GreetRequest(name: name));
      setState(() {
        _response = res.greeting;
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  void _getSysInfo() async {
    try {
      final res = await _sysInfoClient.getSystemInfo(GetSystemInfoRequest());
      setState(() {
        _sysInfo = 'OS: ${res.os}, Go: ${res.goVersion}, Host: ${res.hostname}';
      });
    } catch (e) {
      setState(() {
        _sysInfo = 'Error: $e';
      });
    }
  }

  void _startWatchingMetrics() {
    setState(() {
      _metricsStream = _sysInfoClient.watchMetrics(WatchMetricsRequest());
    });
  }

  bool get _chatActive => _chatRequests != null;

  void _toggleChat() {
    if (_chatActive) {
      _stopChat('Stream closed');
      return;
    }
    final requests = StreamController<GreetRequest>();
    setState(() {
      _chatRequests = requests;
      _chatLog.add('Stream opened');
    });
    _chatResponses = _greetClient
        .greetStream(requests.stream)
        .listen(
          (res) => setState(() => _chatLog.add('⇐ ${res.greeting}')),
          onError: (Object e) => _stopChat('Error: $e'),
          onDone: () {
            if (_chatActive) _stopChat('Stream closed by server');
          },
        );
  }

  void _stopChat(String reason) {
    _chatRequests?.close();
    _chatResponses?.cancel();
    _chatRequests = null;
    _chatResponses = null;
    if (mounted) {
      setState(() => _chatLog.add(reason));
    }
  }

  void _sendChatMessage() {
    final name = _chatController.text;
    if (name.isEmpty || !_chatActive) return;
    _chatRequests!.add(GreetRequest(name: name));
    _chatController.clear();
    setState(() => _chatLog.add('⇒ $name'));
  }

  @override
  void dispose() {
    _chatRequests?.close();
    _chatResponses?.cancel();
    _chatController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Starter Template')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _sendRequest,
              child: const Text('Send via ConnectRPC'),
            ),
            const SizedBox(height: 16),
            Text(_response, style: const TextStyle(fontSize: 24)),
            const Divider(),
            ElevatedButton(
              onPressed: _getSysInfo,
              child: const Text('Get System Info'),
            ),
            const SizedBox(height: 16),
            Text(
              _sysInfo,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Divider(),
            ElevatedButton(
              onPressed: _startWatchingMetrics,
              child: const Text('Start Watching Metrics (Server Stream)'),
            ),
            const SizedBox(height: 16),
            if (_metricsStream != null)
              StreamBuilder<WatchMetricsResponse>(
                stream: _metricsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.data!;
                  final memMb = (data.allocatedMemory.toInt() / 1024 / 1024)
                      .toStringAsFixed(2);
                  return Text(
                    'Goroutines: ${data.numGoroutines} | Memory: $memMb MB',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            const Divider(),
            ElevatedButton(
              onPressed: _toggleChat,
              child: Text(
                _chatActive
                    ? 'Stop Bidi Stream'
                    : 'Start Bidi Stream (Bidirectional)',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _chatController,
                    enabled: _chatActive,
                    decoration: const InputDecoration(
                      labelText: 'Send a name over the stream',
                    ),
                    onSubmitted: (_) => _sendChatMessage(),
                  ),
                ),
                IconButton(
                  onPressed: _chatActive ? _sendChatMessage : null,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
            const SizedBox(height: 8),
            for (final line in _chatLog)
              Text(
                line,
                style: TextStyle(
                  fontSize: 14,
                  color: line.startsWith('⇐') ? Colors.green : Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
