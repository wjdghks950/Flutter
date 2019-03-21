import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(FriendlyChatApp());

final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class FriendlyChatApp extends StatelessWidget{
  final appName = 'FriendlyChat';
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: appName,
      theme: defaultTargetPlatform == TargetPlatform.iOS ? kIOSTheme :kDefaultTheme,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget{
  @override
  ChatScreenState createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin{
  List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController =TextEditingController();
  bool _isComposing = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('FriendlyChat'),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        child: Column(
          children:<Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTextComposer(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller:_textController,
              onChanged: (String text){
                setState((){
                  _isComposing = text.length > 0;
                });
              },
              onSubmitted: _handleSubmitted,
              decoration:InputDecoration.collapsed(hintText: 'Send a message'),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Theme.of(context).platform ==TargetPlatform.iOS ?
              CupertinoButton( // iOS send button theme
                child: (_isComposing ? Icon(Icons.directions_run) : Icon(Icons.directions_walk)),
                color: (_isComposing ? Colors.orange[500] : Colors.grey[500]),
                onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null
              ,) :
              IconButton( // Android send button theme
                icon: (_isComposing ? Icon(Icons.directions_run) : Icon(Icons.directions_walk)),
                color: (_isComposing ? Colors.orange[500] : Colors.grey[500]),
                onPressed: _isComposing ? () => _handleSubmitted(_textController.text) : null,
              ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text){
    _textController.clear();
    setState((){
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 3000), // Controls the speed at which the sent text appears
        vsync: this, 
      ),
    );
    setState((){
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  void dispose(){
    for (ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }

}

const String _name = "JEONGHWAN KIM"; //User name

class ChatMessage extends StatelessWidget{
  final String text;
  final AnimationController animationController;
  ChatMessage({@required this.text, this.animationController});

  @override
  Widget build(BuildContext context){
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_name, style: Theme.of(context).textTheme.subhead),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(text),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text(_name[0])),
          ),
        ],
      ),
    ),
    );
  }
}