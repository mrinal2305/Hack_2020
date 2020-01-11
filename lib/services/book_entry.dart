class WeightEntry {
  String branch;
  String name;
  String fine;
  String roll;

  WeightEntry(this.branch, this.name, this.fine,this.roll);

  toJson() {
    return {
      "branch": branch,
      "name": name,
      "fine": fine,
      "roll": roll
    };
  }
}