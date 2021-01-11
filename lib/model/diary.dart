class Diary {
  int maThoiQuen;
  String ngay;
  String noiDung;

  Diary({
    this.maThoiQuen,
    this.noiDung,
    this.ngay,
  });

  Map<String, dynamic> toMap() {
    return {
      'ma_thoi_quen': maThoiQuen,
      'ngay': ngay,
      'noi_dung': noiDung,
    };
  }
}
