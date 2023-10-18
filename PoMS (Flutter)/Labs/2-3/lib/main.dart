import 'dart:convert';

interface class BiggestCompaniesCheck {
  String checkTopHundreedAffilation() {
    return "Проверка на принадлежность к топ-100 компаниям";
  }
}

abstract class FoodFactory implements BiggestCompaniesCheck {
  String _founder = 'Основатель неизвестен';
  bool isOnTop = false;
  String? country;
  double totalIncome = 0;
  String description = '';
  static int count = 0;

  Set brands = {};
  Map concurents = {};

  String info();

  static double stockCalculator(
      {double oneStockPrice = 0, int amountOfStocks = 0}) {
    return oneStockPrice * amountOfStocks;
  }

  static int howMuchStocksToBuy(double money, double oneStockPrice) {
    try {
      int amount = (money / oneStockPrice).floor();
      return amount;
    } catch (e) {
      print("Исключение - невозможно округлить");
    } finally {
      print("Блок finally");
    }
    return 0;
  }

  FoodFactory(this.isOnTop, this.country, this.totalIncome, this.description) {
    FoodFactory.count++;
  }

  static String classInfo() {
    return "Этот класс описывает продуктовые компании 😋";
  }

  void printInfo(Function func1, Function func2) {
    func1();
    func2();
  }

  void printCountry() {
    print("Страна происхождения - $country");
  }

  void printIncome() {
    print("Общая прибыль - $totalIncome млрд долларов ");
  }

  set setFounder(String value) {
    _founder = value;
  }

  String get getFounder {
    return _founder;
  }

  @override
  String checkTopHundreedAffilation() {
    if (isOnTop) {
      return "Компания входит в топ-100 самых больших компаний мира";
    } else {
      return "Компания не входит в топ-100 самых больших компаний мира";
    }
  }
}

mixin MakeCandies {
  void doCandies() {
    print("Компания производит сладости");
  }
}

mixin MakeDrinks {
  void doDrinks() {
    print("Компания производит напитки");
  }
}

class Nestle extends FoodFactory
    with MakeCandies, MakeDrinks
    implements Comparable {
  Nestle(super.isOnTop, super.country, super.totalIncome, super.description);
  Nestle.named(
      super.isOnTop, super.country, super.totalIncome, super.description) {
    super.description += "(создано при помощи именованного конструктора)";
  }
  @override
  String info() {
    return description;
  }

  @override
  int compareTo(other) {
    return totalIncome.compareTo(other.totalIncome);
  }
}

class PepsiCo extends FoodFactory {
  PepsiCo(super.isOnTop, super.country, super.totalIncome, super.description);
  PepsiCo.named(
      super.isOnTop, super.country, super.totalIncome, super.description) {
    super.description += "(создано при помощи именованного конструктора)";
  }

  @override
  String info() {
    return description;
  }

  Future<void> sendMail() async {
    print("Начало отправки ");
    String message = await getMessage();
    print("Получено сообщение: $message");
    print("Завершение отправки");
  }

  Future<String> getMessage() {
    return Future.delayed(
        Duration(seconds: 3), () => "Nestle и Pepsico - конкуренты");
  }
}

class FoodBrandsIterator implements Iterator<String> {
  final List<dynamic> _brands;
  int _currentIndex = 0;

  FoodBrandsIterator(this._brands);

  @override
  String get current {
    if (_currentIndex < _brands.length) {
      return _brands[_currentIndex];
    }
    throw StateError('Больше нет элементов в итераторе');
  }

  @override
  bool moveNext() {
    _currentIndex++;
    return _currentIndex < _brands.length;
  }
}

class FoodBrandsIterable extends Iterable<String> {
  final List<dynamic> _brands;

  FoodBrandsIterable(this._brands);

  @override
  Iterator<String> get iterator => FoodBrandsIterator(_brands);
}

class Buyer {
  String name;
  int age;
  Buyer(this.name, this.age);

  Buyer.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
  };
}

