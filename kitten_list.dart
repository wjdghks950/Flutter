import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(const KittenList());

class Kitten {
  const Kitten({this.name, this.description, this.age, this.imageUrl});

  final String name;
  final String description;
  final int age;
  final String imageUrl;
}

final String server = defaultTargetPlatform == TargetPlatform.android ? "10.0.2.2" : "localhost";

final List<Kitten> _kittens = <Kitten>[
  Kitten(
    name: 'Mittens',
    description: 'The pinnacle of cats. When Mittens sits in your lap, ' 'you feel like royalty.',
    age: 11,
    imageUrl: 'assets/kitten0.jpg'
  ),
  Kitten(
    name: 'Fluffy',
    description: 'World\'s cutest kitten. Seriously. We did the research.',
    age: 3,
    imageUrl: 'assets/kitten1.jpg'
  ),
  Kitten(
    name: 'Scooter',
    description: 'Chases string faster than 9/10 competing kittens.',
    age: 2,
    imageUrl: 'assets/kitten2.jpg'
  ),
  Kitten(
    name: 'Steve',
    description: 'Steve is cool and just kind of hangs out.',
    age: 4,
    imageUrl: 'assets/kitten3.jpg'
  ),
];

class KittenList extends StatelessWidget {
  const KittenList();

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme:ThemeData(
        primarySwatch:Colors.purple,
        buttonColor: Colors.purple,
        buttonTheme: const ButtonThemeData(
          textTheme:ButtonTextTheme.primary,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key }) : super(key: key);

  void _showDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you really willing to adopt him/her?"),
          actions: <Widget>[
            new FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text("Not yet"),
            ),
            new RaisedButton(
              onPressed: () {},
              child: const Text("Yes"),
            )
          ]
        );
      }
    );
  }

  Widget _dialogBuilder(BuildContext context, Kitten kitten){
    ThemeData localTheme = Theme.of(context);

    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children:
      [Image.asset(
        kitten.imageUrl,
        fit: BoxFit.fill,),
      Padding(padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(kitten.name,
            style:localTheme.textTheme.display1),
          Text('${kitten.age} months old',
            style:localTheme.textTheme.subhead.copyWith(
              fontStyle: FontStyle.italic,
            ),
          ), //Kitten.age is integer
          SizedBox(height: 16.0),
          Text(kitten.description,
          style: localTheme.textTheme.body1),
          Align(
            alignment:Alignment.centerRight,
            child: Wrap(
              children: [
                FlatButton(
                  onPressed: () {Navigator.of(context).pop();},
                  child: const Text('I\'m allergic'),
                ),
                RaisedButton(
                  onPressed: () {_showDialog(context);},
                  child: const Text('ADOPT'),
                ),
              ],
            ),
          ),
        ],
        ),
        ),
        ],
    );
  }

  Widget _listItemBuilder(BuildContext context, int index){
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => _dialogBuilder(context, _kittens[index])
      ),
      child: Container(
        padding: EdgeInsets.only(left:16.0),
        alignment: Alignment.centerLeft,
        child:Text(_kittens[index].name,
          style: Theme.of(context).textTheme.headline),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Kittens'),
        ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.0),
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
        itemCount: _kittens.length,
        itemBuilder: _listItemBuilder,
        ),
      );
  }
}