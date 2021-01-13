class Habit {
  int ma;
  String ten;
  int icon;
  String mau;
  int batMucTieu;
  int soLan;
  String donVi;
  int loaiLap;
  String ngayTrongTuan;
  int soLanTrongTuan;
  String buoi;
  int trangThai;

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
    var map = Map<String, dynamic>();
    if (ma != null) map['ma'] = ma;
    map['ten'] = ten;
    map['icon'] = icon;
    map['mau'] = mau;
    map['bat_muc_tieu'] = batMucTieu;
    map['so_lan'] = soLan;
    map['don_vi'] = donVi;
    map['loai_lap'] = loaiLap;
    map['ngay_trong_tuan'] = ngayTrongTuan;
    map['so_lan_trong_tuan'] = soLanTrongTuan;
    map['buoi'] = buoi;
    if (trangThai != null) map['trang_thai'] = trangThai;
    return map;
  }
}
