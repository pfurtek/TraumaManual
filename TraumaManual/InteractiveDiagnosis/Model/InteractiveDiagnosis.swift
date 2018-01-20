//
//  InteractiveDiagnosis.swift
//  TraumaManual
//
//  Created by Pawel Furtek on 1/19/18.
//  Copyright © 2018 Pawel Furtek. All rights reserved.
//

import Foundation

let tegInteractiveDiagnosis = {(epl: Double?, lv30: Double?, ci: Double?, r: Double?, ma: Double?, angle: Double?) -> (success: Bool, name: String) in
    var firstStep = false
    var firstStepCount = 0
    if let EPL = epl {
        firstStepCount += 1
        if EPL > 15 {
            firstStep = true
        }
    }
    if let LV30 = lv30 {
        firstStepCount += 1
        if LV30 > 7.5 {
            firstStep = true
        }
    }
    if firstStep {
        // yes
        if let CI = ci {
            if CI >= 3 {
                return (true, "Secondary Fibrinolysis")
            } else if CI <= 1 {
                return (true, "Primary Fibrinolysis")
            } else {
                return (false, "No Diagnosis Available")
            }
        } else {return (false, "Enter More Values")}
    } else if firstStepCount == 2 {
        // no
        if let CI = ci {
            if CI >= 3 {
                // yes
                if let R = r {
                    if R <= 4 {
                        // yes
                        if let MA = ma {
                            if MA > 72 {
                                // yes
                                return (true, "Platelet & Enzymatic Hypercoagulability")
                            } else {
                                // no
                                return (true, "Enzymatic Hypercoagulability")
                            }
                        } else {return (false, "Enter More Values")}
                    } else {
                        // no
                        return (true, "Platelet Hypercoagulability")
                    }
                } else {return (false, "Enter More Values")}
            } else {
                // no
                if let R = r {
                    if R > 10 {
                        // yes
                        return (true, "Low Clotting Factor Function")
                    } else {
                        // no
                        if let MA = ma {
                            if MA < 54 {
                                // yes
                                return (true, "Low Platelet Function")
                            } else {
                                // no
                                if let ANGLE = angle {
                                    if ANGLE < 47 {
                                        // yes
                                        return (true, "Low Fibrinogen Level")
                                    } else {
                                        // no
                                        return (true, "Normal")
                                    }
                                } else {return (false, "Enter More Values")}
                            }
                        } else {return (false, "Enter More Values")}
                    }
                } else {return (false, "Enter More Values")}
            }
        } else {return (false, "Enter More Values")}
    } else if firstStepCount == 1 {
        return (false, "Enter More Values")
    } else {
        return (false, "Enter Patient Values")
    }
}

class InteractiveDiagnosis {
    func checkDiagnosis(epl: Double?, lv30: Double?, ci: Double?, r: Double?, ma: Double?, angle: Double?) -> (success: Bool, name: String) {
        return tegInteractiveDiagnosis(epl, lv30, ci, r, ma, angle)
    }
}
