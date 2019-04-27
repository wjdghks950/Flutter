import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(BabyNames());

class BabyNames extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Baby Names',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState(){
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>{
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Baby Name Votes'),
        centerTitle: true,
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('baby').snapshots(),
      builder: (context, snapshot){
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      }
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
    return ListView(
      padding: const EdgeInsets.only(top:20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data){
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.name),
          leading: IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.blueGrey
            ),
            onPressed: (){
              setState((){
                Firestore.instance.collection('baby').document(record.name).delete();
                print(record.name);
              });
            },
          ),
          trailing: SizedBox(
            width: 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  flex: 5,
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up, color: Colors.black),
                        onPressed: () => Firestore.instance.runTransaction((transaction) async{
                          final freshSnapshot = await transaction.get(record.reference);
                          final fresh = Record.fromSnapshot(freshSnapshot);

                          await transaction.update(record.reference, {'upvote': fresh.upvote + 1});
                          }
                        ),
                      ),
                      Text(record.upvote.toString()),
                    ],
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_down, color: Colors.black),
                        onPressed: () => Firestore.instance.runTransaction((transaction) async{
                          final freshSnapshot = await transaction.get(record.reference);
                          final fresh = Record.fromSnapshot(freshSnapshot);

                          await transaction.update(record.reference, {'downvote': fresh.downvote + 1});
                          }
                        ),
                      ),
                      Text(record.downvote.toString()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  void _showDialog(){
    String name = "";
    int upvote = 0, downvote = 0;
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Add a baby name"),
          content:
            TextField(
              controller: _nameController,
            ),
          actions:[
            FlatButton(
              child: Text("ADD"),
              onPressed: (){
                setState((){
                  name = _nameController.text;
                  // Add a document to Firestore collection
                  Firestore.instance.runTransaction((transaction) async{
                    await transaction.set(Firestore.instance.collection('baby').document(name),{
                      'name' : name,
                      'upvote' : upvote,
                      'downvote' : downvote,
                    });
                  });
                  print(name + ' successfully added to baby database...');
                });
                _nameController.clear();
                Navigator.of(context).pop();
              }
            )
          ],
        );
      }
    );
  }
}

class Record{
  final String name;
  final int upvote;
  final int downvote;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['name'] != null),
      assert(map['upvote'] != null),
      assert(map['downvote'] != null),
      name = map['name'],
      upvote = map['upvote'],
      downvote = map['downvote'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:Upvote:$upvote:Downvote:$downvote>";
}

