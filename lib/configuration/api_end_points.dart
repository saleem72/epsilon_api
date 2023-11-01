//

class ApiEndPoints {
  ApiEndPoints._();

  static const baseURL = 'http://epsilondemo.dyndns.org:14545/api/';

  static const login = 'Connect';

  static const customersByName = 'Clients/Customers';
  static const customerBalance = 'Clients/CPS';

  static const productByBaroode = 'Products/GetProductByBarcode';
  static const seachByName = 'Products/GetProducts';
  static const getPrices = 'Products/GetPrices';
  static const getCurrency = 'Products/GetCurrencies';

  static const addEntry = 'Entries/AddEntry';
}
