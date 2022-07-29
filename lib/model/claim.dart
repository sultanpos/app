class JWTClaim {
  final int userId;
  final String name;
  final String companyId;
  final List<String> branchIds;
  final Map<int, int> permission;

  JWTClaim(this.userId, this.name, this.companyId, this.branchIds, this.permission);
}
