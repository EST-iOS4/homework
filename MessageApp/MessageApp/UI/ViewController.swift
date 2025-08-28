//
//  ViewController.swift
//  MessageApp
//
//  Created by 송영민 on 8/28/25.
//

import UIKit

class ViewController: UIViewController {
    let fortuneMessages: [String] = [
        "오늘 작성한 코드가 내일의 포트폴리오가 될 거예요! 🚀",
        "버그는 당신을 더 강한 개발자로 만들어주는 스승입니다.",
        "오늘은 새로운 프레임워크를 배우기 좋은 날이에요!",
        "당신의 깃허브 잔디가 더욱 푸르러질 예정입니다. 🌱",
        "코드 리뷰에서 좋은 피드백을 받을 수 있는 날이에요.",
        "오늘 푼 알고리즘 문제가 면접 질문으로 나올 거예요!",
        "페어 프로그래밍에서 새로운 인사이트를 얻게 됩니다.",
        "스택오버플로우에서 원하는 답을 바로 찾을 수 있는 날!",
        "오늘 작성한 주석이 미래의 당신을 구원할 거예요.",
        "클린 코드의 중요성을 깨닫게 되는 하루가 될 거예요.",
        "실패한 빌드도 성장의 과정입니다. 포기하지 마세요!",
        "오늘의 에러 메시지가 내일의 경험이 됩니다.",
        "당신의 첫 PR이 머지될 날이 다가오고 있어요! 🎉",
        "코딩 테스트 준비가 빛을 발할 때가 곧 옵니다.",
        "팀 프로젝트에서 당신의 아이디어가 채택될 거예요.",
        "오늘은 리팩토링하기 완벽한 날입니다.",
        "테스트 코드 작성의 즐거움을 발견하게 될 거예요.",
        "당신의 코드가 누군가에게 영감을 줄 수 있어요.",
        "오늘은 새로운 디자인 패턴을 이해하게 되는 날!",
        "멘토님의 조언이 큰 도움이 될 거예요.",
        "오늘은 구글링 실력이 특히 중요한 날이에요. 🔍",
        "머지 컨플릭트가 예상됩니다. 차분히 해결하세요.",
        "infinite loop의 위험이 있으니 조건문을 다시 확인하세요.",
        "오늘은 카페인이 평소보다 더 필요한 날입니다. ☕",
        "npm install이 한 번에 되지 않을 수 있어요. 인내심을 가지세요.",
        "코드가 'Hello World'에서 멈출 수도... 하지만 괜찮아요!",
        "오늘은 Stack Overflow가 당신의 베스트 프렌드입니다.",
        "undefined is not a function 에러를 만날 가능성이 높아요.",
        "git push --force는 오늘은 피하는 게 좋겠어요. 😅",
        "배포 금요일은 위험합니다. 월요일을 기다리세요.",
        "오늘 이해 못한 개념이 갑자기 이해되는 '아하!' 순간이 올 거예요.",
        "문서를 읽는 것이 구글링보다 빠른 해결책이 될 거예요.",
        "오늘은 기초를 다시 복습하기 좋은 날입니다.",
        "새로운 라이브러리 도입은 신중하게 결정하세요.",
        "튜토리얼 지옥에서 벗어나 실제 프로젝트를 시작하세요!",
        "오늘은 영어 문서와 친해지기 좋은 날이에요.",
        "유튜브 강의보다 공식 문서가 더 도움이 될 거예요.",
        "오늘 배운 내용을 블로그에 정리하면 좋아요.",
        "질문하기를 두려워하지 마세요. 모두 초보자였습니다.",
        "오늘은 CS 기초 공부가 빛을 발하는 날이 될 거예요.",
        "MVP부터 시작하세요. 완벽한 첫 버전은 없습니다.",
        "오늘은 기능 구현보다 버그 수정에 집중하는 게 좋아요.",
        "커밋 메시지를 명확하게 작성하면 미래의 당신이 감사할 거예요.",
        "오늘은 코드보다 기획이 더 중요한 날입니다.",
        "데이터베이스 백업 잊지 마세요. 정말 중요해요! 💾",
        "API 응답이 느릴 수 있으니 타임아웃을 넉넉히 주세요.",
        "오늘은 디버깅에 시간이 많이 걸릴 수 있어요. 인내심을 가지세요.",
        "console.log()가 당신의 가장 친한 친구가 될 날입니다.",
        "주말에도 코딩하고 싶은 마음이 들 거예요... 하지만 쉬세요!",
        "배포 전 테스트는 세 번 확인해도 부족하지 않아요.",
        "이력서 업데이트하기 좋은 날이에요. 최근 프로젝트를 추가하세요!",
        "코딩 테스트에서 시간 복잡도를 꼭 고려하세요.",
        "면접 준비할 때 'why'를 설명할 수 있도록 준비하세요.",
        "포트폴리오 README를 다시 한번 점검해보세요.",
        "오늘은 네트워킹이 중요한 날! 개발자 커뮤니티에 참여해보세요.",
        "기술 블로그 작성이 취업에 도움이 될 거예요.",
        "오픈소스 컨트리뷰션의 기회가 찾아올 수 있어요.",
        "링크드인 프로필을 업데이트하면 좋은 기회가 올 수도 있어요.",
        "모의 면접 연습이 실전에서 큰 도움이 될 거예요.",
        "거절도 과정의 일부입니다. 낙담하지 마세요!",
        "오늘은 동료의 코드를 이해하기 어려운 날일 수 있어요...",
        "페어 프로그래밍이 생각보다 즐거울 거예요!",
        "코드 리뷰 때 감정적이지 않게 피드백하세요.",
        "git blame은 범인 찾기 아니라 히스토리 확인용입니다! 😊",
        "슬랙 알림을 잠시 꺼두는 것도 집중에 도움이 돼요.",
        "오늘은 혼자보다 함께 문제를 해결하는 게 빠를 거예요.",
        "스탠드업 미팅에서 어제의 블로커를 솔직히 공유하세요.",
        "팀원의 작은 도움이 큰 브레이크스루가 될 수 있어요.",
        "오늘은 질문하는 것보다 답변하는 일이 많을 거예요.",
        "코드 컨벤션 논쟁은 피하는 게 정신 건강에 좋습니다.",
        "localhost는 잘 되는데 프로덕션은... 음... 🤔",
        "캐시 문제일 가능성이 90%입니다. Ctrl+F5를 눌러보세요.",
        "오늘은 CSS가 당신의 적이 될 수도 있어요. !important는 조심!",
        "regex를 작성하다 하루가 다 갈 수도... 온라인 툴을 활용하세요.",
        "오늘은 동기 처리 비동기가 특히 까다로울 수 있어요.",
        "CORS 에러와의 싸움이 예상됩니다. 프록시 설정을 확인하세요.",
        "타입스크립트에서 any의 유혹에 빠지지 마세요!",
        "오늘은 npm보다 yarn이, yarn보다 pnpm이 나을 수도?",
        "Mac에서는 되는데 Windows에서는 안 될 수도 있어요. (또는 그 반대)",
        "오늘의 버그는 세미콜론 하나 때문일 수도 있어요.",
        "1년 전 코드를 보고 부끄럽다면, 그만큼 성장한 거예요!",
        "오늘 어려운 문제도 한 달 후엔 쉬워질 거예요.",
        "매일 1%씩만 성장해도 1년 후엔 37배가 됩니다.",
        "오늘의 삽질이 내일의 노하우가 됩니다.",
        "코딩은 마라톤입니다. 스프린트가 아니에요.",
        "완벽한 코드보다 동작하는 코드가 우선입니다.",
        "리팩토링은 나중에... 라고 하면 영원히 안 하게 돼요.",
        "오늘 배운 걸 누군가에게 가르쳐주면 더 잘 이해하게 돼요.",
        "임포스터 증후군은 성장의 신호입니다.",
        "모든 시니어 개발자도 당신과 같은 주니어 시절이 있었습니다.",
        "백엔드 탓, 프론트엔드 탓하지 말고 함께 해결하세요!",
        "오늘은 REST보다 GraphQL이 더 적합할 수도 있어요.",
        "다크모드로 코딩하면 눈이 덜 피로할 거예요. 🌙",
        "러버덕 디버깅을 시도해보세요. 고무오리가 답을 알려줄지도?",
        "오늘은 워라밸이 중요한 날! 정시 퇴근하세요.",
        "에러 메시지를 끝까지 읽으면 답이 있을 거예요.",
        "스트레칭 자주 하세요. 개발자의 목과 허리는 소중하니까요!",
        "오늘 커밋한 코드가 누군가의 문제를 해결할 수 있어요.",
        "내일은 오늘보다 더 나은 개발자가 되어 있을 거예요.",
        "코딩의 즐거움을 잃지 마세요. 그것이 가장 중요합니다! ❤"
    ]

