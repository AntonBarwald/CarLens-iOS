//
//  FlowAwareViewController.swift
//  CarLens
//


import UIKit

/// Simple View controller class with helper callbacks for flow management
class FlowAwareViewController: KeyboardAwareViewController {

    /// Closure triggered when view controller will be popped from navigation stack
    var willMoveToParentViewController: ((UIViewController?) -> Void)?

    /// Closure triggered when view controller has been popped from navigation stack
    var onMovingFromParentViewController: (() -> Void)?

    /// Closure triggered when view controller has been pushed into navigation stack
    var onMovingToParentViewController: (() -> Void)?

    /// - SeeAlso: UIViewController.viewWillAppear()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationBarCustomizable = self as? NavigationBarSetupable,
            let navigationController = navigationController {
            navigationBarCustomizable.setup(navigationBar: navigationController.navigationBar)
        }
        if isMovingToParent {
            onMovingToParentViewController?()
        }
    }

    /// - SeeAlso: UIViewController.viewWillDisappear()
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            onMovingFromParentViewController?()
        }
    }

    /// - SeeAlso: UIViewController.willMove()
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        willMoveToParentViewController?(parent)

        // Fix for the glitch when NavigationBar not changed it's style to the end of the pop animation
        guard
            let navigationController = navigationController,
            let controllerIndex = navigationController.viewControllers.index(of: self),
            controllerIndex > 0,
            let previousController = navigationController.viewControllers[controllerIndex-1] as? NavigationBarSetupable
        else { return }
        previousController.setup(navigationBar: navigationController.navigationBar)
    }
}
