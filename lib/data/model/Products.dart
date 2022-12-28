        // 'CREATE TABLE Products (id INTEGER PRIMARY KEY , name TEXT, count INTEGER, price TEXT, note TEXT, code TEXT, qrCode TEXT )',

class Products{
  final int id;
  final String name;
  final int count;
  final String price;
  final String note;
  final String code;
  final String qrCode;

  Products(this.id, this.name, this.count, this.price, this.note, this.code, this.qrCode);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'note': note,
      'price': price,
      'qrCode': qrCode
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Products{id: $id, name: $name, code: $code, note: $note, price:$price, qrCode:$qrCode}';
  }
  // Map<String, Object?> toMap() {
  //   var map = <String, Object?>{
  //     'id': id,
  //     'name': name,
  //     'code': code,
  //     'note': note,
  //     'price': price,
  //     'qrCode': qrCode
  //   };
    
  //   return map;
  // }

}