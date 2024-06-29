
class Customer {
  final String id;
  final String fName;
  final String lName;
  final String username;
  final String nationalId;
  final String email;
  final Map<String,String> accounts;

  Customer({
    required this.id,
    required this.fName,
    required this.lName,
    required this.username,
    required this.nationalId,
    required this.accounts,
    required this.email,
  });
  Customer.empty()
      : id = '',
        fName = '',
        lName = '',
        username = '',
        nationalId = '',
        accounts = const {},
        email = '';
}
