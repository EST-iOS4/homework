//
//  MainTabBarViewController.swift
//  TabBarController
//
//  Created by 송영민 on 8/27/25.
//

import UIKit

class MainTabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    delegate = self
    
    let viewController = ViewController()
    
    viewController.tabBarItem = UITabBarItem(
      title: "홈",
      image: UIImage(systemName: "house"),
      tag: 0
    )
    
    // 두번째 뷰 컨트롤러 생성 (기본 뷰 컨트롤러)
    let secondViewController = UIViewController()
    secondViewController.title = "검색"
    
    secondViewController.tabBarItem = UITabBarItem(
      title: "검색",
      image: UIImage(systemName: "magnifyingglass"),
      tag: 1
    )
    //viewControllers = [viewController, secondViewController]
    viewControllers = [
      UINavigationController(rootViewController: viewController),
      UINavigationController(rootViewController: secondViewController)
    ]
    
    customizeTabBar()
  }
  func customizeTabBar() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemBackground
    
    appearance.stackedLayoutAppearance.selected.iconColor = .systemOrange
    appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemOrange]
    
    appearance.stackedLayoutAppearance.normal.iconColor = .systemGray
    appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGray]
    
    tabBar.standardAppearance = appearance
    tabBar.scrollEdgeAppearance = appearance
  }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    return true
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    if let navController = viewController as? UINavigationController,
       let controller = navController.viewControllers.first {
      print("\(controller.title ?? "")탭이 선택 되었습니다.")
    }
  }
}


#Preview {
  MainTabBarViewController()
}

