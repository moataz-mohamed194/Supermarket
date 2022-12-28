// 'CREATE TABLE Note (id INTEGER PRIMARY KEY , title TEXT, content TEXT )',

class Notes{
  final int id ;
  final String title;
  final String content;

  Notes({
    required this.id,
    required this.title,
    required this.content});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'Notes {id: $id, content: $content, title: $title}';
  }

}