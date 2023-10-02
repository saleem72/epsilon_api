//

class ApiEndPoints {
  ApiEndPoints._();

  static const baseURL = 'http://epsilondemo.dyndns.org:14545/api/';

  static const login = 'Connect';

  static const customersByName = 'Clients/Customers';
  static const customerBalance = 'Clients/CPS';
  // Proucts/GetProductByBaroode
  static const productByBaroode = 'Products/GetProductByBarcode';

  // {{host}}/Products/GetProducts?product=بيبسي&Guid={{guid}}
  static const seachByName = 'Products/GetProducts';
}
