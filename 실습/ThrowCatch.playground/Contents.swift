enum MealState {
    case initial // 요리시작
    case buyIngredients // 재료구매
    case prepareIngredients // 재료준비
    case cook // 요리
    case plateUp // 플레이팅
    case serve // 서빙
    case complete // 완료
}

enum MealError: Error {
    case canOnlyMoveToAppropriateState //  적정한 상태로만 이동 가능
}


class Meal {
    private(set) var state: MealState = .initial // 읽기 전용 속성 private(set)
    
    // 단계별로 상태를 변경하는 메서드
    func change(to newState: MealState) throws {
        print("change 함수 진입")
         defer {
            state = .complete
            print("defer로 state 변경")
        }
        switch (state, newState) {
        case (.initial, .buyIngredients),
            (.buyIngredients, .prepareIngredients),
            (.prepareIngredients, .cook),
            (.cook, .plateUp),
            (.plateUp, .serve):
            print("상태 변경 진입")
            state = newState
        default:
            print("예외 상황 진입")
            throw MealError.canOnlyMoveToAppropriateState // 순서가 잘못되었다는 오류
        }
    }
}

let dinner = Meal()
//print("Current dinner state #1: \(dinner.state)")
//do {
//    try dinner.change(to: .buyIngredients) // 재료 구매 단계로 변경
//    print("Current dinner state #2: \(dinner.state)")
//    try dinner.change(to: .serve)
//} catch let error {
//    print("Error changing state: \(error)")
//}
//  보호해주는게 주된 사용 이유 / 적절한 실행 흐름으로 만들어 주는거 목표
do {
    print("----------")
    try dinner.change(to: .buyIngredients) // 재료 구매 단계로 변경
    print("----------")
    try dinner.change(to: .prepareIngredients)
    print("----------")
    try dinner.change(to: .cook)
    print("----------")
    try dinner.change(to: .plateUp)
    print("----------")
    try dinner.change(to: .serve)
    print("저녁준비가 끝났습니다.")
    //try dinner.change(to: .serve)
} catch let error {
    print("Error changing state: \(error)")
}
// try? 는 오류가 발생하도 무시하고 nil을 반환
try? dinner.change(to: .initial) // 잘못된 상태 변경 시도

print("현재 상태: \(dinner.state)")
