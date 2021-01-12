import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:habit_tracker/model/habit.dart';

class DatabaseHelper {
  static final _databaseName = "todo.db";
  static final _databaseVersion = 1;

  // table HABIT
  static final tabHabit = 'habit';
  static final ma = 'ma';
  static final ten = 'ten';
  static final icon = 'icon';
  static final mau = 'mau';
  static final batMucTieu = 'bat_muc_tieu';
  static final soLan = 'so_lan';
  static final donVi = 'don_vi';
  static final loaiLap = 'loai_lap';
  static final ngayTrongTuan = 'ngay_trong_tuan';
  static final soLanTrongTuan = 'so_lan_trong_tuan';
  static final buoi = 'buoi';
  static final trangThai = 'trang_thai';

  //
  static final maThoiQuen = 'ma_thoi_quen';
  static final ngay = 'ngay';

  // table DIARY
  static final tabDiary = "diary";
  static final noiDung = "noi_dung";

  // table PROCESS
  static final tabProcess = 'process';
  static final ketQua = 'ket_qua';
  static final skip = 'skip';

  // table NOTIFICATION
  static final tabNotification = 'notification';
  static final batThongBaoDauNgay = 'bat_thong_bao_dau_ngay';
  static final gioThongBaoDauNgay = 'gio_thong_bao_dau_ngay';
  static final batThongBaoCuoiNgay = 'bat_thong_bao_cuoi_ngay';
  static final gioThongBaoCuoiNgay = 'gio_thong_bao_cuoi_ngay';

  // table suggested topic
  static final tabSuggestedTopic = 'suggested_topic';
  static final maChuDe = 'ma_chu_de';
  static final tenChuDeGoiY = 'ten_chu_de_goi_y';
  static final moTa = 'mo_ta';

  // table suggested habit
  static final tabSuggestedHabit = 'suggested_habit';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // habit
    await db.execute('''
    CREATE TABLE $tabHabit (
      $ma INTEGER PRIMARY KEY AUTOINCREMENT,
      $ten TEXT,
      $icon TEXT,
      $mau TEXT,
      $batMucTieu INTEGER,
      $soLan INTEGER,
      $donVi TEXT,
      $loaiLap INTEGER,
      $ngayTrongTuan TEXT,
      $soLanTrongTuan INTEGER,
      $buoi INTEGER,
      $trangThai INTEGER
    )
    ''');

    // diary
    await db.execute('''
    CREATE TABLE $tabDiary (
      $maThoiQuen INTEGER,
      $ngay TEXT,
      $noiDung TEXT,
      PRIMARY KEY ($maThoiQuen, $ngay),
      FOREIGN KEY($maThoiQuen) REFERENCES $tabHabit ($ma)
    )
    ''');

    // process
    await db.execute('''
    CREATE TABLE $tabProcess (
      $maThoiQuen INTEGER,
      $ngay TEXT,
      $ketQua INTEGER,
      $skip INTEGER,
      PRIMARY KEY ($maThoiQuen, $ngay),
      FOREIGN KEY($maThoiQuen) REFERENCES $tabHabit ($ma)
    )
    ''');

    // notification
    await db.execute('''
    CREATE TABLE $tabNotification (
      $batThongBaoDauNgay INTEGER,
      $gioThongBaoDauNgay TEXT,
      $batThongBaoCuoiNgay INTEGER,
      $gioThongBaoCuoiNgay INTEGER
    )
    ''');

    // suggested topic
    await db.execute('''
    CREATE TABLE $tabSuggestedTopic (
      $maChuDe INTEGER PRIMARY KEY AUTOINCREMENT,
      $tenChuDeGoiY TEXT,
      $moTa TEXT
    )
    ''');

    // suggested habit
    await db.execute('''
    CREATE TABLE $tabSuggestedHabit (
      $maChuDe INTEGER,
      $ten TEXT,
      $icon TEXT,
      $mau TEXT,
      $batMucTieu INTEGER,
      $soLan INTEGER,
      $donVi TEXT,
      $loaiLap INTEGER,
      $ngayTrongTuan TEXT,
      $soLanTrongTuan INTEGER,
      $buoi INTEGER,
      PRIMARY KEY ($maChuDe, $ten),
      FOREIGN KEY($maChuDe) REFERENCES $tabSuggestedTopic ($maChuDe)
    )
    ''');

    // insert data suggested topic, suggested habit
    //await db.execute('');
  }

  Future<int> insertHabit(Habit habit) async {
    Database db = await instance.database;
    var res = await db.insert(tabHabit, habit.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> selectAllHabit() async {
    Database db = await instance.database;
    var res = await db.query(tabHabit, orderBy: "$ma ASC");
    return res;
  }
}
