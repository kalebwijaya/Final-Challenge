//
//  AnimateUtils.swift
//  Instabook
//
//  Created by Kaleb Wijaya on 25/04/19.
//  Copyright © 2019 Kaleb Wijaya. All rights reserved.
//

import UIKit

class AnimUtils: NSObject,UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ScrollingAnim(tabBarController : tabBarController)
    }
    
}

class ScrollingAnim: NSObject, UIViewControllerAnimatedTransitioning{
    var transitionContext: UIViewControllerContextTransitioning?
    var tabBarController : UITabBarController!
    var fromIndex = 0
    
    init(tabBarController : UITabBarController) {
        self.tabBarController = tabBarController
        self.fromIndex = tabBarController.selectedIndex
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let containerView = transitionContext.containerView
        
        let fromView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        let toView = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        containerView.addSubview(toView!.view)
        
        var width = toView?.view.bounds.width
        
        if tabBarController.selectedIndex < fromIndex {
            width = -width!
        }
        
        toView!.view.transform = CGAffineTransform(translationX: width!, y: 0)
        
        UIView.animate(withDuration: self.transitionDuration(using: (self.transitionContext)), animations: {
            toView?.view.transform = CGAffineTransform.identity
//            fromView?.view.transform = CGAffineTransform(translationX: -width!, y: 0)
        }, completion: { _ in
            fromView?.view.transform = CGAffineTransform.identity
            self.transitionContext?.completeTransition(!(self.transitionContext?.transitionWasCancelled)!)
        })
    }
}
