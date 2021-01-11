class Habit {
  int ma;
  String ten;
  String icon;
  String mau;
  bool batMucTieu;
  int soLan;
  String donVi;
  int loaiLap;
  String ngayTrongTuan;
  int soLanTrongTuan;
  int buoi;
  bool trangThai;

  Habit({
    this.ma,
    this.ten,
    this.icon,
    this.mau,
    this.batMucTieu,
    this.soLan,
    this.donVi,
    this.loaiLap,
    this.ngayTrongTuan,
    this.soLanTrongTuan,
    this.buoi,
    this.trangThai,
  });

  Map<String, dynamic> toMap() {
    return {
      'ma': ma,
      'ten': ten,
      'icon': icon,
      'mau': mau,
      'bat_muc_tieu': batMucTieu ? 1 : 0,
      'so_lan': soLan,
      'don_vi': donVi,
      'loai_lap': loaiLap,
      'ngay_trong_tuan': ngayTrongTuan,
      'so_lan_trong_tuan': soLanTrongTuan,
      'buoi': buoi,
      'trang_thai': trangThai ? 1 : 0,
    };
  }
}
