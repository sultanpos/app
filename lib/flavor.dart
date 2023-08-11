enum FlavorType {
  production,
  development,
  local,
}

class Flavor {
  static FlavorType appFlavor = FlavorType.development;
  static late String baseUrl;
  static late String baseUrlWs;
  static bool isProduction() {
    return appFlavor == FlavorType.production;
  }
}
