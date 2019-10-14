import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';


/*
  This class is a PROVIDER, is like a box tp manage the state
  in our app, her we are using it to manage the question and answers
  by getting all items (we are sending request to get 10 items if you change
  the number of items you will get errors),

*/


class Category with ChangeNotifier{


  List<QuestionItem> _items = [];


  List<QuestionItem> get items {
    return [..._items];
  }


  Future<List<QuestionItem>> getQuestion(String url)async{
    final response = await http.get(url);
    var list = jsonDecode(response.body);
    _items = [];
    list['results'].forEach((doc){
      List temp = [];
      List allData = [
        doc['incorrect_answers'][0]
            .toString()
            .replaceAll('&#039;', '\'')
            .replaceAll('&quot;', '')
            .replaceAll('&euml;', ''),
        doc['incorrect_answers'][1]
            .toString()
            .replaceAll('&#039;', '\'')
            .replaceAll('&quot;', '')
            .replaceAll('&euml;', '')  ,
        doc['incorrect_answers'][2]
          .toString()
          .replaceAll('&#039;', '\'')
          .replaceAll('&quot;', '')
          .replaceAll('&euml;', ''),
        doc['correct_answer']
            .toString()
            .replaceAll('&#039;', '\'')
            .replaceAll('&quot;', '')
            .replaceAll('&euml;', ''),

      ];
      final _random = new Random();
      while(temp.length < 4 || temp == null){
        if(allData[_random.nextInt(allData.length)] != null) {
          int index = _random.nextInt(allData.length);
          temp.add(allData[index]);
          allData.removeAt(index);
        }
      }
      _items.add(
         QuestionItem(
           answers: temp,
           question: doc['question']
               .toString()
               .replaceAll('&#039;', '\'')
               .replaceAll('&quot;', '')
               .replaceAll('&euml;', '') ,
           correctAnswer: doc['correct_answer']
               .toString()
               .replaceAll('&#039;', '\'')
               .replaceAll('&quot;', '')
               .replaceAll('&euml;', '')
         ),
      );
    });
    notifyListeners();
    print('_items length : ${_items.length}');
    return _items;
  }


}




class QuestionItem{

  String question;
  List answers;
  String correctAnswer;

  QuestionItem({this.answers, this.question, this.correctAnswer});



}
