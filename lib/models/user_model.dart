class User {
  final int id;
  final String name;
  final String imgUrl;
  final bool isOnline;
  const User({this.id, this.name, this.imgUrl, this.isOnline = false});
}

const User currentUser =
    User(id: 0, name: 'Nik', imgUrl: 'https://i.pravatar.cc/300');

const User u1 = User(
    id: 1,
    name: 'Rick Sanchez',
    imgUrl: 'https://i.pravatar.cc/300?img=1',
    isOnline: true);
const User u2 =
    User(id: 2, name: 'Jon Snow', imgUrl: 'https://i.pravatar.cc/300?img=2');
const User u3 =
    User(id: 3, name: 'Chandler', imgUrl: 'https://i.pravatar.cc/300?img=3');
const User u4 = User(
    id: 4,
    name: 'Sheldon',
    imgUrl: 'https://i.pravatar.cc/300?img=4',
    isOnline: true);

const List<User> favoriteUsers = [u1, u2, u3, u4];
