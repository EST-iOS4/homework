//
//  ViewController.swift
//  Message
//
//  Created by 남병수 on 8/28/25.
//

import UIKit

// MARK: - 1. Message Model
struct Message {
    let text: String
    let sender: Sender
    let date: Date
}

enum Sender {
    case me
    case opponent
}


// MARK: - 2. Custom TableViewCell
class ChatMessageCell: UITableViewCell {
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        addSubview(bubbleView)
        addSubview(messageLabel)
        addSubview(timestampLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            bubbleView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            bubbleView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -12),
            bubbleView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 12),
            bubbleView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            
            timestampLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor)
        ])
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with message: Message) {
        messageLabel.text = message.text
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:mm"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        timestampLabel.text = dateFormatter.string(from: message.date)
        
        if message.sender == .me {
            messageLabel.textColor = .white
            bubbleView.backgroundColor = .systemBlue
            leadingConstraint?.isActive = false
            trailingConstraint?.isActive = true
            timestampLabel.trailingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: -8).isActive = true
        } else {
            messageLabel.textColor = .label
            bubbleView.backgroundColor = .secondarySystemBackground
            trailingConstraint?.isActive = false
            leadingConstraint?.isActive = true
            timestampLabel.leadingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: 8).isActive = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leadingConstraint?.isActive = false
        trailingConstraint?.isActive = false
        timestampLabel.text = nil
        for constraint in timestampLabel.constraints {
            if constraint.firstAttribute == .leading || constraint.firstAttribute == .trailing {
                constraint.isActive = false
            }
        }
    }
}


