enum FlavorType {
  production,
  development,
  local,
}

class Flavor {
  static FlavorType appFlavor = FlavorType.development;
  static String? baseUrl;
  static bool isProduction() {
    return appFlavor == FlavorType.production;
  }
}
