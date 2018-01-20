//
//  InteractiveDiagnosisViewController.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/19/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import UIKit
import TextFieldEffects

class InteractiveDiagnosisViewController: UIViewController {
    @IBOutlet weak var diagnosisLabel: UILabel!
    @IBOutlet weak var diagnosisContainer: UIView!
    
    @IBOutlet weak var eplTF: HoshiTextField!
    @IBOutlet weak var lv30TF: HoshiTextField!
    @IBOutlet weak var ciTF: HoshiTextField!
    @IBOutlet weak var rTF: HoshiTextField!
    @IBOutlet weak var maTF: HoshiTextField!
    @IBOutlet weak var angleTF: HoshiTextField!
    
    var interactiveDiagnosis: InteractiveDiagnosis!
    
    var bookmarkItem: UIBarButtonItem!
    
    var numberedTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        eplTF.delegate = self
        lv30TF.delegate = self
        ciTF.delegate = self
        rTF.delegate = self
        maTF.delegate = self
        angleTF.delegate = self
        
        eplTF.keyboardType = .decimalPad
        lv30TF.keyboardType = .decimalPad
        ciTF.keyboardType = .decimalPad
        rTF.keyboardType = .decimalPad
        maTF.keyboardType = .decimalPad
        angleTF.keyboardType = .decimalPad
        
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
        
        TraumaModel.shared.addRecentlyViewed(title: self.numberedTitle, object: interactiveDiagnosis)
        
        eplTF.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func bookmarkAction(_: Any) {
        if let title = self.numberedTitle {
            if TraumaModel.shared.isBookmark(title: title) {
                TraumaModel.shared.removeBookmark(title: title)
                self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            } else {
                TraumaModel.shared.addBookmark(title: title, object: self.interactiveDiagnosis)
                self.bookmarkItem = UIBarButtonItem(image: UIImage(named: "bookmark_filled"), style: .plain, target: self, action: #selector(bookmarkAction(_:)))
            }
            self.navigationItem.rightBarButtonItem = self.bookmarkItem
        }
    }
    
    func gatherNumbers() -> (Double?, Double?, Double?, Double?, Double?, Double?) {
        return (eplTF.text?.doubleValue, lv30TF.text?.doubleValue, ciTF.text?.doubleValue, rTF.text?.doubleValue, maTF.text?.doubleValue, angleTF.text?.doubleValue)
        
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

extension InteractiveDiagnosisViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("did begin editing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("stopped editing")
        let numbers = gatherNumbers()
        let diagnosis = self.interactiveDiagnosis.checkDiagnosis(epl: numbers.0, lv30: numbers.1, ci: numbers.2, r: numbers.3, ma: numbers.4, angle: numbers.5)
        
        diagnosisLabel.text = diagnosis.name
        if diagnosis.success {
            diagnosisContainer.backgroundColor = UIColor(hex: "#007AFF")
        } else {
            diagnosisContainer.backgroundColor = UIColor(hex: "#7D110C")
        }
    }
    
    
}