// MARK: - 3. ViewController
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Properties
    
    private var messages: [Message] = [
        Message(text: "채팅방에 입장했습니다. '오늘의 운세 받기' 버튼을 눌러 개발자 운세를 확인해보세요!", sender: .opponent, date: Date())
    ]
    
    private let fortuneMessages: [String] = [
        "오늘 작성한 코드가 내일의 포트폴리오가 될 거예요! 🚀", "버그는 당신을 더 강한 개발자로 만들어주는 스승입니다.", "오늘은 새로운 프레임워크를 배우기 좋은 날이에요!", "당신의 깃허브 잔디가 더욱 푸르러질 예정입니다. 🌱", "코드 리뷰에서 좋은 피드백을 받을 수 있는 날이에요.", "오늘 푼 알고리즘 문제가 면접 질문으로 나올 거예요!", "페어 프로그래밍에서 새로운 인사이트를 얻게 됩니다.", "스택오버플로우에서 원하는 답을 바로 찾을 수 있는 날!", "오늘 작성한 주석이 미래의 당신을 구원할 거예요.", "클린 코드의 중요성을 깨닫게 되는 하루가 될 거예요.", "실패한 빌드도 성장의 과정입니다. 포기하지 마세요!", "오늘의 에러 메시지가 내일의 경험이 됩니다.", "당신의 첫 PR이 머지될 날이 다가오고 있어요! 🎉", "코딩 테스트 준비가 빛을 발할 때가 곧 옵니다.", "팀 프로젝트에서 당신의 아이디어가 채택될 거에요.", "오늘은 리팩토링하기 완벽한 날입니다.", "테스트 코드 작성의 즐거움을 발견하게 될 거에요.", "당신의 코드가 누군가에게 영감을 줄 수 있어요.", "오늘은 새로운 디자인 패턴을 이해하게 되는 날!", "멘토님의 조언이 큰 도움이 될 거예요.", "오늘은 구글링 실력이 특히 중요한 날이 될 거예요... 🔍", "머지 컨플릭트가 예상됩니다. 차분히 해결하세요.", "infinite loop의 위험이 있으니 조건문을 다시 확인하세요.", "오늘은 카페인이 평소보다 더 필요한 날입니다. ☕", "npm install이 한 번에 되지 않을 수 있어요. 인내심을 가지세요.", "코드가 'Hello World'에서 멈출 수도... 하지만 괜찮아요!", "오늘은 Stack Overflow가 당신의 베스트 프렌드입니다.", "undefined is not a function 에러를 만날 가능성이 높아요.", "git push --force는 오늘은 피하는 게 좋겠어요... 😅 ", "배포 금요일은 위험합니다. 월요일을 기다리세요.", "오늘 이해 못한 개념이 갑자기 이해되는 '아하!' 순간이 올 거예요.", "문서를 읽는 것이 구글링보다 빠른 해결책이 될 거예요.", "오늘은 기초를 다시 복습하기 좋은 날입니다.", "새로운 라이브러리 도입은 신중하게 결정하세요.", "튜토리얼 지옥에서 벗어나 실제 프로젝트를 시작하세요!", "오늘은 영어 문서와 친해지기 좋은 날이에요.", "유튜브 강의보다 공식 문서가 더 도움이 될 거예요.", "오늘 배운 내용을 블로그에 정리하면 좋을 것 같아요.", "질문하기를 두려워하지 마세요. 모두가 초보자였습니다.", "오늘은 CS 기초 공부가 빛을 발하는 날이 될 거에요.", "MVP부터 시작하세요. 완벽한 첫 버전은 없습니다.", "오늘은 기능 구현보다 버그 수정에 집중하는 게 좋을 듯해요.", "커밋 메시지를 명확하게 작성하면 미래의 당신이 감사할 거예요.", "오늘은 코드보다 기획이 더 중요한 날입니다.", "데이터베이스 백업을 잊지 마세요... 정말 중요해요! 💾 ", "API 응답이 느릴 수 있으니 타임아웃을 넉넉히 주세요.", "오늘은 디버깅에 시간이 많이 걸릴 수 있어요. 인내심을 가지세요.", "console.log()가 당신의 가장 친한 친구가 될 날입니다.", "주말에도 코딩하고 싶은 마음이 들 거예요... 하지만 쉬세요!", "배포 전 테스트는 세 번 확인해도 부족하지 않아요.", "이력서 업데이트하기 좋은 날이에요. 최근 프로젝트를 추가 하세요!", "코딩 테스트에서 시간 복잡도를 꼭 고려하세요.", "면접 준비할 때 'why'를 설명할 수 있도록 준비하세요.", "포트폴리오 README를 다시 한번 점검해보세요.", "오늘은 네트워킹이 중요한 날! 개발자 커뮤니티에 참여해보세요.", "기술 블로그 작성이 취업에 도움이 될 거예요.", "오픈소스 컨트리뷰션의 기회가 찾아올 수 있어요.", "링크드인 프로필을 업데이트하면 좋은 기회가 올 수도?", "모의 면접 연습이 실전에서 큰 도움이 될 거예요.", "거절도 과정의 일부입니다. 낙담하지 마세요!", "오늘은 동료의 코드를 이해하기 어려운 날일 수 있어요...", "페어 프로그래밍이 생각보다 즐거울 거예요!", "코드 리뷰 때 감정적이지 않게 피드백하세요.", "git blame은 범인 찾기가 아니라 히스토리 확인용입니다! 😊 ", "슬랙 알림을 잠시 꺼두는 것도 집중에 도움이 돼요.", "오늘은 혼자보다 함께 문제를 해결하는 게 빠를 거예요.", "스탠드업 미팅에서 어제의 블로커를 솔직히 공유하세요.", "팀원의 작은 도움이 큰 브레이크스루가 될 수 있어요.", "오늘은 질문하는 것보다 답변하는 일이 많을 거예요.", "코드 컨벤션 논쟁은 피하는 게 정신건강에 좋습니다.", "localhost는 잘 되는데 프로덕션은... 음... 🤔", "캐시 문제일 가능성이 90%입니다. Ctrl+F5를 눌러보세요.", "오늘은 CSS가 당신의 적이 될 수도 있어요. !important는 자제하세요", "regex를 작성하다 하루가 다 갈 수도... 온라인 툴을 활용하세요!", "오늘은 비동기 처리가 특히 까다로울 수 있어요.", "CORS 에러와의 싸움이 예상됩니다. 프록시 설정을 확인하세요.", "타입스크립트가 any의 유혹에 빠지지 마세요!", "오늘은 npm보다 yarn이, yarn보다 pnpm이 나을 수도?", "Mac에서는 되는데 Windows에서는... (또는 그 반대)", "오늘의 버그는 세미콜론 하나 때문일 수도 있어요.", "1년 전 코드를 보고 부끄럽다면, 그만큼 성장한 거예요!", "오늘 어려운 문제도 한 달 후엔 쉬워질 거예요.", "매일 1%씩만 성장해도 1년 후엔 37배가 됩니다.", "오늘의 삽질이 내일의 노하우가 됩니다.", "코딩은 마라톤입니다. 스프린트가 아니에요.", "완벽한 코드보다 동작하는 코드가 우선입니다.", "리팩토링은 나중에... 라고 하면 영원히 안 하게 돼요.", "오늘 배운 걸 누군가에게 가르쳐주면 더 잘 이해하게 돼요.", "임포스터 증후군은 성장의 신호입니다.", "모든 시니어 개발자도 당신과 같은 주니어 시절이 있었어요.", "백엔드 탓, 프론트엔드 탓하지 말고 함께 해결하세요!", "오늘은 REST보다 GraphQL이 더 적합할 수도 있어요.", "다크모드로 코딩하면 눈이 덜 피로할 거예요. 🌙", "러버덕 디버깅을 시도해보세요 고무오리가 답을 알려줄지도?", "오늘은 워라밸이 중요한 날! 정시 퇴근하세요.", "에러 메시지를 끝까지 읽으면 답이 있을 거예요.", "스트레칭을 자주 하세요. 개발자의 목과 허리는 소중하니까요!", "오늘 커밋한 코드가 누군가의 문제를 해결할 수 있어요.", "내일은 오늘보다 더 나은 개발자가 되어 있을 거예요.", "코딩의 즐거움을 잃지 마세요. 그것이 가장 중요합니다! ❤ "
    ]
    
    private let chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "chatCell")
        return tableView
    }()
    
    private let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let messageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메시지를 입력하세요"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
  private let sendButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("전송", for: .normal)
    button.isEnabled = false
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
    
    private let dateHeaderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var inputContainerBottomConstraint: NSLayoutConstraint?
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupDelegates()
        setupActions()
        setupKeyboardHandling()
        setupTapGesture()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    // MARK: Setup

    private func setupUI() {
        self.navigationItem.title = "운세 메신저"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "오늘의 운세 받기", style: .plain, target: self, action: #selector(fortuneButtonTapped))
        view.backgroundColor = .systemBackground
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateHeaderLabel.text = dateFormatter.string(from: Date())
        
        view.addSubview(dateHeaderLabel)
        view.addSubview(chatTableView)
        view.addSubview(messageInputContainerView)
        messageInputContainerView.addSubview(messageTextField)
        messageInputContainerView.addSubview(sendButton)
        
        inputContainerBottomConstraint = messageInputContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        inputContainerBottomConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            dateHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            dateHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            chatTableView.topAnchor.constraint(equalTo: dateHeaderLabel.bottomAnchor, constant: 8),
            chatTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chatTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: messageInputContainerView.topAnchor),
            
            messageInputContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            messageTextField.topAnchor.constraint(equalTo: messageInputContainerView.topAnchor, constant: 8),
            messageTextField.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor, constant: 8),
            messageTextField.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor, constant: -8),
            
            sendButton.leadingAnchor.constraint(equalTo: messageTextField.trailingAnchor, constant: 8),
            sendButton.trailingAnchor.constraint(equalTo: messageInputContainerView.trailingAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: messageTextField.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupDelegates() {
        chatTableView.dataSource = self
        chatTableView.delegate = self
    }
    
  private func setupActions() {
    sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    messageTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
  }
    
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        chatTableView.addGestureRecognizer(tapGesture)
    }

    
    // MARK: Actions

    @objc private func fortuneButtonTapped() {
        let myMessage = Message(text: "오늘의 운세 알려줘.", sender: .me, date: Date())
        addNewMessage(myMessage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self, let randomFortune = self.fortuneMessages.randomElement() else { return }
            let fortuneMessage = Message(text: randomFortune, sender: .opponent, date: Date())
            self.addNewMessage(fortuneMessage)
        }
    }
    
    @objc private func sendButtonTapped() {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        
        let myMessage = Message(text: text, sender: .me, date: Date())
        addNewMessage(myMessage)
        
        messageTextField.text = ""
    }
    
  private func addNewMessage(_ message: Message) {
    messages.append(message)
    let indexPath = IndexPath(row: messages.count - 1, section: 0)
    chatTableView.insertRows(at: [indexPath], with: .none)
    chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
  }
  
  @objc private func textFieldDidChange(_ textField: UITextField) {
    let hasText = !(textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
    sendButton.isEnabled = hasText
  }
  
  @objc private func dismissKeyboard() {
    view.endEditing(true)
  }
    
    // MARK: Keyboard Handling Methods
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        let keyboardHeight = keyboardFrame.height
        inputContainerBottomConstraint?.constant = -keyboardHeight + view.safeAreaInsets.bottom
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        
        inputContainerBottomConstraint?.constant = 0
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    
    // MARK: UITableViewDataSource & UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as? ChatMessageCell else {
            return UITableViewCell()
        }
        let message = messages[indexPath.row]
        cell.configure(with: message)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == messages.count - 1 {
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: 0, y: 20)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                cell.alpha = 1
                cell.transform = .identity
            })
        }
    }
}
