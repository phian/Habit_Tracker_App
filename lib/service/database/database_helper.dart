import 'package:habit_tracker/constants/app_constant.dart';
import 'package:habit_tracker/model/diary.dart';
import 'package:habit_tracker/model/habit.dart';
import 'package:habit_tracker/model/process.dart';
import 'package:habit_tracker/model/suggest_topic.dart';
import 'package:habit_tracker/model/suggested_habit.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  final _databaseName = "todo.db";
  final _databaseVersion = 1;

  // table HABIT
  final tableHabit = 'habit';
  final habitId = 'habit_id';
  final habitName = 'habit_name';
  final icon = 'icon';
  final color = 'color';
  final isSetGoal = 'is_set_goal';
  final amount = 'amount';
  final unit = 'unit';
  final repeatMode = 'repeat_mode';
  final dayOfWeek = 'day_of_week';
  final timePerWeek = 'times_per_week';
  final dateOfMonth = 'date_of_month';
  final timeOfDay = 'time_of_day';
  final isSetReminder = 'is_set_reminder';
  final status = 'status';

  //

  final date = 'date';

  // table DIARY
  final tableDiary = "diary";
  final content = "content";

  // table PROCESS
  final tableProcess = 'process';
  final result = 'result';
  final isSkip = 'is_skip';

  // table SUGGESTED TOPIC
  final tableSuggestedTopic = 'suggested_topic';
  final topicId = 'topic_id';
  final topicName = 'topic_name';
  final description = 'description';
  final image = 'image';

  // table SUGGESTED HABIT
  final tableSuggestedHabit = 'suggested_habit';

  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

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
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // TABLE HABIT
    await db.execute('''
    CREATE TABLE $tableHabit (
      $habitId INTEGER PRIMARY KEY AUTOINCREMENT,
      $habitName TEXT,
      $icon INTEGER,
      $color TEXT,
      $isSetGoal INTEGER,
      $amount INTEGER,
      $unit TEXT,
      $repeatMode INTEGER,
      $dayOfWeek TEXT,
      $timePerWeek INTEGER,
      $dateOfMonth TEXT,
      $timeOfDay TEXT,
      $isSetReminder INTEGER DEFAULT 0,
      $status INTEGER DEFAULT 0
    )
    ''');

    // TABLE DIARY
    await db.execute('''
    CREATE TABLE $tableDiary (
      $habitId INTEGER,
      $date TEXT,
      $content TEXT,
      PRIMARY KEY ($habitId, $date),
      FOREIGN KEY($habitId) REFERENCES $tableHabit ($habitId)
    )
    ''');

    // TABLE PROCESS
    await db.execute('''
    CREATE TABLE $tableProcess (
      $habitId INTEGER,
      $date TEXT,
      $result INTEGER DEFAULT 0,
      $isSkip INTEGER DEFAULT 0,
      PRIMARY KEY ($habitId, $date),
      FOREIGN KEY($habitId) REFERENCES $tableHabit ($habitId)
    )
    ''');

    // TABLE SUGGESTED TOPIC
    await db.execute('''
    CREATE TABLE $tableSuggestedTopic (
      $topicId INTEGER PRIMARY KEY AUTOINCREMENT,
      $topicName TEXT,
      $description TEXT,
      $image TEXT
    )
    ''');

    // TABLE SUGGESTED HABIT
    await db.execute('''
    CREATE TABLE $tableSuggestedHabit (
      $topicId INTEGER,
      $habitName TEXT,
      $description TEXT,
      $icon INTEGER,
      $color TEXT,
      $isSetGoal INTEGER,
      $amount INTEGER,
      $unit TEXT,
      $repeatMode INTEGER,
      $dayOfWeek TEXT,
      $timePerWeek INTEGER,
      $timeOfDay TEXT,
      PRIMARY KEY ($topicId, $habitName),
      FOREIGN KEY($topicId) REFERENCES $tableSuggestedTopic ($topicId)
    )
    ''');

    // INSERT DATA SUGGESTED TOPIC
    await db.execute(
        '''INSERT INTO $tableSuggestedTopic ($topicName, $description, $image) 
        VALUES 
        ('Trending habits', 'Take a step in a right direction', '${AppConstants.imagePath}trending_habits.png'),
        ('Staying at home', 'Use this time to do something new', '${AppConstants.imagePath}at_home.png'),
        ('Preventive care', 'Protect yourself and others', '${AppConstants.imagePath}preventive_care.png'),
        ('Must-have habits', 'Small efforts, big results', '${AppConstants.imagePath}must_have_habit.png'),
        ('Morning routine', 'Get started on a productive day', '${AppConstants.imagePath}morning_routine.png'),
        ('Nighttime rituals', 'Sleep tight for better health', '${AppConstants.imagePath}nighttime_rituals.png'),
        ('Getting stuff done', 'Boost your every day productivity', '${AppConstants.imagePath}getting_stuff_done.png'),
        ('Healthy body', 'The foundation of your health well-being', '${AppConstants.imagePath}healthy_body.png'),
        ('Stress relief', 'Release tension and increase and increase calm', '${AppConstants.imagePath}stress_relief.png'),
        ('Mindful-self care', 'Take care with daily activities', '${AppConstants.imagePath}self_care.png'),
        ('Learn and explore', 'Expand your knowledge', '${AppConstants.imagePath}learn_and_explore.png'),
        ('Staying fit', 'Feel strong and increase enrgy', '${AppConstants.imagePath}staying_fit.png'),
        ('Personal finance', 'Take constrol of your budget', '${AppConstants.imagePath}personal_finance.png'),
        ('Loved ones', 'Nature inportant relationships', '${AppConstants.imagePath}loved_ones.png'),
        ('Around the house', 'Clean your space and your mind', '${AppConstants.imagePath}around_the_house.png'),
        ('Tracking the diet', 'Keep your tidy body', '${AppConstants.imagePath}tracking_the_diet.png'),
        ('Live with hobbies', 'Spend this time to do what you like', '${AppConstants.imagePath}live_with_hobbies.png'),
        ('Remove bad habits', 'Make your life better', '${AppConstants.imagePath}bad_habit.png')
         ''');

    // INSERT DATA SUGGESTED HABIT
    await db.execute('''INSERT INTO $tableSuggestedHabit 
    ($topicId, $habitName, $description, $icon, $color, $isSetGoal, $amount, $unit, $repeatMode, $dayOfWeek, $timePerWeek, $timeOfDay)
    VALUES
    ('1', 'Study online', 'A world of new discoveries awaits', '58998', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('1', 'Learn a new language', 'Think of all a things that make you happy. Dream big!', '59730', '0xFF11C480', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('1', 'Read', 'Crack a book and broaden a mind', '59348', '0xFFFE7352', '1', '50', 'pages', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('1', 'Drink water', 'Stay hydrated and flush out toxins', '59430', '0xFF1C8EFE', '1', '10', 'glasses', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('1', 'Morning excercise', 'Charge your batteries', '58717', '0xFFFE7352', '1', '30', 'time', '0', '2,3,4,5,6,7,8', '6', '1'),
    
    ('2', 'Study online', 'A world of new discoveries awaits', '58998', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('2', 'Host movie marathon', 'May the Force be with you!', '59536', '0xFF1C8EFE', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('2', 'Play board game', 'Turn off the TV and challenge every one to play', '58943', '0xFFFE7352', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('2', 'Do a puzzle', 'Puzzles are a calming way to spend time together', '59161', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('2', 'Learn a new language', 'Think of all a things that make you happy. Dream big!', '59730', '0xFF11C480', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('3', 'Wash hands regularly', 'The first step to illness prevention', '59169', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('3', 'Avoid touching face', 'Stop illness before it starts', '59615', '0xFFFE7352', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('3', 'Practice social distancing', 'Avoid crowds to keep safe and healthy', '59637', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('3', 'Use a tissue when coughing', 'Cover your cough to prevent spreading infection', '59830', '0xFF1C8EFE', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('3', 'Disinfect high-touch surfaces', 'Use hand sanitizer to clean frequently used surfaces', '59210', '0xFF11C480', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('4', 'Make time for yourself', 'Stop the daily rush and tune into you', '60120', '0xFF1C8EFE', '1', '60', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('4', 'Set goals', 'Stay motivated and focus', '59938', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('4', 'Sleep for 8 hours', 'Your body will be greatful', '58714', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),    
    ('4', 'Spend time with family', 'Engage and stay connected', '59322', '0xFF11C480', '1', '2', 'hours', '1', '2,3,4,5,6,7,8', '0', '1,2,3'), 
    ('4', 'Read', 'Crack a book and broaden a mind', '59348', '0xFFFE7352', '1', '50', 'pages', '0', '2,3,4,5,6,7,8', '6', '3'),
    
    ('5', 'Practice affirmations', 'Positive thinking can transform your entire life', '60002', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('5', 'Practice visualization', 'Use your power of your subconscious life', '59343', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('5', 'Wake up early', 'Add some extra hours to yuor day', '60130', '0xFF11C480', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('5', 'Make the bed', 'Rise, shine, and start the day off night', '59329', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('5', 'Morning excercise', 'Charge your batteries', '58717', '0xFFFE7352', '1', '30', 'time', '0', '2,3,4,5,6,7,8', '6', '1'),
    
    ('6', 'Reflect on the day', 'Gain perspective and set priorities', '59047', '0xFF1C8EFE', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('6', 'Block distraction', 'Turn off gadgets and devices', '59664', '0xFFFABB37', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('6', 'Sleep for 8 hours', 'Your body will be greatful', '58714', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('6', 'Go to sleep by 11pm', 'Feel refreshed in the morning', '59329', '0xFF11C480', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('6', 'Read', 'Crack a book and broaden a mind', '59348', '0xFFFE7352', '1', '50', 'pages', '0', '2,3,4,5,6,7,8', '6', '3'),
    
    ('7', 'Set goals', 'Stay motivated and focus', '59938', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('7', 'Focus on my dream', 'Think about one step at a time', '59938', '0xFF11C480', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('7', 'Log my time', 'Make every minute count', '60120', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('7', 'Block distraction', 'Turn off gadgets and devices', '59664', '0xFFFABB37', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('7', 'Make a list', 'Stay organized and keep everything on task', '59047', '0xFF1C8EFE', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('8', 'Limit fried food', 'Opt for baked rather than fried', '59168', '0xFFFABB37', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('8', 'Fast', 'Cleanse your body and mind', '59429', '0xFF11C480', '1', '12', 'hours', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('8', 'Limit sugar', 'Replace candy with food', '58913', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('8', 'Cook more often', 'Whip up a favorite recipe', '59383', '0xFFFE7352', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '4', '1,2,3'),
    ('8', 'Limit caffeine', 'Try caffeine-free instead', '59426', '0xFF933DFF', '1', '1', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),

    ('9', 'Practice deep breathing', 'Calm and strengthen your mind', '59908', '0xFFFE7352', '1', '15', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('9', 'Enjoy the sunrise', 'Set your mind to the natural rhythm', '60130', '0xFFFABB37', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('9', 'Practice visualization', 'Use your power of your subconscious life', '59343', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('9', 'Block distraction', 'Turn off gadgets and devices', '59664', '0xFFFABB37', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('9', 'Sleep for 8 hours', 'Your body will be greatful', '58714', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('10', 'Practice deep breathing', 'Calm and strengthen your mind', '59908', '0xFFFE7352', '1', '15', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('10', 'Make time for yourself', 'Stop the daily rush and tune into you', '60120', '0xFF1C8EFE', '1', '60', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('10', 'Connect with nature', 'Slow down and take it all in', '59432', '0xFFFABB37', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('10', 'Practice affirmations', 'Positive thinking can transform your entire life', '60002', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('10', 'Practice visualization', 'Use your power of your subconscious life', '59343', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    
    ('11', 'Listen to podcasts', 'Get educated and informed anytime, anywhere', '59543', '0xFFFE7352', '1', '30', 'time', '1', '2,3,4,5,6,7,8', '2', '1,2,3'),
    ('11', 'Try something new', 'You are capable and more than you know', '59178', '0xFFFE7352', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('11', 'Reflect on the day', 'Gain perspective and set priorities', '59047', '0xFF1C8EFE', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),
    ('11', 'Write anything', 'Find your own voice', '58870', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('11', 'Write my journal', 'Look back at a day and reflect', '59348', '0xFFFE7352', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '3'),

    ('12', 'Limit sugar', 'Replace candy with food', '58913', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('12', 'Drink water', 'Stay hydrated and flush out toxins', '59430', '0xFF1C8EFE', '1', '10', 'glasses', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('12', 'Morning excercise', 'Charge your batteries', '58717', '0xFFFE7352', '1', '30', 'time', '0', '2,3,4,5,6,7,8', '6', '1'),
    ('12', 'Go for a walk', 'Strengthen your body and improve your mood', '59073', '0xFF11C480', '1', '3', 'km', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('12', 'Go for a run', 'Break a sweat and relieve stress', '59070', '0xFF11C480', '1', '6', 'km', '1', '2,3,4,5,6,7,8', '1', '1,2,3'),

    ('13', 'Create shoping list', 'Save time and money', '59870', '0xFFFABB37', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('13', 'Reduce restaurant dining', 'Cook something at home', '59785', '0xF53566', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '3', '1,2,3'),
    ('13', 'Make a donation', 'Share your good fortune', '59612', '0xFF1C8EFE', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '3', '1,2,3'),
    ('13', 'Plan spending', 'Prevent impulsive purchases', '59632', '0xFFFE7352', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('13', 'Track expenses', 'Keep a balanced budget', '59517', '0xFFFABB37', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    
    ('14', 'Cuddle', 'Embrace your tender side', '59637', '0xFF1C8EFE', '1', '15', 'time', '1', '2,3,4,5,6,7,8', '2', '1,2,3'),
    ('14', 'Hug and kiss', 'Showing love and affection is easy', '59169', '0xFFF53566', '1', '30', 'time', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('14', 'Call your parents', 'One call can make their day', '59663', '0xFF933DFF', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '2', '1,2,3'),
    ('14', 'Meet with a friend', 'Build new memories', '59637', '0xFF11C480', '1', '2', 'hours', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('14', 'Spend time with family', 'Engage and stay connected', '59322', '0xFF11C480', '1', '2', 'hours', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    
    ('15', 'Vacuum', 'Clean out the dirt and dust', '59044', '0xFFF53566', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('15', 'Do the laundry', 'Separate your lights and darks', '59437', '0xFF1C8EFE', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('15', 'Tidy the house', 'Keep it sparkling', '59322', '0xFFFE7352', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('15', 'Take out the trash', 'Clean out for fresh start', '59041', '0xFF11C480', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('15', 'Water plants', 'Help them grow', '59432', '0xFF1C8EFE', '1', '1', 'of times', '1', '2,3,4,5,6,7,8', '2', '1,2,3'),
    
    ('16', 'Limit sugar', 'Replace candy with food', '58913', '0xFFF53566', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('16', 'Tracking the calo', 'Keeping a healthy body', '59168', '0xFFF53566', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('16', 'Take vitamins', 'Get an immune system boost', '58990', '0xFFFABB37', '1', '3', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('16', 'Limit caffeine', 'Try caffeine-free instead', '59426', '0xFF933DFF', '1', '1', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('16', 'Eat fruit and veggies', 'An essential source of nutrients and fiber', '59785', '0xFF11C480', '1', '1', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),

    ('17', 'Play guitar', 'Relax with music and reduce stress', '59543', '0xFFFABB37', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('17', 'Take a photo', 'Keep beautiful momment', '58927', '0xFF933DFF', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3'),
    ('17', 'Paint or draw', 'Feel those creative juices flow', '58903', '0xFFFABB37', '0', '0', 'of times', '1', '2,3,4,5,6,7,8', '0', '1,2,3'),
    ('17', 'Dancing', 'Move your body to the music', '59739', '0xFF11C480', '0', '0', 'of times', '0', '2,3,4,5,6,7,8', '6', '1,2,3')
    ''');

    print('taodb');
  }

  Future<int> insertHabit(Habit habit) async {
    Database db = await instance.database;
    var rs = 0;
    try {
      rs = await db.insert(tableHabit, habit.toMap());
    } catch (e) {
      throw e;
    }
    return rs;
  }

  Future<List<SuggestedTopic>> getAllSuggestTopic() async {
    Database db = await this.database;
    List<SuggestedTopic> listTopic = [];
    try {
      var rs = await db.query(tableSuggestedTopic);
      rs.forEach((element) {
        listTopic.add(SuggestedTopic.fromMap(element));
      });
    } catch (e) {
      throw e;
    }
    return listTopic;
  }

  Future<List<SuggestedHabit>> getSussgestHabit(int habitTopic) async {
    Database db = await this.database;
    List<SuggestedHabit> listSuggestedHabit = [];
    try {
      var rs = await db.query(
        tableSuggestedHabit,
        where: "$topicId = $habitTopic",
      );

      rs.forEach((element) {
        listSuggestedHabit.add(SuggestedHabit.fromMap(element));
      });
    } catch (e) {
      throw e;
    }
    return listSuggestedHabit;
  }

  Future<List<Habit>> getAllHabit() async {
    List<Habit> habits = [];
    Database db = await instance.database;

    try {
      var res = await db.query(tableHabit, orderBy: '$habitId DESC');

      res.forEach((map) {
        Habit habit = Habit.fromMap(map);
        habits.add(habit);
      });
    } catch (e) {
      throw e;
    }
    return habits;
  }

  Future<int> updateHabit(Habit habit) async {
    Database db = await instance.database;
    int rs = 0;
    try {
      await db.delete(
        tableProcess,
        where: '$habitId = ?',
        whereArgs: [habit.habitId],
      );

      rs = await db.update(
        tableHabit,
        habit.toMap(),
        where: '$habitId = ?',
        whereArgs: [habit.habitId],
      );
    } catch (e) {
      throw e;
    }
    return rs;
  }

  Future<int> deleteHabit(int idHabit) async {
    Database db = await instance.database;
    int rs = 0;
    try {
      await db.delete(tableDiary, where: '$habitId = ?', whereArgs: [idHabit]);

      await db.delete(tableProcess, where: '$habitId = ?', whereArgs: [idHabit]);

      rs = await db.delete(tableHabit, where: '$habitId = ?', whereArgs: [idHabit]);
    } catch (e) {
      throw e;
    }
    return rs;
  }

  Future<List<Process>> getListHabitProcessByDate(DateTime date) async {
    Database db = await instance.database;
    // convert Datetime sang Sting đúng format
    String formatedDate = dateFormatter.format(date);
    List<Process> listProcess = [];
    try {
      var res = await db.query(
        tableProcess,
        where: '${this.date} = ?',
        orderBy: '$habitId DESC',
        whereArgs: [formatedDate],
      );

      res.forEach((element) {
        Process process = Process.fromMap(element);
        listProcess.add(process);
      });
    } catch (e) {
      throw e;
    }
    return listProcess;
  }

  Future<int> insertProcess(int idHabit, DateTime date) async {
    Database db = await instance.database;
    // convert Datetime sang Sting đúng format
    String formatedDate = dateFormatter.format(date);
    int rs = 0;
    try {
      rs = await db.rawInsert(
        'INSERT OR IGNORE INTO $tableProcess ($habitId,${this.date}) VALUES (?,?)',
        [idHabit, formatedDate],
      );
    } catch (e) {
      throw e;
    }
    return rs;
  }

  Future<int> updateProcess(Process process) async {
    Database db = await instance.database;
    int rs = 0;
    try {
      rs = await db.update(
        tableProcess,
        process.toMap(),
        where: '$habitId = ? and $date = ?',
        whereArgs: [process.habitId, process.date],
      );
    } catch (e) {
      throw e;
    }
    return rs;
  }

  Future<List<Diary>> getNote(int idHabit, DateTime date) async {
    Database db = await instance.database;
    // convert Datetime sang Sting đúng format
    String formatedDate = dateFormatter.format(date);
    List<Diary> diarys = [];
    try {
      var rs = await db.query(
        tableDiary,
        where: '$habitId = ? and ${this.date} = ?',
        whereArgs: [idHabit, formatedDate],
      );

      rs.forEach((element) {
        diarys.add(Diary.fromMap(element));
      });
    } catch (e) {
      throw e;
    }

    return diarys;
  }

  Future<int> insertHabitNote(Diary diary) async {
    Database db = await this.database;
    int result = 0;

    try {
      result = await db.insert(tableDiary, diary.toMap());
    } catch (e) {
      throw e;
    }

    return result;
  }

  Future<int> updateHabitNoteData(Diary diary) async {
    Database database = await this.database;
    int result = 0;

    try {
      result = await database.rawUpdate(
        "update $tableDiary set $content = ? where $habitId = ? and $date = ?",
        [
          diary.content,
          diary.habitId,
          diary.date,
        ],
      );
    } catch (e) {
      throw e;
    }
    return result;
  }

  Future<List<Diary>> getAllNote(int idHabit) async {
    Database db = await instance.database;
    List<Diary> diarys = [];
    try {
      var queryResult = await db.rawQuery("select * from $tableDiary where $habitId = '$idHabit'");

      queryResult.forEach((element) {
        diarys.add(Diary.fromMap(element));
      });
    } catch (e) {
      throw e;
    }
    return diarys;
  }

}
