//
//  ViewController.swift
//  SignUpForm
//
//  Created by 송영민 on 8/21/25.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var passwordStengthLabel: UILabel!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var idemailstateLabel: UILabel!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var brithdayTextField: UITextField!
  @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
  @IBOutlet weak var infomationLabel: UILabel!
  @IBOutlet weak var brithdayLabel: UILabel!
  @IBOutlet weak var countryLabel: UILabel!
  @IBOutlet weak var phoneNumberTextField: UITextField!
  @IBOutlet weak var phoneNumberLabel: UILabel!
  @IBOutlet weak var signUpButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    passwordStengthLabel.isHidden = true
    brithdayLabel.isHidden = true
    idemailstateLabel.isHidden = true
    phoneNumberLabel.isHidden = true
    
    idemailstateLabel.numberOfLines = 0
    idemailstateLabel.font = UIFont.systemFont(ofSize: 10)
    
    profileImageView.layer.cornerRadius = 50

    idTextField.placeholder = "아이디"
    passwordTextField.placeholder = "비밀번호"
    emailTextField.placeholder = "[선택] 이메일주소 (비밀번호 찾기 등 본인 확인용)"
    emailTextField.font = UIFont.systemFont(ofSize: 12)
    
    
    
 
    idTextField.addTarget(self, action: #selector(idChanged), for: .editingChanged)
    passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
    emailTextField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
    brithdayTextField.addTarget(self, action: #selector(birthdayChanged), for: .editingChanged)
    phoneNumberTextField.addTarget(self, action: #selector(phoneChanged), for: .editingChanged)
    
    
    nameTextField.placeholder = "이름"
    brithdayTextField.placeholder = "생년월일 8자리"
    phoneNumberTextField.placeholder = "휴대전화번호 010-1111-2222"
    emailTextField.font = UIFont.systemFont(ofSize: 12)

    countryLabel.text = "대한민국 +82"
    setCountryLabelWithIcon()
    
    infomationLabel.text = "신분증 상의 이름, 생년월일, 성별과 일치하지 않으면 실명인증이 불가능합니다."
    infomationLabel.font = UIFont.systemFont(ofSize: 8)
    infomationLabel.textColor = .green

    emailTextField.keyboardType = .emailAddress
    passwordTextField.isSecureTextEntry = true

    idTextField.returnKeyType = .done
    passwordTextField.returnKeyType = .done
    emailTextField.returnKeyType = .done
    brithdayTextField.returnKeyType = .done
    phoneNumberTextField.returnKeyType = .done

    idTextField.delegate = self
    passwordTextField.delegate = self
    emailTextField.delegate = self
    nameTextField.delegate = self
    brithdayTextField.delegate = self
    phoneNumberTextField.delegate = self

    
    signUpButton.setTitle("가입하기", for: .normal)
    signUpButton.setTitleColor(.white, for: .normal)
    signUpButton.backgroundColor = .systemGreen
    signUpButton.layer.cornerRadius = 10
    
    genderSegmentedControl.removeAllSegments()
    genderSegmentedControl.insertSegment(
      withTitle: "남자",
      at: 0,
      animated: false
    )
    genderSegmentedControl.insertSegment(
      withTitle: "여자",
      at: 1,
      animated: false
    )
    genderSegmentedControl.insertSegment(
      withTitle: "선택안함",
      at: 2,
      animated: false
    )

    let idIcon = UIImageView(image: UIImage(systemName: "person"))
    idIcon.tintColor = .gray
    idTextField.leftView = idIcon
    idTextField.leftViewMode = .always

    let passwordIcon = UIImageView(image: UIImage(systemName: "lock"))
    passwordIcon.tintColor = .gray
    passwordTextField.leftView = passwordIcon
    passwordTextField.leftViewMode = .always

    let emailIcon = UIImageView(image: UIImage(systemName: "envelope"))
    emailIcon.tintColor = .gray
    emailTextField.leftView = emailIcon
    emailTextField.leftViewMode = .always

    let nameIcon = UIImageView(
      image: UIImage(systemName: "person.text.rectangle.fill")
    )
    nameIcon.tintColor = .gray
    nameTextField.leftView = nameIcon
    nameTextField.leftViewMode = .always

    let brithdayIcon = UIImageView(image: UIImage(systemName: "calendar"))
    brithdayIcon.tintColor = .gray
    brithdayTextField.leftView = brithdayIcon
    brithdayTextField.leftViewMode = .always

    let phoneNumberIcon = UIImageView(image: UIImage(systemName: "phone"))
    phoneNumberIcon.tintColor = .gray
    phoneNumberTextField.leftView = phoneNumberIcon
    phoneNumberTextField.leftViewMode = .always

    passwordTextField.addTarget(
      self,
      action:
        #selector(passwordChanged),
      for: .editingChanged
    )

    signUpButton.layer.cornerRadius = 10
    signUpButton.isEnabled = false
    signUpButton.alpha = 0.6

  }

  @objc func emailChanged(_ textField: UITextField) {
    updateIdEmailWarnings()
    validateForm()
  }
  
  private func isValidEmail(_ email: String) -> Bool {
    let regex = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
    return NSPredicate(format: "SELF MATCHES[c] %@", regex).evaluate(with: email)
  }
  
  @objc func phoneChanged(_ textField: UITextField) {
    let phone = textField.text ?? ""
    if phone.count <= 12 {
      phoneNumberLabel.isHidden = false
      phoneNumberLabel.text = "010-1111-2222 형식으로 입력해주세요."
      phoneNumberLabel.font = UIFont.systemFont(ofSize: 8)
      phoneNumberLabel.textColor = .systemRed
    } else {
      phoneNumberLabel.isHidden = true
    }
    validateForm()
  }
  
  @objc func idChanged(_ textField: UITextField) {
    updateIdEmailWarnings()
    validateForm()
  }
  
  @objc func birthdayChanged(_ textField: UITextField) {
    let count = textField.text?.count ?? 0
    let isValid = (count == 8)

    brithdayLabel.isHidden = isValid
    if !isValid {
      brithdayLabel.text = "생년월일은 8자리로 입력해 주세요"
      brithdayLabel.font = UIFont.systemFont(ofSize: 12)
      brithdayLabel.textColor = .systemRed
    }
    validateForm()
  }
  
  @objc func passwordChanged(_ textField: UITextField) {
    let password = textField.text ?? ""

     if password.isEmpty {
       passwordStengthLabel.isHidden = true
     } else {
       let strength = calculatePasswordStrength(password)
       passwordStengthLabel.isHidden = false
       passwordStengthLabel.text = strength.text
       passwordStengthLabel.textColor = strength.color
     }
    
    updateIdEmailWarnings()
    validateForm()
  }

  func calculatePasswordStrength(_ password: String) -> (
    text: String, color: UIColor
  ) {
    if password.count < 6 {
      return ("취약", .systemRed)
    } else if password.count < 8 {
      return ("약함", .systemOrange)
    } else if password.rangeOfCharacter(from: .decimalDigits) != nil
      && password.rangeOfCharacter(from: .uppercaseLetters) != nil
    {
      return ("강함", .systemGreen)
    } else {
      return ("보통", .systemYellow)
    }

  }

  func validateForm() {
    let nameValid = !(nameTextField.text?.isEmpty ?? true)
      let enabled = nameValid && !hasAnyWarning()

      signUpButton.isEnabled = enabled
      signUpButton.alpha = enabled ? 1.0 : 0.6
  }
  
  // 이 부분 공부하기 label에 아이콘 + 텍스트 넣는 방법
  func setCountryLabelWithIcon() {
    let config = UIImage.SymbolConfiguration(pointSize: countryLabel.font.pointSize, weight: .regular)
    let img = UIImage(systemName: "globe", withConfiguration: config)?
      .withTintColor(.gray, renderingMode: .alwaysOriginal)

    let attach = NSTextAttachment()
    attach.image = img
    if let size = img?.size {
      attach.bounds = CGRect(x: 0, y: (countryLabel.font.capHeight - size.height)/2, width: size.width, height: size.height)
    }

    let icon = NSAttributedString(attachment: attach)
    let space = NSAttributedString(string: " ")
    let text = NSAttributedString(
      string: countryLabel.text ?? "나라",
      attributes: [.font: countryLabel.font as Any, .foregroundColor: countryLabel.textColor as Any]
    )

    let result = NSMutableAttributedString()
    result.append(icon); result.append(space); result.append(text)
    countryLabel.attributedText = result
  }
  
  
  // 경고 문구 합쳐서 보내는거 신기하네. 하나씩 만들었는데.
  private func updateIdEmailWarnings() {
    let id = idTextField.text ?? ""
    let email = emailTextField.text ?? ""
    let password = passwordTextField.text ?? ""
    
    var messages: [String] = []

    if id.count <= 2 {
        messages.append("아이디는 3자 이상 입력해 주세요")
      }

      if email.isEmpty {
        messages.append("이메일을 입력하세요")
      } else if !isValidEmail(email) {
        messages.append("올바른 이메일 형식이 아닙니다")
      }

      if password.isEmpty {
        messages.append("비밀번호를 입력하세요")
      } else if password.count < 6 {
        messages.append("비밀번호는 6자 이상 입력해 주세요")
      }

      if messages.isEmpty {
        idemailstateLabel.isHidden = true
      } else {
        idemailstateLabel.isHidden = false
        idemailstateLabel.text = messages.joined(separator: "\n")
        idemailstateLabel.textColor = .systemRed
      }
  }
  
  private func isValidPhone(_ phone: String) -> Bool {
    let regex = #"^01[0-9]-\d{3,4}-\d{4}$"#
    return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phone)
  }
  
  private func hasAnyWarning() -> Bool {
    let id = idTextField.text ?? ""
    let email = emailTextField.text ?? ""
    let pwd = passwordTextField.text ?? ""
    let birthdayLen = brithdayTextField.text?.count ?? 0
    let phone = phoneNumberTextField.text ?? ""

    let idInvalid = id.count <= 2
    let emailInvalid = email.isEmpty || !isValidEmail(email)
    let pwdInvalid = pwd.isEmpty || pwd.count < 6
    let birthdayInvalid = birthdayLen != 8
    let phoneInvalid = !phone.isEmpty && !isValidPhone(phone)

    return idInvalid || emailInvalid || pwdInvalid || birthdayInvalid || phoneInvalid
  }

}






