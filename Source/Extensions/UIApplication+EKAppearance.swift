//
//  UIApplication+EKAppearance.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/25/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

extension UIApplication {
    
    func set(statusBarStyle: EKAttributes.StatusBar) {
        let appearance = statusBarStyle.appearance
        UIApplication.shared.isStatusBarHidden = !appearance.visible
        UIApplication.shared.statusBarStyle = appearance.style
    }

    var c_window: UIWindow? {
        if #available(iOS 13.0, *) {
            if let window = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }).map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.filter({ $0.isKeyWindow }).first {
                return window
            } else if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
                return window
            } else if let window = UIApplication.shared.delegate?.window {
                return window
            } else {
                return nil
            }
        } else {
            if let window = UIApplication.shared.delegate?.window {
                return window
            } else {
                return nil
            }
        }
    }

    var c_rootViewController: UIViewController? {
        if let vc = c_window?.rootViewController {
            return vc
        }
        return c_window?.rootViewController?.c_topViewController
    }
}


extension UIViewController {
    var c_topViewController: UIViewController {
        if presentedViewController == nil {
            return self
        }

        if let navigation = presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.c_topViewController
        }

        if let tab = presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.c_topViewController
            }
            return tab.c_topViewController
        }

        return presentedViewController!.c_topViewController
    }
}
