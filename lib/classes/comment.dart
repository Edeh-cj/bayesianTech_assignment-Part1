import 'dart:math';

class MyComment {
  final String commentstring;
  bool _posted = false;
  String id = generateid(); 

  MyComment(this.commentstring);

  bool get isposted => _posted;
  set toggle(String anyletter){
    _posted = true;
  }
}

String generateid() {
  String characters = 'ABCDEFGHIJKLMNPQRSTUVWXYZ1234567890';
  return List.generate(
      2, (index) => characters[Random().nextInt(characters.length)]).join();
}

 