import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onlinecheckin/global/Classes.dart';

class RouteNames {
  RouteNames._();

  static const initialRoute = '/';
  static const splash = '/splashScreen';
  static const home = '/homeScreen';
  static const enter = '/enterScreen';
  static const steps = '/stepsScreen';
  static const safety = '/safetyScreen';
  static const rules = '/rulesScreen';
  static const passport = '/passportScreen';
  static const visa = '/visaScreen';
  static const payment = '/paymentScreen';
  static const upgrades = '/upgradesScreen';
  static const receipt = '/receiptScreen';
  static const seats = '/seatsScreen';
}

class Apis {
  Apis._();

  static const baseUrl = 'https://onlinecheckinapi.abomis.com/';

  // static const baseUrl = 'https://onlinecheckinapi-test.abomis.com/';
  static const login = '/api/login';
  static const signUp = '/api/signUp';
  static const getTokenUrl = 'api/Execute';
  static const getInformation = 'api/Execute';
  static const getDocumentType = 'api/Execute';
  static const getSelectCountries = 'api/Execute';
  static const saveDocsDocoDoca = 'api/Execute';
  static const clickOnSeat = 'api/Execute';
  static const reserveSeat = 'api/Execute';
  static const selectBoardingPass = 'api/Execute';
  static const addTransaction = 'api/Execute';
  static const updateTransaction = 'api/Execute';
  static const boardingPassPDF = 'api/MemoStrm';
  static const boardingPassSendEmail = 'http://localhost:64328/api/SendEmail';
  static const getCheckDocoNecessity = 'api/Execute';
  static const selectSeatExtras = 'api/Execute';
}

class MyTheme {
  MyTheme._();

  static ThemeData light = ThemeData.light().copyWith(
      primaryColor: Colors.deepOrange,
      accentColor: Colors.blue,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        primary: Colors.deepPurple,
      )));

  static ThemeData dark = ThemeData.dark().copyWith(
    primaryColor: Colors.deepPurple,
    accentColor: Colors.grey,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      primary: Colors.deepOrange,
    )),
  );
}

class MenuIcons {
  MenuIcons._();

  static const _kFontFam = 'icomoon';
  static const String? _kFontPkg = null;

