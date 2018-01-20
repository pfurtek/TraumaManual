//
//  TraumaViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/17/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit
import PagingMenuController

class TraumaViewController: UIViewController {
    var trauma: Trauma!
    var pagingMenuController: PagingMenuController!
    
    var bookmarkItem: UIBarButtonItem!
    
    var numberedTitle: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupPagingMenu()
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        
        if TraumaModel.shared.isBookmark(title: self.numberedTitle) {
            self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark_filled"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
        } else {
            self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
        }
        self.navigationItem.rightBarButtonItem = self.bookmarkItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        TraumaModel.shared.addRecentlyViewed(title: self.numberedTitle, object: trauma)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupPagingMenu() {
        let options = TraumaPagingMenuOptions(with: trauma)
        self.pagingMenuController = PagingMenuController(options: options)
        
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        
        pagingMenuController.view.frame = view.bounds        
        pagingMenuController.didMove(toParentViewController: self)
        
        pagingMenuController.menuView?.addBorder(edges: .bottom, color: .lightGray, thickness: 0.5)
    }
    
    @objc func bookmarkAction(_: Any) {
        if let title = self.numberedTitle {
            if TraumaModel.shared.isBookmark(title: title) {
                TraumaModel.shared.removeBookmark(title: title)
                self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            } else {
                TraumaModel.shared.addBookmark(title: title, object: self.trauma)
                self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark_filled"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            }
            self.navigationItem.rightBarButtonItem = self.bookmarkItem
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TraumaViewController {
    struct TraumaPagingMenuOptions: PagingMenuControllerCustomizable {
        let trauma1: Trauma1ViewController
        let trauma2: Trauma2ViewController
        let trauma3: Trauma3ViewController
        let traumaR: TraumaResponseViewController
        
        init(with trauma: Trauma) {
            trauma1 = Trauma1ViewController()
            trauma1.title = "Trauma 1"
            trauma1.mdText = trauma.trauma1Text
            trauma2 = Trauma2ViewController()
            trauma2.title = "Trauma 2"
            trauma2.mdText = trauma.trauma2Text
            trauma3 = Trauma3ViewController()
            trauma3.title = "Trauma 3"
            trauma3.mdText = trauma.trauma3Text
            traumaR = TraumaResponseViewController()
            traumaR.title = "Trauma Response"
            traumaR.mdText = trauma.traumaRText
        }
        
        var componentType: ComponentType {
            return .all(menuOptions: MenuOptions(), pagingControllers: [trauma1, trauma2, trauma3, traumaR])
        }
        
        var lazyLoadingPage: LazyLoadingPage {
            return .all
        }
        
        var isScrollEnabled: Bool {
            return true
        }
        
        struct MenuOptions: MenuViewCustomizable {
            var displayMode: MenuDisplayMode {
                return .standard(widthMode: .flexible, centerItem: false, scrollingMode: .scrollEnabled)
            }
            var focusMode: MenuFocusMode {
                return .underline(height: 2, color: UIColor.lightGray, horizontalPadding: 0, verticalPadding: 0)
            }
            var height: CGFloat {
                return 45
            }
            var backgroundColor: UIColor {
                return .white
            }
            var selectedBackgroundColor: UIColor {
                return .white
            }
            var itemsOptions: [MenuItemViewCustomizable] {
                return [MenuItemTrauma1(), MenuItemTrauma2(), MenuItemTrauma3(), MenuItemTraumaR()]
            }
        }
        
        struct MenuItemTrauma1: MenuItemViewCustomizable {
            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: "Trauma 1")
                return .text(title: title)
            }
        }
        struct MenuItemTrauma2: MenuItemViewCustomizable {
            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: "Trauma 2")
                return .text(title: title)
            }
        }
        struct MenuItemTrauma3: MenuItemViewCustomizable {
            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: "Trauma 3")
                return .text(title: title)
            }
        }
        struct MenuItemTraumaR: MenuItemViewCustomizable {
            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: "Trauma Response")
                return .text(title: title)
            }
        }
    }
}
