class Akun {
  final String uid;
  final String docId;

  final String nama;
  final String noHP;
  final String email;
  final String role;

  Akun({
    required this.uid,
    required this.docId,
    required this.nama,
    required this.noHP,
    required this.email,
    required this.role,
  });

  factory Akun.fromJson(Map<String, dynamic> json) => Akun(
        uid: json['uid'],
        docId: json['docId'],
        nama: json['nama'],
        noHP: json['noHp'],
        email: json['email'],
        role: json['role'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'docId': docId,
        'nama': nama,
        'noHp': noHP,
        'email': email,
        'role': role,
      };
}