  static const IconData iconEvent = IconData(0xe934, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconRight = IconData(0xe915, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconLeft = IconData(0xe914, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconAccount = IconData(0xe908, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconInfo = IconData(0xe92d, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconPassport = IconData(0xe928, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconVisa = IconData(0xe922, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData star = IconData(0xe940, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconSeat = IconData(0xe924, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconCard = IconData(0xe93b, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconTask = IconData(0xe91e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconEdit = IconData(0xe907, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconCalendar = IconData(0xe90a, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconLeftArrow = IconData(0xe90e, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconRightArrow = IconData(0xe910, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconDownLoad = IconData(0xe946, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconPrint = IconData(0xe906, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData iconAdd = IconData(0xe909, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

class TranslatedWords extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'Last Name': 'Last Name',
          "Online Check-in": "Online Check-in",
          "Input Requested info in order to continue": "Input Requested info in order to continue",
          "Last Name can't be empty": "Last Name can't be empty",
          "Booking reference name": "Booking reference name",
          "Booking reference name can't be empty": "Booking reference name can't be empty",
          "Check-in": "Check-in",
          "Ready to go?": "Ready to go?",
          "There are a few things to know before boarding.": "There are a few things to know before boarding.",
          "When can I check in?": "When can I check in?",
          "You can check in on our website up to 24 hours before departure until one (1) hour before departure. Airport check-in opens three hours (3) prior to departure.":
              "You can check in on our website up to 24 hours before departure until one (1) hour before departure. Airport check-in opens three hours (3) prior to departure.",
          "Next": "Next",
          "Previous": "Previous",
          "© Copyright 2021 Abomis All rights reserved": "© Copyright 2021 Abomis All rights reserved",
          "Travellers": "Travellers",
          "Safety": "Safety",
          "Rules": "Rules",
          "Passport": "Passport",
          "Visa": "Visa",
          "Upgrades": "Upgrades",
          "Seats": "Seats",
          "Payment": "Payment",
          "Receipt": "Receipt",
          "Download": "Download",
          "Print": "Print",
          "Sent to Mobile": "Sent to Mobile",
          "Seat": "Seat",
          "Add Travellers": "Add Travellers",
          "Add all passengers to the list on the left here": "Add all passengers to the list on the left here",
          "Reservation ID / Ticket Number": "Reservation ID / Ticket Number",
          "Reservation ID / Ticket Number can't be empty": "Reservation ID / Ticket Number can't be empty",
          "Enter passport data (DOCS) for all the passengers.": "Enter passport data (DOCS) for all the passengers.",
          "Add Passport Info": "Add Passport Info",
          "Pay with credit card, Visa or debit or Mastercard debit": "Pay with credit card, Visa or debit or Mastercard debit",
          "Taxes & Fees": "Taxes & Fees",
          "Total": "Total",
          "Including taxes and fees": "Including taxes and fees",
          "Billing Address": "Billing Address",
          "Address": "Address",
          "Card Number": "Card Number",
          "Province / State": "Province / State",
          "City": "City",
          "Postal / Zip Code": "Postal / Zip Code",
          "Card Info": "Card Info",
          "Cardholder Name": "Cardholder Name",
          'pay': 'pay',
          "Unable to load boarding pass": "Unable to load boarding pass",
          "Finished!": "Finished!",
          "You can see your check-in below, print it or download it or send it to your mobile": "You can see your check-in below, print it or download it or send it to your mobile",
          "Dangerous Goods": "Dangerous Goods",
          "Every items can become dangerous when transported by air. Example of dangerous goods are:": "Every items can become dangerous when transported by air. Example of dangerous goods are:",
          "Your Commitment to Safety": "Your Commitment to Safety",
          "In the past 10 days, I/we have not had a COVID-19 diagnosis and have not experienced the onset of any one of the primary symptoms of COVID-19.":
              "In the past 10 days, I/we have not had a COVID-19 diagnosis and have not experienced the onset of any one of the primary symptoms of COVID-19.",
          "I/we have not been in close contact with someone who has COVID-19 in the past 10 days. EXCEPTION: I/we have been fully vaccinated for at least 2 weeks or have had COVID-19 within the last 90 days and fully recovered so that I/we are not contagious, and I/we remain symptom free.":
              "I/we have not been in close contact with someone who has COVID-19 in the past 10 days. EXCEPTION: I/we have been fully vaccinated for at least 2 weeks or have had COVID-19 within the last 90 days and fully recovered so that I/we are not contagious, and I/we remain symptom free.",
          "I/we will wear a face mask throughout the airport, in Delta Sky Clubs and onboard the aircraft, even if fully vaccinated, unless I meet the criteria for exemptions.":
              "I/we will wear a face mask throughout the airport, in Delta Sky Clubs and onboard the aircraft, even if fully vaccinated, unless I meet the criteria for exemptions.",
          "Please read our": "Please read our",
          "travel policy": "travel policy",
          "to delay or cancel your trip if you are unable to accept the above commitments.": "to delay or cancel your trip if you are unable to accept the above commitments.",
          "Full Policy": "Full Policy",
          "The Standard For Safer Travel": "The Standard For Safer Travel",
          "Delta’s Commitment to You": "Delta’s Commitment to You",
          "The Delta CareStandard℠ focuses on creating a safer experience for everyone. We are complying with Federal regulations that require face masks to be worn at all times and your aircraft will be cleaned before every flight.":
              "The Delta CareStandard℠ focuses on creating a safer experience for everyone. We are complying with Federal regulations that require face masks to be worn at all times and your aircraft will be cleaned before every flight.",
          "First Class": "First Class",
          "Business": "Business",
          "Economy":"Economy",
          "HorizontalCode": "HorizontalCode",
          "Exit": "Exit",
          "All upgrades are non-refundable": "All upgrades are non-refundable",
          "Wines & Drinks": "Wines & Drinks",
          "Starts from": "Starts from",
          "Add": "Add",
          "Entertainment": "Entertainment",
          "No need to add visa": "No need to add visa",
          "Enter visa data (DOCO) for all the passengers.": "Enter visa data (DOCO) for all the passengers.",
          "Passport No: ": "Passport No: ",
          "Add Visa Info": "Add Visa Info",
          "Visa No: 45687": "Visa No: 45687",
          "Add to Travellers": "Add to Travellers",
          "Check Pandemic Safety": "Check Pandemic Safety",
          "Check Rules": "Check Rules",
          "Add Passports": "Add Passports",
          "Add Visa": "Add Visa",
          "Select Upgrades": "Select Upgrades",
          "Select Seats": "Select Seats",
          "Get Boarding Pass": "Get Boarding Pass",
          "This passenger was added before": "This passenger was added before",
          "Duplicate traveller": "Duplicate traveller",
          "Booking reference name can not be empty": "Booking reference name can not be empty",
          "LastName can not be empty": "LastName can not be empty",
          "Wrong LastName or Booking reference name": "Wrong LastName or Booking reference name",
          "Error": "Error",
          "Magnetic Objects": "Magnetic Objects",
          "Magnets, Batteries and Magnetic Objects": "Magnets, Batteries and Magnetic Objects",
          "Type of Toxins": "Type of Toxins",
          "Powder, Liquid and Sprays of Laboratory Products For Infectious Agents": "Powder, Liquid and Sprays of Laboratory Products For Infectious Agents",
          "Radioactive Material": "Radioactive Material",
          "Radioactive Substances Exposed To Radiation": "Radioactive Substances Exposed To Radiation",
          "Types of Spray": "Types of Spray",
          "Spray Containers (Including Spray Dispensers)": "Spray Containers (Including Spray Dispensers)",
          "Types of Capsule": "Types of Capsule",
          "Gas Lighters, Oxygen and Any Type of Gas Cylinder": "Gas Lighters, Oxygen and Any Type of Gas Cylinder",
          "Incendiary types": "Incendiary types",
          "Matches are Just a Small Number Along With (strictly prohibited in the box)": "Matches are Just a Small Number Along With (strictly prohibited in the box)",
          "Types of Explosives ": "Types of Explosives ",
          "Types of Ammunition, Explosives, Firecrackers and Fireworks Accessories": "Types of Ammunition, Explosives, Firecrackers and Fireworks Accessories",
          "Types of Oxidizing": "Types of Oxidizing",
          "Oxidizing and Oxidizing Materials, Detergents and Disinfectants": "Oxidizing and Oxidizing Materials, Detergents and Disinfectants",
          "Types of Weapons": "Types of Weapons",
          "Any Firearms or Cold Weapons (Knives, Scissors, Horns, Colt)": "Any Firearms or Cold Weapons (Knives, Scissors, Horns, Colt)",
          "Types of Acidic": "Types of Acidic",
          "Wet batteries, acidic substances, acidic fluids (lemon juice, pickles, etc.)": "Wet batteries, acidic substances, acidic fluids (lemon juice, pickles, etc.)",
          "ID": "ID",
          "Submit": "Submit",
          "Passport Type": "Passport Type",
          "Country of Issue": "Country of Issue",
          "Gender": "Gender",
          "Male": "Male",
          "Female": "Female",
          "Nationality": "Nationality",
          "Passport / Visa Details": "Passport / Visa Details",
          "Document No.": "Document No.",
          "Entry Date": "Entry Date",
          "Date of Birth": "Date of Birth",
          'Type': 'Type',
          "Place of issue":"Place of issue",
          "A valid visa is required for entry. please enter here the information about your visa you want to present at your final destination":"A valid visa is required for entry. please enter here the information about your visa you want to present at your final destination",
          "Issue Date":"Issue Date",
          "Destination":"Destination",

        },
        'fa_IR': {
          'Last Name': 'نام خانوادگی',
          "Online Check-in": "ثبت نام آنلاین",
          "Last Name can't be empty": "نام خانوادگی نمی تواند خالی باشد",
          "Booking reference name": "نام مرجع رزرو",
          "Booking reference name can't be empty": "نام مرجع رزرو نمی تواند خالی باشد",
          "Input Requested info in order to continue": "برای ادامه اطلاعات درخواست شده را وارد کنید",
          "Check-in": "ثبت نام",
          "Ready to go?": "آماده رفتن؟",
          "There are a few things to know before boarding.": "چند نکته وجود دارد که قبل از سوار شدن باید بدانید.",
          "When can I check in?": "چه زمانی می توانم ثبت نام کنم؟",
          "You can check in on our website up to 24 hours before departure until one (1) hour before departure. Airport check-in opens three hours (3) prior to departure.":
              "شما می توانید تا 24 ساعت قبل از حرکت تا یک (1) ساعت قبل از حرکت در وب سایت ما بررسی کنید. چک-این فرودگاه سه ساعت (3) قبل از حرکت باز می شود.",
          "Next": "بعدی",
          "Previous": "قبلی",
          "© Copyright 2021 Abomis All rights reserved": "© Copyright 2021 Abomis کلیه حقوق محفوظ است",
          "Travellers": "مسافران",
          "Safety": "ایمنی",
          "Rules": "قوانین",
          "Passport": "گذرنامه",
          "Visa": "ویزا",
          "Upgrades": "ارتقا",
          "Seats": "صندلی ها",
          "Payment": "پرداخت",
          "Receipt": "اعلام وصول",
          "Download": "دانلود",
          "Print": "Print",
          "Sent to Mobile": "ارسال به موبایل",
          "Seat": "صندلی",
          "Add Travellers": "مسافران را اضافه کنید",
          "Add all passengers to the list on the left here": "در اینجا همه مسافران را به لیست سمت چپ اضافه کنید",
          "Reservation ID / Ticket Number": "شناسه رزرو / شماره بلیط",
          "Reservation ID / Ticket Number can't be empty": "شناسه رزرو / شماره بلیط نمی تواند خالی باشد",
          "Enter passport data (DOCS) for all the passengers.": "اطلاعات پاسپورت (DOCS) را برای همه مسافران وارد کنید.",
          "Add Passport Info": "افزودن اطلاعات پاسپورت",
          "Pay with credit card, Visa or debit or Mastercard debit": "پرداخت با کارت اعتباری، ویزا یا بدهی یا مسترکارت",
          "Taxes & Fees": "مالیات و هزینه ها",
          "Total": "جمع",
          "Including taxes and fees": "شامل مالیات و عوارض",
          "Billing Address": "آدرس قبض",
          "Address": "نشانی",
          "Card Number": "شماره کارت",
          "Province / State": "استان / ایالت",
          "City": "شهر",
          "Postal / Zip Code": "پستی / کد پستی",
          "Card Info": "اطلاعات کارت",
          "Cardholder Name": "نام دارنده کارت",
          'pay': 'پرداخت',
          "Unable to load boarding pass": "لود کردن کارت پرواز ممکن نیست",
          "Finished!": "تمام شده!",
          "You can see your check-in below, print it or download it or send it to your mobile":
              "شما می توانید اعلام حضور خود را در زیر مشاهده کنید، آن را چاپ کنید یا دانلود کنید یا به تلفن همراه خود ارسال کنید",
          "Dangerous Goods": "کالاهای خطرناک",
          "Every items can become dangerous when transported by air. Example of dangerous goods are:": "هر اقلام می تواند در صورت حمل و نقل هوایی خطرناک شود. نمونه ای از کالاهای خطرناک عبارتند از:",
          "Your Commitment to Safety": "تعهد شما به ایمنی",
          "In the past 10 days, I/we have not had a COVID-19 diagnosis and have not experienced the onset of any one of the primary symptoms of COVID-19.":
              "در 10 روز گذشته، من یا ما تشخیص COVID-19 نداشته ایم و شروع هیچ یک از علائم اولیه COVID-19 را تجربه نکرده ایم.",
          "I/we have not been in close contact with someone who has COVID-19 in the past 10 days. EXCEPTION: I/we have been fully vaccinated for at least 2 weeks or have had COVID-19 within the last 90 days and fully recovered so that I/we are not contagious, and I/we remain symptom free.":
              "من/ما در 10 روز گذشته با کسی که کووید-19 داشته است در تماس نزدیک نبوده ایم. استثناء: من/ما حداقل 2 هفته به طور کامل واکسینه شده ایم یا در 90 روز گذشته و به طور کامل COVID-19 داشته ایم. بهبود یافته تا من/ما مسری نباشیم و من/ما عاری از علائم باقی بمانیم.",
          "I/we will wear a face mask throughout the airport, in Delta Sky Clubs and onboard the aircraft, even if fully vaccinated, unless I meet the criteria for exemptions.":
              "من/ما در سرتاسر فرودگاه، باشگاه‌های دلتا اسکای و داخل هواپیما از ماسک استفاده می‌کنیم، حتی اگر کاملاً واکسینه شده باشند، مگر اینکه معیارهای معافیت‌ها را رعایت کنم.»",
          "Please read our": "لطفا ما را بخوانید",
          "travel policy": "travel policy",
          "to delay or cancel your trip if you are unable to accept the above commitments.": "در صورت عدم توانایی در پذیرش تعهدات فوق، سفر خود را به تاخیر انداخته یا لغو کنید.",
          "Full Policy": "سیاست کامل",
          "The Standard For Safer Travel": "استاندارد برای سفر ایمن تر",
          "Delta’s Commitment to You": "تعهد دلتا به شما",
          "The Delta CareStandard℠ focuses on creating a safer experience for everyone. We are complying with Federal regulations that require face masks to be worn at all times and your aircraft will be cleaned before every flight.":
              "Delta CareStandard℠ بر ایجاد تجربه ایمن تر برای همه تمرکز می کند. ما از قوانین فدرال پیروی می کنیم که ماسک صورت را باید همیشه پوشیده باشد و هواپیمای شما قبل از هر پرواز تمیز می شود.",
          "First Class": "فرست کلاس",
          "Business": "بیزینس",
          "Economy":"اکونومی",
          "Exit": "خروج",
          "All upgrades are non-refundable": "همه ارتقاءها غیر قابل استرداد هستند",
          "Wines & Drinks": "شراب ها و نوشیدنی ها",
          "Starts from": "شروع از",
          "Add": "افزودن",
          "Entertainment": "سرگرمی",
          "No need to add visa": "نیازی به اضافه کردن ویزا نیست",
          "Enter visa data (DOCO) for all the passengers.": "اطلاعات ویزا (DOCO) را برای همه مسافران وارد کنید.",
          "Passport No: ": "شماره پاسپورت: ",
          "Add Visa Info": "افزودن اطلاعات ویزا",
          "Visa No: 45687": "شماره ویزا: 45687",
          "Add to Travellers": "افزودن به مسافران",
          "Check Pandemic Safety": "ایمنی همه گیر را بررسی کنید",
          "Check Rules": "بررسی قوانین",
          "Add Passports": "افزودن گذرنامه",
          "Add Visa": "افزودن ویزا",
          "Select Upgrades": "انتخاب ارتقاء",
          "Select Seats": "انتخاب صندلی",
          "Get Boarding Pass": "دریافت کارت پرواز",
          "This passenger was added before": "این مسافر قبلا اضافه شده بود",
          "Duplicate traveller": "مسافر تکراری",
          "Booking reference name can not be empty": "نام مرجع رزرو نمی تواند خالی باشد",
          "LastName can not be empty": "نام خانوادگی نمی تواند خالی باشد",
          "Wrong LastName or Booking reference name": "نام خانوادگی یا نام مرجع رزرو اشتباه",
          "Error": "خطا",
          "Magnetic Objects": "اجرای مغناطیسی",
          "Magnets, Batteries and Magnetic Objects": "مگنت ها، باتری ها و اجسام مغناطیسی",
          "Type of Toxins": "نوع سموم",
          "Powder, Liquid and Sprays of Laboratory Products For Infectious Agents": "پودر، مایع و اسپری محصولات آزمایشگاهی برای عوامل عفونی",
          "Radioactive Material": "مواد رادیواکتیو",
          "Radioactive Substances Exposed To Radiation": "مواد رادیواکتیو در معرض تابش",
          "Types of Spray": "انواع اسپری",
          "Spray Containers (Including Spray Dispensers)": "ظروف اسپری (از جمله اسپری پخش کننده ها)",
          "Types of Capsule": "انواع کپسول",
          "Gas Lighters, Oxygen and Any Type of Gas Cylinder": "فندک گاز، اکسیژن و هر نوع سیلندر گاز",
          "Incendiary types": "انواع آتش زا",
          "Matches are Just a Small Number Along With (strictly prohibited in the box)": "مسابقه فقط یک عدد کوچک همراه با آن است (اکیداً در جعبه ممنوع است)",
          "Types of Explosives ": "انواع مواد منفجره",
          "Types of Ammunition, Explosives, Firecrackers and Fireworks Accessories": "انواع مهمات، مواد منفجره، ترقه و لوازم آتش بازی",
          "Types of Oxidizing": "انواع اکسید کننده",
          "Oxidizing and Oxidizing Materials, Detergents and Disinfectants": "مواد اکسید کننده و اکسید کننده، شوینده ها و ضد عفونی کننده ها",
          "Types of Weapons": "انواع سلاح",
          "Any Firearms or Cold Weapons (Knives, Scissors, Horns, Colt)": "هر گونه سلاح گرم یا سلاح سرد (چاقو، قیچی، شاخ، کلت)",
          "Types of Acidic": "انواع اسیدی",
          "Wet batteries, acidic substances, acidic fluids (lemon juice, pickles, etc.)": "باتری های مرطوب، مواد اسیدی، مایعات اسیدی (آب لیمو، ترشی و غیره)",
          "ID": "شناسه",
          "Submit": "ارسال",
          "Passport Type": "نوع پاسپورت",
          "Country of Issue": "کشور صادرکننده",
          "Gender": "جنسیت",
          "Male": "مرد",
          "Female": "زن",
          "Nationality": "ملیت",
          "Passport / Visa Details": "جزئیات گذرنامه / ویزا",
          "Document No.": "شماره سند.",
          "Entry Date": "تاریخ ورود",
          "Date of Birth": "تاریخ تولد",
          'Type': "نوع",
          "Place of issue":"محل صدور",
          "A valid visa is required for entry. please enter here the information about your visa you want to present at your final destination":"ویزای معتبر برای ورود لازم است. لطفاً اطلاعات مربوط به ویزای خود را که می خواهید در مقصد نهایی ارائه دهید را در اینجا وارد کنید.",
          "Issue Date":"تاریخ صدور",
          "Destination":"مقصد",

        },
      };
}