//
//  override func viewDidLoad() {
//    super.viewDidLoad()
//    setupUI()
//  }
//
//  func setupUI() {
//    profileImageView.layer.cornerRadius = 50
//    profileImageView.clipsToBounds = true
//    profileImageView.layer.borderWidth = 1
//    profileImageView.layer.borderColor = UIColor.systemGray4.cgColor
//    profileImageView.isUserInteractionEnabled = true
//
//    profileImageView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(selectProfileImage)))
//
//    [nameTextField, emailTextField, passwordTextField].forEach{
//      textField in
//      textField?.delegate = self
//      textField?.layer.borderColor = UIColor.systemGray4.cgColor
//      textField?.layer.borderWidth = 1
//      textField?.layer.cornerRadius = 8
//      textField?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
//      textField?.leftViewMode = .always
//    }
//
//    passwordTextField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
//
//    ageSlider.minimumValue = 18
//    ageSlider.maximumValue = 100
//    ageSlider.value = 30
//    updateAgeLabel()
//
//    signUpButton.layer.cornerRadius = 10
//    signUpButton.isEnabled = false
//    signUpButton.alpha = 0.6
//  }
//
//  @objc func selectProfileImage() {
//    print("프로필 이미지 선택")
//  }
//
//  @objc func passwordChanged(_ textField: UITextField) {
//    guard let password = textField.text else { return }
//
//    let strengt = calculatePasswordStrength(password)
//    passwordStengthLabel.text = strengt.text
//    passwordStengthLabel.textColor = strengt.color
//
//    validateForm()
//  }
//
//  func calculatePasswordStrength(_ password: String) -> (text: String, color: UIColor) {
//
//    if password.count < 6 {
//      return ("너무 짧음", .systemRed)
//    } else if password.count < 8 {
//      return ("약함", .systemOrange)
//    }else if password.rangeOfCharacter(from: .decimalDigits) != nil && password.rangeOfCharacter(from: .uppercaseLetters) != nil {
//      return ("강함", .systemGreen)
//    } else {
//      return ("보통", .systemYellow)
//    }
//  }
//
//  func validateForm() {
//    let isValid = !(nameTextField.text?.isEmpty ?? true) &&
//    !(emailTextField.text?.isEmpty ?? true) &&
//    (passwordTextField.text?.count ?? 0) >= 6 &&
//    agreeSwitch.isOn
//
//    signUpButton.isEnabled = isValid
//    signUpButton.alpha = isValid ? 1.0 : 0.6
//  }
//
//  @IBAction func ageSliderChaged(_ sender: UISlider) {
//    updateAgeLabel()
//  }
//
//  func updateAgeLabel() {
//    ageLabel.text = "\(Int(ageSlider.value))세"
//  }
//
//  @IBAction func agreeSwitchChanged(_ sender: UISwitch) {
//    validateForm()
//  }
//
//  @IBAction func signUpButtonTapped(_ sender: UIButton) {
//    print("회원가입 시도")
//  }
//
//}
//
