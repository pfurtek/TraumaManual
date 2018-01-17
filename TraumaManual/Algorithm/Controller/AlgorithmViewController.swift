//
//  AlgorithmViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 12/26/17.
//  Copyright © 2017 Pawel Furtek. All rights reserved.
//

import UIKit
import PagingMenuController

class AlgorithmViewController: UIViewController {
    var algorithm: Algorithm!
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
            self.bookmarkItem = UIBarButtonItem(title: "BM", style: .plain, target: self, action: #selector(bookmarkAction(_:)))
        } else {
            self.bookmarkItem = UIBarButtonItem(title: "bm", style: .plain, target: self, action: #selector(bookmarkAction(_:)))
        }
        self.navigationItem.rightBarButtonItem = self.bookmarkItem
    }
    
    func setupPagingMenu() {
        let options = AlgorithmPagingMenuOptions(with: algorithm)
        self.pagingMenuController = PagingMenuController(options: options)
        
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        
        pagingMenuController.view.frame = view.frame
        //Nav bar
        pagingMenuController.view.frame.origin.y += self.navigationController?.navigationBar.bounds.height ?? 0
        pagingMenuController.view.frame.size.height -= self.navigationController?.navigationBar.bounds.height ?? 0
        //Tab bar
        pagingMenuController.view.frame.size.height -= self.tabBarController?.tabBar.bounds.height ?? 0
        //Status bar
        pagingMenuController.view.frame.origin.y += self.prefersStatusBarHidden ? 0 : 20
        pagingMenuController.view.frame.size.height -= self.prefersStatusBarHidden ? 0 : 20
        
        pagingMenuController.didMove(toParentViewController: self)
        
        pagingMenuController.menuView?.addBorder(edges: .bottom, color: .lightGray, thickness: 0.5)
    }
    
    @objc func bookmarkAction(_: Any) {
        if let title = self.numberedTitle {
            if TraumaModel.shared.isBookmark(title: title) {
                TraumaModel.shared.removeBookmark(title: title)
                self.bookmarkItem = UIBarButtonItem(title: "bm", style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            } else {
                TraumaModel.shared.addBookmark(title: title, object: self.algorithm)
                self.bookmarkItem = UIBarButtonItem(title: "BM", style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            }
            self.navigationItem.rightBarButtonItem = self.bookmarkItem
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension AlgorithmViewController {
    struct AlgorithmPagingMenuOptions: PagingMenuControllerCustomizable {
        let questionnaire: AlgorithmQuestionnaireViewController
        let overview: AlgorithmOverviewViewController
        
        init(with algorithm: Algorithm) {
            questionnaire = AlgorithmQuestionnaireViewController(nibName: "AlgorithmQuestionnaireViewController", bundle: Bundle.main)
            questionnaire.title = "Questionnaire"
            questionnaire.algorithm = algorithm
            overview = AlgorithmOverviewViewController(nibName: "AlgorithmOverviewViewController", bundle: Bundle.main)
            overview.title = "Overview"
            overview.imageName = algorithm.overview
        }
        
        var componentType: ComponentType {
            return .all(menuOptions: MenuOptions(), pagingControllers: [questionnaire, overview])
        }
        
        var lazyLoadingPage: LazyLoadingPage {
            return .all
        }
        
        var isScrollEnabled: Bool {
            return true
        }
        
        struct MenuOptions: MenuViewCustomizable {
            var displayMode: MenuDisplayMode {
                return .segmentedControl
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
                return [MenuItemQuestionnaire(), MenuItemOverview()]
            }
        }
        
        struct MenuItemQuestionnaire: MenuItemViewCustomizable {
            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: "Questionnaire")
                return .text(title: title)
            }
        }
        struct MenuItemOverview: MenuItemViewCustomizable {
            var displayMode: MenuItemDisplayMode {
                let title = MenuItemText(text: "Overview")
                return .text(title: title)
            }
        }
    }
}
