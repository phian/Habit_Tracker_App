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
  static final hinhChuDe = 'hinh_chu_de';

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
      $icon INTEGER,
      $mau TEXT,
      $batMucTieu INTEGER,
      $soLan INTEGER,
      $donVi TEXT,
      $loaiLap INTEGER,
      $ngayTrongTuan TEXT,
      $soLanTrongTuan INTEGER,
      $buoi TEXT,
      $trangThai INTEGER DEFAULT 0
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
      $moTa TEXT,
      $hinhChuDe TEXT
    )
    ''');

    // suggested habit
    await db.execute('''
    CREATE TABLE $tabSuggestedHabit (
      $maChuDe INTEGER,
      $ten TEXT,
      $moTa TEXT,
      $icon INTEGER,
      $mau TEXT,
      $batMucTieu INTEGER,
      $soLan INTEGER,
      $donVi TEXT,
      $loaiLap INTEGER,
      $ngayTrongTuan TEXT,
      $soLanTrongTuan INTEGER,
      $buoi TEXT,
      PRIMARY KEY ($maChuDe, $ten),
      FOREIGN KEY($maChuDe) REFERENCES $tabSuggestedTopic ($maChuDe)
    )
    ''');

    // insert data suggested topic
    await db.execute(
        '''INSERT INTO $tabSuggestedTopic ($tenChuDeGoiY, $moTa, $hinhChuDe) 
        VALUES 
        ('Trending habits', 'Take a step in a right direction', 'images/trending_habits.png'),
        ('Staying at home', 'Use this time to do something new', 'images/at_home.png'),
        ('Preventive care', 'Protect yourself and others', 'images/preventive_care.png'),
        ('Must-have habits', 'Small efforts, big results', 'images/must_have_habit.png'),
        ('Morning routine', 'Get started on a productive day', 'images/morning_routine.png'),
        ('Nighttime rituals', 'Sleep tight for better health', 'images/nighttime_rituals.png'),
        ('Getting stuff done', 'Boost your every day productivity', 'images/getting_stuff_done.png'),
        ('Healthy body', 'The foundation of your health well-being', 'images/healthy_body.png'),
        ('Stress relief', 'Release tension and increase and increase calm', 'images/stress_relief.png'),
        ('Mindful-self care', 'Take care with daily activities', 'images/self_care.png'),
        ('Learn and explore', 'Expand your knowledge', 'images/learn_and_explore.png'),
        ('Staying fit', 'Feel strong and increase enrgy', 'images/staying_fit.png'),
        ('Personal finance', 'Take control of your budget', 'images/personal_finance.png'),
        ('Loved ones', 'Nature inportant relationships', 'images/loved_ones.png'),
        ('Around the house', 'Clean your space and your mind', 'images/around_the_house.png'),
        ('Tracking the diet', 'Keep your tidy body', 'images/tracking_the_diet.png'),
        ('Live with hobbies', 'Spend this time to do what you like', 'images/live_with_hobbies.png'),
        ('Remove bad habits', 'Make your life better', 'images/bad_habit.png')
         ''');

    // insert data suggested habit
    await db.execute('''INSERT INTO $tabSuggestedHabit 
    ($maChuDe, $ten, $moTa, $icon, $mau, $batMucTieu, $soLan, $donVi, $loaiLap, $ngayTrongTuan, $soLanTrongTuan, $buoi)
    VALUES
    ('1', 'Study online', 'A world of new discoveries awaits', '58998', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('1', 'Learn a new language', 'Think of all a things that make you happy. Dream big!', '59730', '0xFF11C480', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('1', 'Read', 'Crack a book and broaden a mind', '59348', '0xFFFE7352', '1', '50', 'pages', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('1', 'Drink water', 'Stay hydrated and flush out toxins', '59430', '0xFF1C8EFE', '1', '10', 'glasses', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('1', 'Morning excercise', 'Charge your batteries', '58717', '0xFFFE7352', '1', '30', 'time', '0', '2,3,4,5,6,7,8', '6', '1'),
    
    ('2', 'Study online', 'A world of new discoveries awaits', '58998', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('2', 'Host movie marathon', 'May the Force be with you!', '59536', '0xFF1C8EFE', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('2', 'Play board game', 'Turn off the TV and challenge every one to play', '58943', '0xFFFE7352', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('2', 'Do a puzzle', 'Puzzles are a calming way to spend time together', '59161', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('2', 'Learn a new language', 'Think of all a things that make you happy. Dream big!', '59730', '0xFF11C480', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('3', 'Wash hands regularly', 'The first step to illness prevention', '59169', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('3', 'Avoid touching face', 'Stop illness before it starts', '59615', '0xFFFE7352', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('3', 'Practice social distancing', 'Avoid crowds to keep safe and healthy', '59637', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('3', 'Use a tissue when coughing', 'Cover your cough to prevent spreading infection', '59830', '0xFF1C8EFE', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('3', 'Disinfect high-touch surfaces', 'Use hand sanitizer to clean frequently used surfaces', '59210', '0xFF11C480', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('4', 'Make time for yourself', 'Stop the daily rush and tune into you', '60120', '0xFF1C8EFE', '1', '60', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('4', 'Set goals', 'Stay motivated and focus', '59938', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('4', 'Sleep for 8 hours', 'Your body will be greatful', '58714', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),    
    ('4', 'Spend time with family', 'Engage and stay connected', '59322', '0xFF11C480', '1', '2', 'hours', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('4', 'Read', 'Crack a book and broaden a mind', '59348', '0xFFFE7352', '1', '50', 'pages', '0', '2,3,4,5,6,7,8', '6', '3'),
    
    ('5', 'Practice affirmations', 'Positive thinking can transform your entire life', '60002', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('5', 'Practice visualization', 'Use your power of your subconscious life', '59343', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('5', 'Wake up early', 'Add some extra hours to yuor day', '60130', '0xFF11C480', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('5', 'Make the bed', 'Rise, shine, and start the day off night', '59329', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('5', 'Morning excercise', 'Charge your batteries', '58717', '0xFFFE7352', '1', '30', 'time', '0', '2,3,4,5,6,7,8', '6', '1'),
    
    ('6', 'Reflect on the day', 'Gain perspective and set priorities', '59047', '0xFF1C8EFE', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('6', 'Block distraction', 'Turn off gadgets and devices', '59664', '0xFFFABB37', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('6', 'Sleep for 8 hours', 'Your body will be greatful', '58714', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('6', 'Go to sleep by 11pm', 'Feel refreshed in the morning', '59329', '0xFF11C480', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('6', 'Read', 'Crack a book and broaden a mind', '59348', '0xFFFE7352', '1', '50', 'pages', '0', '2,3,4,5,6,7,8', '6', '3'),
    
    ('7', 'Set goals', 'Stay motivated and focus', '59938', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('7', 'Focus on my dream', 'Think about one step at a time', '59938', '0xFF11C480', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('7', 'Log my time', 'Make every minute count', '60120', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('7', 'Block distraction', 'Turn off gadgets and devices', '59664', '0xFFFABB37', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('7', 'Make a list', 'Stay organized and keep everything on task', '59047', '0xFF1C8EFE', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('8', 'Limit fried food', 'Opt for baked rather than fried', '59168', '0xFFFABB37', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('8', 'Fast', 'Cleanse your body and mind', '59429', '0xFF11C480', '1', '12', 'hours', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('8', 'Limit sugar', 'Replace candy with food', '58913', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('8', 'Cook more often', 'Whip up a favorite recipe', '59383', '0xFFFE7352', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '4', '1,2,3'),
    ('8', 'Limit caffeine', 'Try caffeine-free instead', '59426', '0xFF933DFF', '1', '1', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),

    ('9', 'Practice deep breathing', 'Calm and strengthen your mind', '59908', '0xFFFE7352', '1', '15', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('9', 'Enjoy the sunrise', 'Set your mind to the natural rhythm', '60130', '0xFFFABB37', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('9', 'Practice visualization', 'Use your power of your subconscious life', '59343', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('9', 'Block distraction', 'Turn off gadgets and devices', '59664', '0xFFFABB37', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('9', 'Sleep for 8 hours', 'Your body will be greatful', '58714', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('10', 'Practice deep breathing', 'Calm and strengthen your mind', '59908', '0xFFFE7352', '1', '15', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('10', 'Make time for yourself', 'Stop the daily rush and tune into you', '60120', '0xFF1C8EFE', '1', '60', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('10', 'Connect with nature', 'Slow down and take it all in', '59432', '0xFFFABB37', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('10', 'Practice affirmations', 'Positive thinking can transform your entire life', '60002', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('10', 'Practice visualization', 'Use your power of your subconscious life', '59343', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('11', 'Listen to podcasts', 'Get educated and informed anytime, anywhere', '59543', '0xFFFE7352', '1', '30', 'time', '1', '2,3,4,5,6,7,8', '2', '1,2,3'),
    ('11', 'Try something new', 'You are capable and more than you know', '59178', '0xFFFE7352', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('11', 'Reflect on the day', 'Gain perspective and set priorities', '59047', '0xFF1C8EFE', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('11', 'Write anything', 'Find your own voice', '58870', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('11', 'Write my journal', 'Look back at a day and reflect', '59348', '0xFFFE7352', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),

    ('12', 'Limit sugar', 'Replace candy with food', '58913', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('12', 'Drink water', 'Stay hydrated and flush out toxins', '59430', '0xFF1C8EFE', '1', '10', 'glasses', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('12', 'Morning excercise', 'Charge your batteries', '58717', '0xFFFE7352', '1', '30', 'time', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('12', 'Go for a walk', 'Strengthen your body and improve your mood', '59073', '0xFF11C480', '1', '3', 'km', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('12', 'Go for a run', 'Break a sweat and relieve stress', '59070', '0xFF11C480', '1', '6', 'km', '1', '2,3,4,5,6,7,8', '1', '1,2,3'),

    ('13', 'Create shoping list', 'Save time and money', '59870', '0xFFFABB37', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('13', 'Reduce restaurant dining', 'Cook something at home', '59785', '0xF53566', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '3', '1,2,3'),
    ('13', 'Make a donation', 'Share your good fortune', '59612', '0xFF1C8EFE', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '3', '1,2,3'),
    ('13', 'Plan spending', 'Prevent impulsive purchases', '59632', '0xFFFE7352', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('13', 'Track expenses', 'Keep a balanced budget', '59517', '0xFFFABB37', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    
    ('14', 'Cuddle', 'Embrace your tender side', '59637', '0xFF1C8EFE', '1', '15', 'time', '1', '2,3,4,5,6,7,8', '2', '1,2,3'),
    ('14', 'Hug and kiss', 'Showing love and affection is easy', '59169', '0xFFF53566', '1', '30', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('14', 'Call your parents', 'One call can make their day', '59663', '0xFF933DFF', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '2', '1,2,3'),
    ('14', 'Meet with a friend', 'Build new memories', '59637', '0xFF11C480', '1', '2', 'hours', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('14', 'Spend time with family', 'Engage and stay connected', '59322', '0xFF11C480', '1', '2', 'hours', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    
    ('15', 'Vacuum', 'Clean out the dirt and dust', '59044', '0xFFF53566', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('15', 'Do the laundry', 'Separate your lights and darks', '59437', '0xFF1C8EFE', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('15', 'Tidy the house', 'Keep it sparkling', '59322', '0xFFFE7352', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('15', 'Take out the trash', 'Clean out for fresh start', '59041', '0xFF11C480', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('15', 'Water plants', 'Help them grow', '59432', '0xFF1C8EFE', '1', '1', 'of times', '1', '2,3,4,5,6,7,8', '2', '1,2,3'),
    
    ('16', 'Limit sugar', 'Replace candy with food', '58913', '0xFFF53566', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('16', 'Tracking the calo', 'Keeping a healthy body', '59168', '0xFFF53566', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('16', 'Take vitamins', 'Get an immune system boost', '58990', '0xFFFABB37', '1', '3', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('16', 'Limit caffeine', 'Try caffeine-free instead', '59426', '0xFF933DFF', '1', '1', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('16', 'Eat fruit and veggies', 'An essential source of nutrients and fiber', '59785', '0xFF11C480', '1', '1', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),

    ('17', 'Play guitar', 'Relax with music and reduce stress', '59543', '0xFFFABB37', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('17', 'Take a photo', 'Keep beautiful momment', '58927', '0xFF933DFF', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('17', 'Paint or draw', 'Feel those creative juices flow', '58903', '0xFFFABB37', '2', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('17', 'Dancing', 'Move your body to the music', '59739', '0xFF11C480', '2', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3')
    ''');

    print('taodb');
  }

  Future<void> insertHabit(Habit habit) async {
    Database db = await instance.database;
    var res = await db.insert(tabHabit, habit.toMap());
    return res;
  }

  // Hàm để lấy thông tin từ bảng Sugget Topic
  Future<List<Map<String, dynamic>>> getSuggestTopicMap() async {
    Database habitTrackerDb = await this.database;
    var queryResult = habitTrackerDb.query(tabSuggestedTopic);

    return queryResult;
  }

  // Hàm lấy thông tin từ bảng Suggest Habit
  Future<List<Map<String, dynamic>>> getSussgestHabitMap(int habitTopic) async {
    Database habitTrackerDb = await this.database;
    var queryResult = habitTrackerDb.query(
      tabSuggestedHabit,
      where: "$maChuDe = $habitTopic",
    );

    return queryResult;
  }

  Future<List<Map<String, dynamic>>> selectAllHabit() async {
    Database db = await instance.database;
    var res = await db.query(tabHabit, orderBy: '$ma DESC');
    return res;
  }

  Future<int> updateHabit(Habit habit) async {
    Database db = await instance.database;
    return await db.update(tabHabit, habit.toMap(),
        where: '$ma = ?', whereArgs: [habit.ma]);
  }
}
