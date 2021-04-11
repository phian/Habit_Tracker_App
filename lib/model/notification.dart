class Notification {
  bool batThongBaoDauNgay;
  bool batThongBaoCuoiNgay;
  String gioThongBaoDauNgay;
  String gioThongBaoCuoiNgay;

  Notification({
    this.batThongBaoDauNgay,
    this.gioThongBaoDauNgay,
    this.batThongBaoCuoiNgay,
    this.gioThongBaoCuoiNgay,
  });

  Map<String, dynamic> toMap() {
    return {
      'bat_thong_bao_dau_ngay': batThongBaoDauNgay ? 1 : 0,
      'gio_thong_bao_dau_ngay': gioThongBaoDauNgay,
      'bat_thong_bao_cuoi_ngay': batThongBaoCuoiNgay ? 1 : 0,
      'gio_thong_bao_cuoi_ngay': gioThongBaoCuoiNgay,
    };
  }

  void fromMap(Map<String, dynamic> map) {

  }
}
