import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatGPTScreen extends StatefulWidget {
  const ChatGPTScreen({Key? key}) : super(key: key);

  @override
  _ChatGPTScreenState createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  // ChatGPT API key (replace with environment variable or secure storage for production)
  final String _apiKey = 'your_api_key_here';

  /// Sends a message to the ChatGPT API and handles the response
  Future<void> _sendMessage(String message) async {
    setState(() {
      _messages.add({"role": "user", "content": message});
    });

    // Sending the request to ChatGPT API
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $_apiKey",
        "Content-Type": "application/json",
      },
      body: json.encode({
        "model": "gpt-3.5-turbo",
        "messages": _messages,
      }),
    );

    if (response.statusCode == 200) {
      // Parsing and displaying the assistant's response
      final data = json.decode(response.body);
      String reply = data['choices'][0]['message']['content'];

      setState(() {
        _messages.add({"role": "assistant", "content": reply});
      });
    } else {
      // Error handling and message display
      print('Error: ${response.statusCode} - ${response.body}');
      setState(() {
        _messages.add({
          "role": "assistant",
          "content": "Error: Unable to fetch response. Status code: ${response.statusCode}"
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'ChatGPT',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['role'] == 'user';
                return Container(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: isUser ? Radius.circular(12) : Radius.zero,
                        bottomRight: isUser ? Radius.zero : Radius.circular(12),
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      message['content']!,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Ask about movies...",
                      hintStyle: TextStyle(color: Colors.white54),
                      fillColor: Colors.grey[900],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