    let tableView = UITableView()
    let inputBar = InputBarView()
    var inputBarBottomConstraint: NSLayoutConstraint!
    
    private var messages: [Message] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        title = "운세 메신저"
        view.backgroundColor = .systemBackground
        
        //테이블뷰
        tableView.dataSource = self
        tableView.delegate = self
        tableView.keyboardDismissMode = .interactive
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(MessageCell.self, forCellReuseIdentifier:
                            "MessageCell")
        
        
        //아래 하단바
        inputBar.fortuneButton.setTitle("운세", for: .normal)
        inputBar.sendButton.setTitle("보내기", for: .normal)
        inputBar.textField.placeholder = "iMessage"
        
        inputBar.fortuneButton.addTarget(self, action: #selector(getFortune), for: .touchUpInside)
        
        
        inputBar.sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        inputBar.textField.delegate = self
        inputBar.textField.returnKeyType = .send
        
        view.addSubview(tableView)
        view.addSubview(inputBar)
        
//      키보드 내리기 밖에 탭할시
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        inputBar.translatesAutoresizingMaskIntoConstraints = false
        
        //테이블뷰 오토
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        
        //아래바 오토
        inputBarBottomConstraint = inputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBarBottomConstraint,
            inputBar.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        tableView.bottomAnchor.constraint(equalTo: inputBar.topAnchor).isActive = true
    }
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboard(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboard(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func handleKeyboard(notification: Notification) {
           guard let info = notification.userInfo,
                 let endFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
                 let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
                 let curveRaw = (info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
           else { return }

           let endInView = view.convert(endFrame, from: nil)
           let overlap = max(0, view.bounds.maxY - endInView.minY) // 가려지는 높이
           inputBarBottomConstraint.constant = -overlap

           let options = UIView.AnimationOptions(rawValue: curveRaw << 16)
           UIView.animate(withDuration: duration, delay: 0, options: options) {
               self.view.layoutIfNeeded()
               self.scrollToBottom(animated: false)
           }
       }
    
    @objc private func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @objc func sendMessage() {
        guard let text = inputBar.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else { return }
        addMessage(Message(text: text, isMyMessage: true, timestamp: Date()))
        inputBar.textField.text = ""
        
    }
    
    @objc func getFortune() {
        guard let ran = fortuneMessages.randomElement() else { return }
        addMessage(Message(text: ran, isMyMessage: false, timestamp: Date()))
    }
    
    func addMessage(_ message: Message) {
        messages.append(message)
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        
        if tableView.numberOfRows(inSection: 0) == 0 {
            tableView.reloadData()
            tableView.layoutIfNeeded()
        } else {
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        scrollToBottom(animated: true)
    }
    
    func scrollToBottom(animated: Bool) {
        guard !messages.isEmpty else {return}
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let msg = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.configure(with: msg)
        return cell
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
}
