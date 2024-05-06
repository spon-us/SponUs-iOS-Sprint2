//
//  ColorManager.swift
//  Spon-Us
//
//  Created by 박현수 on 5/4/24.
//

import SwiftUI

extension Color {
    
    //MARK: - Text
    static let textPrimary: Color = Color(uiColor: UIColor(red: 0.1, green: 0.11, blue: 0.12, alpha: 1))
    static let textSecondary: Color = Color(uiColor: UIColor(red: 0.3, green: 0.32, blue: 0.34, alpha: 1))
    static let textTertiary: Color = Color(uiColor: UIColor(red: 0.43, green: 0.47, blue: 0.51, alpha: 1))
    static let textDisabled: Color = Color(uiColor: UIColor(red: 0.57, green: 0.61, blue: 0.65, alpha: 1))
    static let textBrand: Color = Color(uiColor: UIColor(red: 0, green: 0.42, blue: 1, alpha: 1))
    static let textWhite: Color = Color(uiColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
    
    //MARK: - BackGround
    static let bgWhite: Color = Color(uiColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1))
    static let bgSecondary: Color = Color(uiColor: UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1))
    static let bgTertiary: Color = Color(uiColor: UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1))
    static let bgBrandSecondary: Color = Color(uiColor: UIColor(red: 0.9, green: 0.95, blue: 1, alpha: 1))
    
    //MARK: - Line
    static let line50: Color = Color(uiColor: UIColor(red: 0.97, green: 0.98, blue: 0.98, alpha: 1))
    static let line100: Color = Color(uiColor: UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1))
    static let line200: Color = Color(uiColor: UIColor(red: 0.91, green: 0.92, blue: 0.93, alpha: 1))
    static let line300: Color = Color(uiColor: UIColor(red: 0.84, green: 0.86, blue: 0.87, alpha: 1))
    
    //MARK: - Status
    static let statusRed: Color = Color(uiColor: UIColor(red: 1, green: 0.24, blue: 0, alpha: 1))
    static let statusRedSub: Color = Color(uiColor: UIColor(red: 1, green: 0.94, blue: 0.92, alpha: 1))
    static let statusGreen: Color = Color(uiColor: UIColor(red: 0.25, green: 0.75, blue: 0.39, alpha: 1))
    static let statusGreenSub: Color = Color(uiColor: UIColor(red: 0.93, green: 0.99, blue: 0.96, alpha: 1))
}
