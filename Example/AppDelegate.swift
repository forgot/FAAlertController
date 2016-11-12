//
//  AppDelegate.swift
//  FAAlertControllerExample
//
//  Created by Jesse Cox on 11/9/16.
//  Copyright © 2016 Apprhythmia LLC. All rights reserved.
//

import UIKit
import FAAlertController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}




















































extension CustomStyleViewController {
    
    @IBAction func fabulousSecretPowers() {
        class WhatsUp: UIView {
            override func draw(_ rect: CGRect) {
                //// General Declarations
                let context = UIGraphicsGetCurrentContext()!
                
                
                //// Image Declarations
                let whatsup = #imageLiteral(resourceName: "whatsup")
                
                //// Picture Drawing
                let picturePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 750, height: 1334))
                context.saveGState()
                picturePath.addClip()
                context.scaleBy(x: 1, y: -1)
                context.draw(whatsup.cgImage!, in: CGRect(x: 0, y: 0, width: whatsup.size.width, height: whatsup.size.height), byTiling: true)
                context.restoreGState()
                
            }
        }
        struct MastersOfTheAppearanceDelegate: FAAlertControllerAppearanceDelegate {
            
            var buttonTintColor: UIColor {
                return .orange
            }
            var destructiveButtonTintColor: UIColor {
                return .green
            }
            var titleTextColor: UIColor {
                return .red
            }
            var messageTextColor: UIColor {
                return .blue
            }
            var blurStyle: UIBlurEffectStyle {
                return .light
            }
            var backdropColor: UIColor {
                return UIColor(red: 0.998, green: 0.357, blue: 0.651, alpha: 1.000)
            }
            var backdropBlendMode: CGBlendMode {
                return .hue
            }
            var textFieldTextColor: UIColor {
                return .cyan
            }
            var textFieldPlaceholderTextColor: UIColor {
                return .magenta
            }
            var textFieldBackgroundColor: UIColor {
                return .brown
            }
            var textFieldBorderColor: UIColor {
                return .yellow
            }
            
            var separatorPrimaryColor: UIColor {
                return .white
            }
            var separatorSecondaryColor: UIColor {
                return .lightGray
            }
            
            
        }
        let adam = WhatsUp(frame: view.bounds)
        view.addSubview(adam)
        let hey = "HEYYEYAAEYAAAEYAEYAA"
        let lyrics = "Twenty-five years and my life is still\nTrying to get up that great big hill of hope\nFor a destination\nI realized quickly when I knew I should\nThat the world was made up of this brotherhood of man\nFor whatever that means\nAnd so I cry sometimes\nWhen I'm lying in bed just to get it all out\nWhat's in my head\nAnd I, I am feeling a little peculiar\nAnd so I wake in the morning\nAnd I step outside\nAnd I take a deep breath and I get real high\nAnd I scream from the top of my lungs\nWhat's going on?\nAnd I say, hey yeah yeah, hey yeah yeah\nI said hey, what's going on?\nAnd I say, hey yeah yeah, hey yeah yeah\nI said hey, what's going on?\nOh, oh oh\nOh, oh oh\nAnd I try, oh my god do I try\nI try all the time, in this institution\nAnd I pray, oh my god do I pray\nI pray…"
        let alert = FAAlertController(title: hey, message: lyrics, preferredStyle: .alert, appearance: .default)
        alert.appearanceDelegate = MastersOfTheAppearanceDelegate()
        let action1 = FAAlertAction(title: hey, style: .default)
        let action2 = FAAlertAction(title: hey, style: .destructive)
        let action3 = FAAlertAction(title: "What's going on?", style: .default)
        let action4 = FAAlertAction(title: hey, style: .default)
        let action5 = FAAlertAction(title: hey, style: .default)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        alert.addAction(action4)
        alert.addAction(action5)
        alert.preferredAction = action3
        alert.completionHandler = {
            for view in self.view.subviews {
                if view == adam {
                    view.removeFromSuperview()
                }
            }
            print("By the power of Grayskull!")
        }
        present(alert, animated: true, completion: nil)
    }
    
}

@IBDesignable
public class Suprise : NSObject {
    
    private struct Cache {
        static var imageOfSuprise: UIImage?
        static var supriseTargets: [AnyObject]?
    }
    
