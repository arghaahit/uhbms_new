class UserClients {
  final String email;
  final String clientName;

  UserClients(this.email, this.clientName);
}

class Curreny {
  final String id;
  final String curreny;
  final String symbol;

  Curreny(this.id, this.curreny, this.symbol);
}

class ServicesModals {
  final String id;
  final String servicesName;

  ServicesModals(this.id, this.servicesName);
}

class ClientOrders {
  final String orderNumber;
  final String id;

  ClientOrders(this.orderNumber, this.id);
}
