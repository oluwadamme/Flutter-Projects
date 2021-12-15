class UserModel {
  final String bought_energy;
  final String energy_available;
  final String reference;
  final String energy_consumed;
  final String current;
  final String voltage_input;
  final String power;

  UserModel(
      {this.bought_energy,
      this.energy_available,
      this.reference,
      this.energy_consumed,
      this.current,
      this.voltage_input,
      this.power});

  UserModel.fromData(Map<String, dynamic> data)
      : reference = data['reference'].toString(),
        bought_energy = data['bought_energy'].toString(),
        energy_available = data['energy_available'].toString(),
        energy_consumed = data['energy_consumed'].toString(),
        power = data['power'].toString(),
        current = data['current'].toString(),
        voltage_input = data['voltage_input'].toString();
}