    public dynamic class func drawSuprise() {
        
        //// Text Drawing
        let textPath = UIBezierPath()
        textPath.move(to: CGPoint(x: 14.03, y: 16.84))
        textPath.addLine(to: CGPoint(x: 17.22, y: 16.84))
        textPath.addCurve(to: CGPoint(x: 17.9, y: 15.26), controlPoint1: CGPoint(x: 17.26, y: 16.18), controlPoint2: CGPoint(x: 17.48, y: 15.65))
        textPath.addCurve(to: CGPoint(x: 19.53, y: 14.67), controlPoint1: CGPoint(x: 18.31, y: 14.87), controlPoint2: CGPoint(x: 18.85, y: 14.67))
        textPath.addCurve(to: CGPoint(x: 21.14, y: 15.21), controlPoint1: CGPoint(x: 20.2, y: 14.67), controlPoint2: CGPoint(x: 20.74, y: 14.85))
        textPath.addCurve(to: CGPoint(x: 21.75, y: 16.59), controlPoint1: CGPoint(x: 21.55, y: 15.57), controlPoint2: CGPoint(x: 21.75, y: 16.03))
        textPath.addCurve(to: CGPoint(x: 21.34, y: 17.95), controlPoint1: CGPoint(x: 21.75, y: 17.14), controlPoint2: CGPoint(x: 21.61, y: 17.59))
        textPath.addCurve(to: CGPoint(x: 19.78, y: 19.17), controlPoint1: CGPoint(x: 21.06, y: 18.31), controlPoint2: CGPoint(x: 20.54, y: 18.71))
        textPath.addCurve(to: CGPoint(x: 18.06, y: 20.76), controlPoint1: CGPoint(x: 18.97, y: 19.64), controlPoint2: CGPoint(x: 18.4, y: 20.18))
        textPath.addCurve(to: CGPoint(x: 17.67, y: 23.02), controlPoint1: CGPoint(x: 17.72, y: 21.35), controlPoint2: CGPoint(x: 17.6, y: 22.1))
        textPath.addLine(to: CGPoint(x: 17.69, y: 23.69))
        textPath.addLine(to: CGPoint(x: 20.8, y: 23.69))
        textPath.addLine(to: CGPoint(x: 20.8, y: 23.07))
        textPath.addCurve(to: CGPoint(x: 21.21, y: 21.67), controlPoint1: CGPoint(x: 20.8, y: 22.5), controlPoint2: CGPoint(x: 20.94, y: 22.03))
        textPath.addCurve(to: CGPoint(x: 22.79, y: 20.45), controlPoint1: CGPoint(x: 21.49, y: 21.31), controlPoint2: CGPoint(x: 22.01, y: 20.9))
        textPath.addCurve(to: CGPoint(x: 24.67, y: 18.76), controlPoint1: CGPoint(x: 23.62, y: 19.96), controlPoint2: CGPoint(x: 24.25, y: 19.4))
        textPath.addCurve(to: CGPoint(x: 25.3, y: 16.48), controlPoint1: CGPoint(x: 25.09, y: 18.13), controlPoint2: CGPoint(x: 25.3, y: 17.37))
        textPath.addCurve(to: CGPoint(x: 23.77, y: 13.2), controlPoint1: CGPoint(x: 25.3, y: 15.14), controlPoint2: CGPoint(x: 24.79, y: 14.05))
        textPath.addCurve(to: CGPoint(x: 19.74, y: 11.94), controlPoint1: CGPoint(x: 22.75, y: 12.36), controlPoint2: CGPoint(x: 21.41, y: 11.94))
        textPath.addCurve(to: CGPoint(x: 15.56, y: 13.31), controlPoint1: CGPoint(x: 17.94, y: 11.94), controlPoint2: CGPoint(x: 16.55, y: 12.39))
        textPath.addCurve(to: CGPoint(x: 14.03, y: 16.84), controlPoint1: CGPoint(x: 14.57, y: 14.22), controlPoint2: CGPoint(x: 14.06, y: 15.4))
        textPath.close()
        textPath.move(to: CGPoint(x: 19.29, y: 29.29))
        textPath.addCurve(to: CGPoint(x: 20.66, y: 28.76), controlPoint1: CGPoint(x: 19.83, y: 29.29), controlPoint2: CGPoint(x: 20.29, y: 29.12))
        textPath.addCurve(to: CGPoint(x: 21.21, y: 27.45), controlPoint1: CGPoint(x: 21.03, y: 28.4), controlPoint2: CGPoint(x: 21.21, y: 27.97))
        textPath.addCurve(to: CGPoint(x: 20.66, y: 26.15), controlPoint1: CGPoint(x: 21.21, y: 26.94), controlPoint2: CGPoint(x: 21.03, y: 26.5))
        textPath.addCurve(to: CGPoint(x: 19.29, y: 25.61), controlPoint1: CGPoint(x: 20.29, y: 25.79), controlPoint2: CGPoint(x: 19.83, y: 25.61))
        textPath.addCurve(to: CGPoint(x: 17.94, y: 26.15), controlPoint1: CGPoint(x: 18.76, y: 25.61), controlPoint2: CGPoint(x: 18.31, y: 25.79))
        textPath.addCurve(to: CGPoint(x: 17.38, y: 27.45), controlPoint1: CGPoint(x: 17.57, y: 26.5), controlPoint2: CGPoint(x: 17.38, y: 26.94))
        textPath.addCurve(to: CGPoint(x: 17.94, y: 28.76), controlPoint1: CGPoint(x: 17.38, y: 27.97), controlPoint2: CGPoint(x: 17.57, y: 28.4))
        textPath.addCurve(to: CGPoint(x: 19.29, y: 29.29), controlPoint1: CGPoint(x: 18.31, y: 29.12), controlPoint2: CGPoint(x: 18.76, y: 29.29))
        textPath.close()
        UIColor.black.setFill()
        textPath.fill()
    }
    
    public dynamic class var imageOfSuprise: UIImage {
        if Cache.imageOfSuprise != nil {
            return Cache.imageOfSuprise!
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 40, height: 40), false, 0)
        Suprise.drawSuprise()
        
        Cache.imageOfSuprise = UIGraphicsGetImageFromCurrentImageContext()!.withRenderingMode(.alwaysTemplate)
        UIGraphicsEndImageContext()
        
        return Cache.imageOfSuprise!
    }
    
    @IBOutlet dynamic var supriseTargets: [AnyObject]! {
        get { return Cache.supriseTargets }
        set {
            Cache.supriseTargets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: Suprise.imageOfSuprise)
            }
        }
    }
    
}

