//
//  ViewController.swift
//  SWIFT_EX
//
//  Created by libo on 2016/12/15.
//  Copyright © 2016年 libo. All rights reserved.
//

import UIKit

//tag的积累值
let kTagPlus: Int = 100

//TabBar的高度
let kTabBarH: CGFloat = 49

class MainViewController: UITabBarController, UINavigationControllerDelegate {
    
    // MARK:- 普通属性
    
    //背景图片
    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: kScreenH - kTabBarH, width: kScreenW, height: kTabBarH)
        imageView.image = UIImage(named: "tabbar_bg")
        imageView.isUserInteractionEnabled = true
        return imageView
    }();
    
    //按钮正常状态下的图片数组
    lazy var normalImageArray: [UIImage] = {
        var tempArray = [UIImage]()
        tempArray.append(UIImage(named: "tabbar_find_n")!)
        tempArray.append(UIImage(named: "tabbar_sound_n")!)
        tempArray.append(UIImage(named: "tabbar_np_playnon")!)
        tempArray.append(UIImage(named: "tabbar_download_n")!)
        tempArray.append(UIImage(named: "tabbar_me_n")!)
        return tempArray
    }()
    
    //按钮选中状态下的图片数组
    lazy var selectImageArray: [UIImage] = {
      var tempArray = [UIImage]()
        tempArray.append(UIImage(named: "tabbar_find_h")!)
        tempArray.append(UIImage(named: "tabbar_sound_h")!)
        tempArray.append(UIImage(named: "tabbar_np_playnon")!)
        tempArray.append(UIImage(named: "tabbar_download_h")!)
        tempArray.append(UIImage(named: "tabbar_me_h")!)
        return tempArray
    }()
    

    // MARK:- 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCustomTabBar()
        configSubControllers()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


// Mark:- 初始化
extension MainViewController {
    
    //MARK: 自定义tabbar
    func createCustomTabBar() {
        
        //隐藏原有的tabbar
        tabBar.isHidden = true
        
        //添加tabbar的背景图
        view.addSubview(bgImageView)
        
        let width: CGFloat = kScreenW/5.0
        for index in 0..<5 {
            let button = UIButton(type: .custom)
            if index == 2 {
                button.frame = CGRect(x: kScreenW * 0.5 - kTabBarH*0.5 - 5, y: -10, width: kTabBarH + 10, height: kTabBarH + 10)
            } else {
                button.frame = CGRect(x: width * CGFloat(index), y: 0, width: width, height: kTabBarH)
            }
            button.tag = kTagPlus + index
            button.adjustsImageWhenHighlighted = false
            button.setImage(normalImageArray[index], for: .normal)
            button.setImage(selectImageArray[index], for: .selected)
            button.addTarget(self, action: #selector(tabBarItemSelected), for: .touchUpInside)
            bgImageView.addSubview(button)
        }
        
        // 设置中间按钮的阴影
        guard let playBtn = bgImageView.viewWithTag(102) else {
            return
        }
        let imageView = UIImageView(image: UIImage(named: "tabbar_np_shadow"))
        let btnW: CGFloat = playBtn.width + 6
        imageView.frame = CGRect(x: -3, y: -3, width: btnW, height: btnW * 13.0 / 15.0)
        playBtn.addSubview(imageView)
        
        //设置默认选中第一个
        tabBarItemSelected(bgImageView.viewWithTag(kTagPlus) as! UIButton)
        
    }
    
    // MARK: 配置视图控制器
    func configSubControllers() {
        tabBar.isHidden = true
        
        var tempArray = [LXFBaseNavigationController]()
        let findVC = navigationControllerWith(LXFFindViewController())
        tempArray.append(findVC)
        
        let subscribeVC = navigationControllerWith(LXFSubScribeViewController())
        tempArray.append(subscribeVC)
        
        let playVC = navigationControllerWith(LXFPlayViewController())
        tempArray.append(playVC)
        
        let downloadVC = navigationControllerWith(LXFDownloadViewController())
        tempArray.append(downloadVC)
        
        let mineVC = navigationControllerWith(LXFMineViewController())
        tempArray.append(mineVC)
        
        viewControllers = tempArray
    }
    
    func navigationControllerWith(_ vc: LXFBaseController) -> LXFBaseNavigationController {
        let navi = LXFBaseNavigationController(rootViewController: vc)
        navi.delegate = self
        return navi
    }
}

// Mark:- 监听事件
extension MainViewController {
    
   @objc func tabBarItemSelected(_ button: UIButton) {
        button.isSelected = true
        button.isUserInteractionEnabled = false
        
        for btn in bgImageView.subviews {
            guard let xBtn = btn as? UIButton else {
                continue
            }
            
            guard xBtn.tag == button.tag else {
                continue
            }
            
            xBtn.isSelected = false
            xBtn.isUserInteractionEnabled = true
            
            // 当前选中按钮的tag
            let btnTag = btn.tag - kTagPlus
            
            if versionTabBarSelectedIndex(index: btnTag) {
                selectedIndex = btnTag
            } else {
                button.isSelected = false
                button.isUserInteractionEnabled = true
            }
        }
    }
    
    func versionTabBarSelectedIndex(index: NSInteger) -> Bool {
        if index == 2 {
            //播放界面
            //TODO: 差播放界面
            let playVC = LXFPlayViewController()
            let navigationVC = LXFBaseNavigationController(rootViewController: playVC)
            present(navigationVC, animated: true, completion: nil)
            return false
        }
        return true
    }
}

// MARK: - NavigationControllerDelegate

extension MainViewController {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.hidesBottomBarWhenPushed {
//            bgImageView.isHidden = true
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        tabBar.isHidden = true
        if !viewController.hidesBottomBarWhenPushed {
//            bgImageView.isHidden = true
        }
    }
}

