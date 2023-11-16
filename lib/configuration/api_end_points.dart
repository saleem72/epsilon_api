//

class ApiEndPoints {
  ApiEndPoints._();

  static const baseURL = 'http://epsilondemo.dyndns.org:14545/api/';

  static const login = 'Connect';

  static const customersByName = 'Clients/Customers';
  static const customerBalance = 'Clients/CPS';

  static const productByBaroode = 'Products/GetProductByBarcode';
  static const getProducts = 'Products/GetProducts';
  static const getPrices = 'Products/GetPrices';
  static const getCurrency = 'Products/GetCurrencies';

  static const addEntry = 'Entries/AddEntry';

  static const invoiceTypes = 'Invoices/GetInvoiceTypes';
  static const productUnits = 'Products/GetUnits';
  static const getPriceByUnit = 'Products/GetPriceByUnit';
  static const addInvoice = 'Invoices/AddInvoice';
}
