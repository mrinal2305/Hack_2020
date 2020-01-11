
class BookModels{
  String author;
  String title;
  String imgUrl;
  String isbn;
  String description;
  BookModels(this.description,this.imgUrl,this.author,this.title,this.isbn);

  Map toJson() =>{
    'author':author,
    'description':description,
    'imgUrl':imgUrl,
    'title':title,
    'isbn':isbn
  };
  BookModels.fromJson(Map json):
        imgUrl=json['imgUrl'],
        description=json['description'],
        title=json['title'],
        isbn=json['isbn'],
        author=json['author'];

      
}