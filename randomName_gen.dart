import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// `=>` notation - aka "arrow" syntax is a shorthand for `return` of a function
void main() => runApp(RandomGen()); // Starting line of an application

class RandomGen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp( //`title`, `theme`, `home`, `body` are the `named parameters`
      title: 'StartUpGen',      
      home: RandomWord(),
    );
  }
}

class RandomWord extends StatefulWidget{
  @override
  _RandomWordState createState() => _RandomWordState();
}

bool darkThemeEnabled = false;

class _RandomWordState extends State<RandomWord>{
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize:18.0);
  final _saved = Set<WordPair>();
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        title: Text('21400181 Jeonghwan Kim'),
        actions: <Widget>[IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),],
      ),
      body: _buildSuggestions(),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("Dark Theme"),
              trailing: Switch(
                value: darkThemeEnabled,
                onChanged: (bool changed){
                  setState((){
                    darkThemeEnabled = changed;
                    //print('darkThemeEnabled:' +  darkThemeEnabled.toString());
                  });
                }),
            )
          ]
        )
      )
    ),
    theme: darkThemeEnabled ? ThemeData.dark() : ThemeData(
        primaryColor: Colors.blue.shade100,
        //splashColor: Colors.blue.shade100,
      ),
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context){
          final Iterable<ListTile> tiles = _saved.map((WordPair pair){
            return ListTile(
              title: Text(pair.asPascalCase, style:_biggerFont),);
          },
          );
          final List<Widget> divided = ListTile.divideTiles(context: context, tiles: tiles).toList();

          return MaterialApp(
            home: Scaffold(
              appBar: AppBar(
              title: Text('Saved suggestion candidates'),),
              body: ListView(children:divided),
              ),
              theme: darkThemeEnabled ? ThemeData.dark() : ThemeData(
        primaryColor: Colors.blue.shade100,
        //splashColor: Colors.blue.shade100,
      ),
          );
        }
      )
    );
  }

  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i){
        if (i.isOdd){
          return Divider();
        }
        final index = i ~/ 2; // Calculates the actual number of word pairings in ListView, minus the divider widgets
        if(index >= _suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10)); // Generate random word pairs - in this case, 10 of them
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(pair){
    final alreadySaved = _saved.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase,
        style: _biggerFont,
      ),
      leading: Icon(alreadySaved ? Icons.star : Icons.star_border,
      color: alreadySaved ? Colors.yellow : null,),
      onTap: (){
        setState((){
          if(alreadySaved){
            _saved.remove(pair);
          }
          else{
            _saved.add(pair);
          }
        });
      }
    );
  }
}