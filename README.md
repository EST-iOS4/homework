# Cheetos

간단한 채팅 UI를 가진 iOS 애플리케이션입니다.

## 리포지토리 구조

- `Cheetos`: 채팅 로직을 모듈화한 Swift Package.
- `Cheetos-iOS`: `Cheetos` 패키지를 활용하여 화면을 구성하는 iOS 앱 프로젝트.
- `Cheetos.xcworkspace`: 두 프로젝트를 함께 관리하기 위한 워크스페이스.

코어 로직과 UI를 분리해 로직의 재사용성과 테스트 용이성을 높이고, UI와 독립적으로 개발할 수 있도록 구성했습니다.

## 스크린샷

앱 화면을 여기에 추가할 수 있습니다.

![스크린샷 자리](Docs/screenshot-placeholder.png)

## 테스트

`Cheetos` 패키지는 [swift-testing](https://github.com/apple/swift-testing) 라이브러리를 사용한 비동기 테스트를 포함합니다. 주요 테스트는 다음을 확인합니다.

- 새 포춘(Fortune)과 사용자가 작성한 메시지 생성 시 ID가 올바르게 생성되는지
- 포춘을 가져올 때 로딩 상태가 해제되고 내용과 생성일이 설정되는지
- 이미 가져온 포춘을 다시 가져올 때 적절한 오류가 발생하는지

### 실행 방법

```bash
cd Cheetos
swift test
```

환경에 따라 Swift 6.2 이상의 도구 체인이 필요합니다.

