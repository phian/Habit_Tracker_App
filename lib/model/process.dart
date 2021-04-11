class Process {
  int maThoiQuen;
  String ngay;
  int ketQua;
  bool skip;

  Process({
    this.maThoiQuen,
    this.ngay,
    this.ketQua,
    this.skip,
  });

  Map<String, dynamic> toMap() {
    return {
      'ma_thoi_quen': maThoiQuen,
      'ngay': ngay,
      'ket_qua': ketQua,
      'skip': skip ? 1 : 0,
    };
  }

  void fromMap(Map<String, dynamic> data) {

  }
}
