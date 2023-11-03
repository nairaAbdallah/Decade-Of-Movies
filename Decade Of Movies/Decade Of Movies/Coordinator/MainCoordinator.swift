//
//  MainCoordinator.swift
//  Decade Of Movies
//
//  Created by Naira Bassam on 03/11/2023.
//

import UIKit

// MARK: - Typealias
typealias VCStoryboarded = UIViewController & Storyboarded

// MARK: - Initialization
class MainCoordinator {
    func start<T: VCStoryboarded>(controller: T,
                                  containNav: Bool = false,
                                  with window: UIWindow?,
                                  storyboard: String = Storyboard.master) {
        guard let viewController = type(of: controller.self).instantiate(storyboard) else {return}
        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = true
        window?.rootViewController = containNav ? navController : viewController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
    }
}
// MARK: - Navigation
extension MainCoordinator {
    func navToController<T: VCStoryboarded>(controller: T,
                                            navControl: UINavigationController?,
                                            storyboard: String = Storyboard.master)
    -> T? {
        guard let viewController = type(of: controller.self).instantiate(storyboard) else {return nil}
        navControl?.pushViewController(viewController, animated: true)
        return viewController
    }
}
// MARK: - Present
extension MainCoordinator {
    func presentToVC<T: VCStoryboarded>(controller: T,
                                        _ control: UIViewController?,
                                        storyboard: String = Storyboard.master,
                                        presentaStyle: UIModalPresentationStyle = .overFullScreen,
                                        animated: Bool = true)
    -> T? {
        guard let view = type(of: controller.self).instantiate(storyboard) else {return nil}
        view.modalPresentationStyle = presentaStyle
        control?.present(view, animated: animated)
        return view
    }
}