void main(List<String> arguments) {
  print(FoodFactory.classInfo());
  var nestle = Nestle(true, "Швейцария", 74.1,
      "Крупнейшая компания мира по производству продуктов питания");
  var pepsico = PepsiCo.named(false, "США", 70.4,
      "Американская транснациональная корпорация в сфере пищевой промышленности");
  nestle.setFounder = 'Анри Нестле';
  print(nestle.getFounder);
  print(nestle.info());
  print(pepsico.info());
  nestle.printInfo(nestle.printCountry, nestle.printIncome);
  print(
      "Стоимость 23 акций ${FoodFactory.stockCalculator(amountOfStocks: 23, oneStockPrice: 153.2)} долларов ");
  print("---------------------- Работа с exception--------------------------");
  print(
      "На 12412 долларов вы можете купить ${FoodFactory.howMuchStocksToBuy(12412, 5)} акций");

  nestle.brands.add("Nesquik");
  nestle.brands.add("KitKat");
  nestle.brands.add("Nestea");
  nestle.brands.add("Gerber");
  nestle.brands.add("Perrier");
  nestle.brands.add("Perrier");
  print("------------------------------Set----------------------------------");
  print(nestle.brands);
  print("---------------Работа с List (c break и continue)------------------");
  List brandsList = nestle.brands.toList();
  for (var element in brandsList) {
    if (brandsList.indexOf(element) == 4) {
      break;
    } else if (brandsList.indexOf(element) == 2) {
      continue;
    } else {
      print(element);
    }
  }
  print("------------------------------Map----------------------------------");
  nestle.concurents = {
    1: "P&G",
    2: "Kraft",
    3: "Kellog's",
    4: "Pepsico",
    5: "Coca-cola"
  };
  print(nestle.concurents);
  print(nestle.concurents.containsKey(3));
  print(nestle.concurents.containsValue("Apple"));
  nestle.concurents.remove(3);
  print(nestle.concurents);
  print(nestle.concurents.containsKey(3));
  print("--------------------------Mixins----------------------------------");
  nestle.doCandies();
  nestle.doDrinks();
  print("------------------------Comparable-------------------------------");
  print(nestle.compareTo(pepsico));
  print("------------------------Iterator--------------------------------");
  final iterator = FoodBrandsIterator(brandsList);
  while (iterator.moveNext()) {
    print(iterator.current);
  }
  print("------------------------Iterable--------------------------------");
  final iterable = FoodBrandsIterable(brandsList);
  for (final brand in iterable) {
    print(brand);
  }
  print("------методы Iterable");
  print(iterable.isEmpty);
  print(iterable.first);
  print(iterable.last);
  print(iterable.length);
  print(iterable.iterator.current);
  print("------------------------JSON-----------------------------------");
  Buyer male = Buyer("Александр", 20);
  String json = jsonEncode(male);
  print(json);
  Map<String, dynamic> userMap = jsonDecode(json);
  var person = Buyer.fromJson(userMap);
  print("Покупатель ${person.name}, возраст ${person.age} лет");
  print("-------------------Асинхронный метод + Future--------------------");
  pepsico.sendMail();
  print('Выполнение sendMail()');
  print('----------------------------Stream-------------------------------');
  // Создаем Single-Subscription Stream
  final singleSubscriptionStream = Stream<int>.fromIterable([1, 2, 3, 4, 5]);

  // Подписываемся на поток
  final subscription = singleSubscriptionStream.listen(
        (data) => print('Получено: $data'),
    onDone: () => print('Подписка завершена'),
  );

  // Отменяем подписку после 3 секунд
  Future.delayed(Duration(seconds: 1), () {
    subscription.cancel();
  });

  // Создаем Broadcast Stream
  final broadcastStream =
  Stream<int>.periodic(Duration(seconds: 1), (count) => count)
      .take(8)
      .asBroadcastStream();

  // Подписываемся на поток два раза
  final subscription1 =
  broadcastStream.listen((data) => print('Подписка 1: $data'));
  broadcastStream.listen((data) => print('Подписка 2: $data'));

  // Отменяем подписки после 5 секунд
  Future.delayed(Duration(seconds: 5), () {
    subscription1.cancel();
  });
}