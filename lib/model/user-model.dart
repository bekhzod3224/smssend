class UserModel {
    String phoneNumber;
    String name;
    String familiya;
    String image;

    UserModel({
        required this.phoneNumber,
        required this.name,
        required this.familiya,
        required this.image,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        familiya: json["familiya"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "name": name,
        "familiya": familiya,
        "image": image,
    };
}