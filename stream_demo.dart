import 'dart:async';

Future<int> sumStream(Stream<int> stream) async{
  var sum = 0;
  /*await for loop stops when the stream is done*/
  try{
    await for(var value in stream){
      sum += value;
    }
  }catch(e){
    print('Error has occurred while fetching the data from our server.');
    return -1;
  }
  return sum;
}

Stream<int> countStream(int to) async*{
  /*Generates a simple stream of integers using an async* function */
  for (int i = 1; i <= to; i++){
      yield i;
  }
}

main() async{
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); //55
}