import 'package:faker/faker.dart';

class ToDo {
  String? id;
  String? title;
  String? username;
  bool isDone;

  ToDo({
    required this.id,
    required this.title,
    required this.username,
    this.isDone = false
  });

  static List<ToDo> todoList(){
    var faker = new Faker();

    return [
      ToDo(id: '01', title: faker.lorem.sentence(), username: faker.person.name(), isDone: true),
      ToDo(id: '02', title: faker.lorem.sentence(), username: faker.person.name()),
      ToDo(id: '03', title: faker.lorem.sentence(), username: faker.person.name()),
      ToDo(id: '04', title: faker.lorem.sentence(), username: faker.person.name()),
      ToDo(id: '05', title: faker.lorem.sentence(), username: faker.person.name()),
      ToDo(id: '06', title: faker.lorem.sentence(), username: faker.person.name()),
      ToDo(id: '07', title: faker.lorem.sentence(), username: faker.person.name()),
      ToDo(id: '08 ', title: faker.lorem.sentence(), username: faker.person.name())
    ];
  }
}
