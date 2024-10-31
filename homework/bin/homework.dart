// 과제

import 'dart:io';

///쇼핑몰 클래스
class ShoppingMall {
  List<Product> productsList = []; // 상품리스트 = 객체(상품명, 가격)
  List<Map<String, dynamic>> cartList = []; // 장바구니 = 맵(상품명, 상품수량)
  late int
      totalPrice; // 카트 내 추가된 상품들의 가격 총합 (메인함수에서 첫 실행 시 0으로 세팅해주며, 장바구니 추가 함수 실행 시 업데이트. 장바구니 초기화하면 다시 0으로 세팅)

  // 상품 목록 출력 함수 - 메뉴 1번 입력시 호출
  void showProductsList() {
    for (var product in productsList) {
      // 반복문으로 리스트 내 항목 노출
      print('${product.name} / ${product.price} 원');
    }
  }

  // 장바구니 추가 함수  - 메뉴 2 번 입력시 호출
  void addToCart() {
    print('상품 이름을 입력해 주세요!'); // 상품명 입력 요청
    String? productName = stdin.readLineSync();
    print('상품 개수를 입력해 주세요!'); //수량 입력 요청
    String? productNumber1 = stdin.readLineSync();
    try {
      //예외 처리문
      int productNumber2 =
          int.parse(productNumber1!); // 사용자 입력 수량을 int로 변환하여 새로운 변수에 저장
      if (productsList.any((product) =>
              product.name ==
              productName) && // 사용자 입력 상품이 상품리스트 내 존재하고 and 사용자가 입력한 수량이 0보다 크다면
          productNumber2 > 0) {
        updateNumber(productName!, productNumber2); // 장바구니 내 상품 수량 업데이트 함수 호출하고
        var findProduct = //상품리스트 내 사용자 입력 상품과 동일한 이름을 가진 객체(product)를 변수에 저장
            productsList
                .firstWhere((product) => product.name == productName); //
        totalPrice += (findProduct.price *
            productNumber2); //찾은 객체의 가격에 사용자 입력 수량을 곱하여 장바구니 가격 총합에 저장
        print('장바구니에 상품이 담겼어요 !');
      } else if (productNumber2 <= 0) {
        // 사용자가 입력한 상품 수량이 0보다 작다면
        print('0개보다 많은 개수의 상품만 담을 수 있어요!');
      } else if (productsList.any((product) => product.name != productName)) {
        // 사용자 입력 상품이 상품 리스트 내 없다면
        print('입력값이 올바르지 않아요!');
      }
    } catch (e) {
      // 혹시 모를 그 외 모든 오류 케이스 처리
      print('입력값이 올바르지 않아요!');
    }
  }

  // 장바구니 내 상품 수량 업데이트 함수
  void updateNumber(String name, int newNumber) {
    for (var product in cartList) {
      if (product['name'] == name) {
        // 사용자 입력 상품과 동일한 이름을 가진 상품(key)가 있다면
        product['number'] = newNumber; // 해당 상품의 가격(value)에 사용자 입력 수량을 저장
        break;
      }
    }
  }

  // 장바구니 내 추가된 상품과 총 가격 총합 출력 함수 - 메뉴 3번 입력시 호출
  void showTotal() {
    var existedProductList = cartList
        .where((product) =>
            product['number'] !=
            0) // 장바구니에 있는 상품(map)들 중 수량(value)rk 0 이 아닌 상품을 필터링하여
        .map((product) => product['name']) // 필터링 된 상품들의 상품명만(key)만 다시 필터링하여
        .toList(); //리스트화
    print(
        '장바구니에 ${existedProductList.join(",")}이 담겨있네요. 총 $totalPrice 원 입니다!'); //join 함수로 existedProductList 내 존재하는 요소와 그리고 장바구니 가격 총합을 포함하여 출력
  }
}

/// Product 클래스
class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

/// 메인
void main() {
  // 1. 쇼핑몰 생성
  ShoppingMall shoppingMall = ShoppingMall();

  // 2. 상품 생성 및 목록에 추가
  shoppingMall.productsList.add(Product('셔츠', 45000));
  shoppingMall.productsList.add(Product('원피스', 30000));
  shoppingMall.productsList.add(Product('반팔티', 35000));
  shoppingMall.productsList.add(Product('반바지', 38000));
  shoppingMall.productsList.add(Product('양말', 5000));

  // 3. 장바구니 목록 추가
  shoppingMall.cartList.addAll([
    {'name': '셔츠', 'number': 0},
    {'name': '원피스', 'number': 0},
    {'name': '반팔티', 'number': 0},
    {'name': '반바지', 'number': 0},
    {'name': '양말', 'number': 0}
  ]);
  // 4. 장바구니 총 가격 세팅
  shoppingMall.totalPrice = 0;

  //루프 시작
  while (true) {
    // 4. 메뉴
    print(
        '-----------------------------------------------------------------------------------');
    print(
        '[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니에 담긴 상품의 총 가격 보기 / [4] 프로그램 종료');
    print(
        '-----------------------------------------------------------------------------------');

    // 5. 사용자 입력값에 따른 실행 (Switch 구문)
    String? inputValue = stdin.readLineSync(); //사용자 입력

    // Switch 구문 시작
    switch (inputValue) {
      case '1': //사용자 입력 번호 1번
        shoppingMall.showProductsList(); // 상품목록 출력 함수 실행
        break;

      case '2': //사용자 입력 번호 2번
        shoppingMall.addToCart(); // 장바구니 추가 함수 실행
        break;

      //사용자가 입력한 번호가 3번
      case '3':
        if (shoppingMall.cartList.every((product) => product['number'] == 0)) {
          //장바구니 내 모든 상품의 수량이 0이라면
          print("장바구니에 담긴 상품이 없습니다");
        } else {
          //수량이 존재한다면
          shoppingMall.showTotal(); //장바구니 내 추가된 상품과 총 가격 총합 출력 함수
          break;
        }

      //사용자가 입력한 번호가 4번
      case '4':
        print("정말 종료하시겠습니까?"); // 다시한번 입력값 요청받기
        String? inputValue2 = stdin.readLineSync();
        if (int.parse(inputValue2!) == 5) {
          // 사용자가 5번 입력시
          print("이용해 주셔서 감사합니다 ~ 안녕히 가세요 !"); // 메세지 노출 후
          return; // 프로그램 종료
        } else {
          // 5번을 입력하지 않을 시에는
          break;
        } // 다시 메뉴로 복귀

      //사용자가 입력한 번호가 6번
      case '6':
        if (shoppingMall.cartList.every((product) => product['number'] == 0)) {
          //장바구니 내 모든 상품의 수량이 0이라면
          print("이미 장바구니가 비어있습니다");
        } else {
          //수량이 존재한다면
          print("장바구니를 초기화 합니다"); //
          // 장바구니 내 모든 상품 수량 초기화 (모든 값을 0으로 저장)
          shoppingMall.updateNumber('셔츠', 0);
          shoppingMall.updateNumber('원피스', 0);
          shoppingMall.updateNumber('반팔티', 0);
          shoppingMall.updateNumber('반바지', 0);
          shoppingMall.updateNumber('양말', 0);
          // 장바구니 내 모든 상품 가격 총합 초기화 (0으로 변경)
          shoppingMall.totalPrice = 0;
        }

      //사용자가 입력한 번호가 1,2,3,4,6 이외라면
      default:
        print('지원하지 않는 기능입니다 ! 다시 시도해 주세요 ..'); //오류메세지 출력
    }
  }
}
