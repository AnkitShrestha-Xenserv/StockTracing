class UserModel {
  final int userId;
  final String firstName;
  final String lastName;
  final String password;
  final List<String> stocks;
  final List<String> watchList;

  UserModel.fromForm(
      {this.userId,
      this.firstName,
      this.lastName,
      this.password,
      this.stocks,
      this.watchList});

  Map<String, dynamic> toMapForDb() {
    return <String, dynamic>{
      "userId": userId,
      "firstName": firstName,
      "lastName": lastName,
      "password": password,
      "stocks": stocks ?? [],
      "watchList": watchList ?? []
    };
  }
}
