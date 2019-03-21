import 'dart:async';

Future<void> printDailyNewsDigest() async{
  try{
/* Or you can use multiple `await` expressions to ensure that 
 each statement completes before executing the next statement */
    var newsDigest = await gatherNewsReports();
  //var newsDigest1 = await gatherNewsRports1();
  //var newsDigest2 = await gatherNewsRports2();
    print(newsDigest);
  } catch(e){
    print('Error has occurred while fetching data from the network.');
  }
}

main(){
  printDailyNewsDigest();
  printWinningLotteryNumbers();
  printWeatherForecast();
  printBaseballScore();
}

printWinningLotteryNumbers() {
  print('Winning lotto numbers: [23, 63, 87, 26, 2]');
}

printWeatherForecast() {
  print("Tomorrow's forecast: 70F, sunny.");
}

printBaseballScore() {
  print('Baseball score: Red Sox 10, Yankees 0');
}

const news = '<gathered news goes here>';
const oneSecond = Duration(seconds: 1);

Future<String> gatherNewsReports() => Future.delayed(oneSecond, () => news);