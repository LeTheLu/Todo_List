
class Todo{
  int id;
  String content;
  String title;
  String dateTime;
  int clock;
  int important;
  int done;
  Todo({
    required this.id,
    required this.content,
    this.title = '',
    this.dateTime ='',
    this.clock = 0,
    this.important = 0 ,
    this.done = 0});


  Map<String , dynamic> toMap(){
    return {
      'id' : id,
      'content' : content,
      'title' : title,
      'dateTime' : dateTime,
      'clock': clock,
      'important' : important,
      'done' : done
    };
  }

}
