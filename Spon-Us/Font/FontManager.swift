//
//  FontManager.swift
//  Spon-Us
//
//  Created by 박현수 on 5/4/24.
//

import SwiftUI

extension Text {
    func korFont(_ font: Font) -> some View {
        let kerningValue: CGFloat
        
        switch font {
            
        case Font.D1KrBd, Font.D1KrMd, Font.D1KrRr:
            kerningValue = 56 * -0.025
        case Font.D2KrBd, Font.D2KrMd, Font.D2KrRr:
            kerningValue = 48 * -0.025
        case Font.D3KrBd, Font.D3KrMd, Font.D3KrRr:
            kerningValue = 40 * -0.025
        case Font.D4KrBd, Font.D4KrMd, Font.D4KrRr:
            kerningValue = 36 * -0.025
        case Font.D5KrBd, Font.D5KrMd, Font.D5KrRr:
            kerningValue = 32 * -0.025
        case Font.D6KrBd, Font.D6KrMd, Font.D6KrRr:
            kerningValue = 28 * -0.025
            
        case Font.H1KrBd, Font.H1KrMd, Font.H1KrRr:
            kerningValue = 32 * -0.025
        case Font.H2KrBd, Font.H2KrMd, Font.H2KrRr:
            kerningValue = 28 * -0.025
        case Font.H3KrBd, Font.H3KrMd, Font.H3KrRr:
            kerningValue = 24 * -0.025
        case Font.H4KrBd, Font.H4KrMd, Font.H4KrRr:
            kerningValue = 20 * -0.025
        case Font.H5KrBd, Font.H5KrMd, Font.H5KrRr:
            kerningValue = 18 * -0.025
            
        case Font.T1KrBd, Font.T1KrMd, Font.T1KrRr:
            kerningValue = 24 * -0.025
        case Font.T2KrBd, Font.T2KrMd, Font.T2KrRr:
            kerningValue = 20 * -0.025
        case Font.T3KrBd, Font.T3KrMd, Font.T3KrRr:
            kerningValue = 18 * -0.025
        case Font.T4KrBd, Font.T4KrMd, Font.T4KrRr:
            kerningValue = 16 * -0.025
        
        case Font.B1KrBd, Font.B1KrMd, Font.B1KrRr:
            kerningValue = 15 * -0.025
        case Font.B2KrBd, Font.B2KrMd, Font.B2KrRr:
            kerningValue = 14 * -0.025
        case Font.B3KrBd, Font.B3KrMd, Font.B3KrRr:
            kerningValue = 13 * -0.025
        case Font.B4KrBd, Font.B4KrMd, Font.B4KrRr:
            kerningValue = 12 * -0.025
            
        case Font.C1KrBd, Font.C1KrMd, Font.C1KrRr:
            kerningValue = 13 * -0.025
        case Font.C2KrBd, Font.C2KrMd, Font.C2KrRr:
            kerningValue = 12 * -0.025
        case Font.C3KrBd, Font.C3KrMd, Font.C3KrRr:
            kerningValue = 11 * -0.025
        case Font.C4KrBd, Font.C4KrMd, Font.C4KrRr:
            kerningValue = 10 * -0.025
        
        case Font.But1KrBd, Font.But1KrMd, Font.But1KrRr:
            kerningValue = 16 * -0.025
        case Font.But2KrBd, Font.But2KrMd, Font.But2KrRr:
            kerningValue = 14 * -0.025
        case Font.But3KrBd, Font.But3KrMd, Font.But3KrRr:
            kerningValue = 13 * -0.025
        case Font.But4KrBd, Font.But4KrMd, Font.But4KrRr:
            kerningValue = 12 * -0.025
            
        default:
            kerningValue = 0
        }
        
        return self.font(font).kerning(kerningValue)
    }
}

extension Font {
    
    //MARK: - KR_Font: Spaing -2.5%
    static let D1KrBd: Font = .custom("SUIT-Bold", size: 56)// Leading 72
    static let D1KrMd: Font = .custom("SUIT-Medium", size: 56)// Leading 72
    static let D1KrRr: Font = .custom("SUIT-Regular", size: 56)// Leading 72
    static let D2KrBd: Font = .custom("SUIT-Bold", size: 48)// Leading 62
    static let D2KrMd: Font = .custom("SUIT-Medium", size: 48)// Leading 62
    static let D2KrRr: Font = .custom("SUIT-Regular", size: 48)// Leading 62
    static let D3KrBd: Font = .custom("SUIT-Bold", size: 40)// Leading 52
    static let D3KrMd: Font = .custom("SUIT-Medium", size: 40)// Leading 52
    static let D3KrRr: Font = .custom("SUIT-Regular", size: 40)// Leading 52
    static let D4KrBd: Font = .custom("SUIT-Bold", size: 36)// Leading 44
    static let D4KrMd: Font = .custom("SUIT-Medium", size: 36)// Leading 44
    static let D4KrRr: Font = .custom("SUIT-Regular", size: 36)// Leading 44
    static let D5KrBd: Font = .custom("SUIT-Bold", size: 32)// Leading 42
    static let D5KrMd: Font = .custom("SUIT-Medium", size: 32)// Leading 42
    static let D5KrRr: Font = .custom("SUIT-Regular", size: 32)// Leading 42
    static let D6KrBd: Font = .custom("SUIT-Bold", size: 28)// Leading 38
    static let D6KrMd: Font = .custom("SUIT-Medium", size: 28)// Leading 38
    static let D6KrRr: Font = .custom("SUIT-Regular", size: 28)// Leading 38
    
    static let H1KrBd: Font = .custom("SUIT-Bold", size: 32)// Leading 42
    static let H1KrMd: Font = .custom("SUIT-Medium", size: 32)// Leading 42
    static let H1KrRr: Font = .custom("SUIT-Regular", size: 32)// Leading 42
    static let H2KrBd: Font = .custom("SUIT-Bold", size: 28)// Leading 38
    static let H2KrMd: Font = .custom("SUIT-Medium", size: 28)// Leading 38
    static let H2KrRr: Font = .custom("SUIT-Regular", size: 28)// Leading 38
    static let H3KrBd: Font = .custom("SUIT-Bold", size: 24)// Leading 34
    static let H3KrMd: Font = .custom("SUIT-Medium", size: 24)// Leading 34
    static let H3KrRr: Font = .custom("SUIT-Regular", size: 24)// Leading 34
    static let H4KrBd: Font = .custom("SUIT-Bold", size: 20)// Leading 28
    static let H4KrMd: Font = .custom("SUIT-Medium", size: 20)// Leading 28
    static let H4KrRr: Font = .custom("SUIT-Regular", size: 20)// Leading 28
    static let H5KrBd: Font = .custom("SUIT-Bold", size: 18)// Leading 26
    static let H5KrMd: Font = .custom("SUIT-Medium", size: 18)// Leading 26
    static let H5KrRr: Font = .custom("SUIT-Regular", size: 18)// Leading 26
    
    static let T1KrBd: Font = .custom("SUIT-Bold", size: 24)// Leading 34
    static let T1KrMd: Font = .custom("SUIT-Medium", size: 24)
    static let T1KrRr: Font = .custom("SUIT-Regular", size: 24)
    static let T2KrBd: Font = .custom("SUIT-Bold", size: 20)// Leading 28
    static let T2KrMd: Font = .custom("SUIT-Medium", size: 20)
    static let T2KrRr: Font = .custom("SUIT-Regular", size: 20)
    static let T3KrBd: Font = .custom("SUIT-Bold", size: 18)// Leading 26
    static let T3KrMd: Font = .custom("SUIT-Medium", size: 18)
    static let T3KrRr: Font = .custom("SUIT-Regular", size: 18)
    static let T4KrBd: Font = .custom("SUIT-Bold", size: 16)// Leading 24
    static let T4KrMd: Font = .custom("SUIT-Medium", size: 16)
    static let T4KrRr: Font = .custom("SUIT-Regular", size: 16)
    
    static let B1KrBd: Font = .custom("SUIT-Bold", size: 15)// Leading 22
    static let B1KrMd: Font = .custom("SUIT-Medium", size: 15)
    static let B1KrRr: Font = .custom("SUIT-Regular", size: 15)
    static let B2KrBd: Font = .custom("SUIT-Bold", size: 14)// Leading 20
    static let B2KrMd: Font = .custom("SUIT-Medium", size: 14)
    static let B2KrRr: Font = .custom("SUIT-Regular", size: 14)
    static let B3KrBd: Font = .custom("SUIT-Bold", size: 13)// Leading 18
    static let B3KrMd: Font = .custom("SUIT-Medium", size: 13)
    static let B3KrRr: Font = .custom("SUIT-Regular", size: 13)
    static let B4KrBd: Font = .custom("SUIT-Bold", size: 12)// Leading 18
    static let B4KrMd: Font = .custom("SUIT-Medium", size: 12)
    static let B4KrRr: Font = .custom("SUIT-Regular", size: 12)
    
    static let C1KrBd: Font = .custom("SUIT-Bold", size: 13)// Leading 18
    static let C1KrMd: Font = .custom("SUIT-Medium", size: 13)
    static let C1KrRr: Font = .custom("SUIT-Regular", size: 13)
    static let C2KrBd: Font = .custom("SUIT-Bold", size: 12)// Leading 18
    static let C2KrMd: Font = .custom("SUIT-Medium", size: 12)
    static let C2KrRr: Font = .custom("SUIT-Regular", size: 12)
    static let C3KrBd: Font = .custom("SUIT-Bold", size: 11)// Leading 16
    static let C3KrMd: Font = .custom("SUIT-Medium", size: 11)
    static let C3KrRr: Font = .custom("SUIT-Regular", size: 11)
    static let C4KrBd: Font = .custom("SUIT-Bold", size: 10)// Leading 16
    static let C4KrMd: Font = .custom("SUIT-Medium", size: 10)
    static let C4KrRr: Font = .custom("SUIT-Regular", size: 10)
    
    static let But1KrBd: Font = .custom("SUIT-Bold", size: 16)// Leading 24
    static let But1KrMd: Font = .custom("SUIT-Medium", size: 16)
    static let But1KrRr: Font = .custom("SUIT-Regular", size: 16)
    static let But2KrBd: Font = .custom("SUIT-Bold", size: 14)// Leading 20
    static let But2KrMd: Font = .custom("SUIT-Medium", size: 14)
    static let But2KrRr: Font = .custom("SUIT-Regular", size: 14)
    static let But3KrBd: Font = .custom("SUIT-Bold", size: 13)// Leading 18
    static let But3KrMd: Font = .custom("SUIT-Medium", size: 13)
    static let But3KrRr: Font = .custom("SUIT-Regular", size: 13)
    static let But4KrBd: Font = .custom("SUIT-Bold", size: 12)// Leading 18
    static let But4KrMd: Font = .custom("SUIT-Medium", size: 12)
    static let But4KrRr: Font = .custom("SUIT-Regular", size: 12)
    
    //MARK: - EN_Font: Spaing 0%
    static let D1EnBd: Font = .custom("SUIT-Bold", size: 56)// Leading 72
    static let D1EnMd: Font = .custom("SUIT-Medium", size: 56)// Leading 72
    static let D1EnRr: Font = .custom("SUIT-Regular", size: 56)// Leading 72
    static let D2EnBd: Font = .custom("SUIT-Bold", size: 48)// Leading 62
    static let D2EnMd: Font = .custom("SUIT-Medium", size: 48)// Leading 62
    static let D2EnRr: Font = .custom("SUIT-Regular", size: 48)// Leading 62
    static let D3EnBd: Font = .custom("SUIT-Bold", size: 40)// Leading 52
    static let D3EnMd: Font = .custom("SUIT-Medium", size: 40)// Leading 52
    static let D3EnRr: Font = .custom("SUIT-Regular", size: 40)// Leading 52
    static let D4EnBd: Font = .custom("SUIT-Bold", size: 36)// Leading 44
    static let D4EnMd: Font = .custom("SUIT-Medium", size: 36)// Leading 44
    static let D4EnRr: Font = .custom("SUIT-Regular", size: 36)// Leading 44
    static let D5EnBd: Font = .custom("SUIT-Bold", size: 32)// Leading 42
    static let D5EnMd: Font = .custom("SUIT-Medium", size: 32)// Leading 42
    static let D5EnRr: Font = .custom("SUIT-Regular", size: 32)// Leading 42
    static let D6EnBd: Font = .custom("SUIT-Bold", size: 28)// Leading 38
    static let D6EnMd: Font = .custom("SUIT-Medium", size: 28)// Leading 38
    static let D6EnRr: Font = .custom("SUIT-Regular", size: 28)// Leading 38
    
    static let H1EnBd: Font = .custom("SUIT-Bold", size: 32)// Leading 42
    static let H1EnMd: Font = .custom("SUIT-Medium", size: 32)// Leading 42
    static let H1EnRr: Font = .custom("SUIT-Regular", size: 32)// Leading 42
    static let H2EnBd: Font = .custom("SUIT-Bold", size: 28)// Leading 38
    static let H2EnMd: Font = .custom("SUIT-Medium", size: 28)// Leading 38
    static let H2EnRr: Font = .custom("SUIT-Regular", size: 28)// Leading 38
    static let H3EnBd: Font = .custom("SUIT-Bold", size: 24)// Leading 34
    static let H3EnMd: Font = .custom("SUIT-Medium", size: 24)// Leading 34
    static let H3EnRr: Font = .custom("SUIT-Regular", size: 24)// Leading 34
    static let H4EnBd: Font = .custom("SUIT-Bold", size: 20)// Leading 28
    static let H4EnMd: Font = .custom("SUIT-Medium", size: 20)// Leading 28
    static let H4EnRr: Font = .custom("SUIT-Regular", size: 20)// Leading 28
    static let H5EnBd: Font = .custom("SUIT-Bold", size: 18)// Leading 26
    static let H5EnMd: Font = .custom("SUIT-Medium", size: 18)// Leading 26
    static let H5EnRr: Font = .custom("SUIT-Regular", size: 18)// Leading 26
    
    static let T1EnBd: Font = .custom("SUIT-Bold", size: 24)// Leading 34
    static let T1EnMd: Font = .custom("SUIT-Medium", size: 24)
    static let T1EnRr: Font = .custom("SUIT-Regular", size: 24)
    static let T2EnBd: Font = .custom("SUIT-Bold", size: 20)// Leading 28
    static let T2EnMd: Font = .custom("SUIT-Medium", size: 20)
    static let T2EnRr: Font = .custom("SUIT-Regular", size: 20)
    static let T3EnBd: Font = .custom("SUIT-Bold", size: 18)// Leading 26
    static let T3EnMd: Font = .custom("SUIT-Medium", size: 18)
    static let T3EnRr: Font = .custom("SUIT-Regular", size: 18)
    static let T4EnBd: Font = .custom("SUIT-Bold", size: 16)// Leading 24
    static let T4EnMd: Font = .custom("SUIT-Medium", size: 16)
    static let T4EnRr: Font = .custom("SUIT-Regular", size: 16)
    
    static let B1EnBd: Font = .custom("SUIT-Bold", size: 15)// Leading 22
    static let B1EnMd: Font = .custom("SUIT-Medium", size: 15)
    static let B1EnRr: Font = .custom("SUIT-Regular", size: 15)
    static let B2EnBd: Font = .custom("SUIT-Bold", size: 14)// Leading 20
    static let B2EnMd: Font = .custom("SUIT-Medium", size: 14)
    static let B2EnRr: Font = .custom("SUIT-Regular", size: 14)
    static let B3EnBd: Font = .custom("SUIT-Bold", size: 13)// Leading 18
    static let B3EnMd: Font = .custom("SUIT-Medium", size: 13)
    static let B3EnRr: Font = .custom("SUIT-Regular", size: 13)
    static let B4EnBd: Font = .custom("SUIT-Bold", size: 12)// Leading 18
    static let B4EnMd: Font = .custom("SUIT-Medium", size: 12)
    static let B4EnRr: Font = .custom("SUIT-Regular", size: 12)
    
    static let C1EnBd: Font = .custom("SUIT-Bold", size: 13)// Leading 18
    static let C1EnMd: Font = .custom("SUIT-Medium", size: 13)
    static let C1EnRr: Font = .custom("SUIT-Regular", size: 13)
    static let C2EnBd: Font = .custom("SUIT-Bold", size: 12)// Leading 18
    static let C2EnMd: Font = .custom("SUIT-Medium", size: 12)
    static let C2EnRr: Font = .custom("SUIT-Regular", size: 12)
    static let C3EnBd: Font = .custom("SUIT-Bold", size: 11)// Leading 16
    static let C3EnMd: Font = .custom("SUIT-Medium", size: 11)
    static let C3EnRr: Font = .custom("SUIT-Regular", size: 11)
    static let C4EnBd: Font = .custom("SUIT-Bold", size: 10)// Leading 16
    static let C4EnMd: Font = .custom("SUIT-Medium", size: 10)
    static let C4EnRr: Font = .custom("SUIT-Regular", size: 10)
    
    static let But1EnBd: Font = .custom("SUIT-Bold", size: 16)// Leading 24
    static let But1EnMd: Font = .custom("SUIT-Medium", size: 16)
    static let But1EnRr: Font = .custom("SUIT-Regular", size: 16)
    static let But2EnBd: Font = .custom("SUIT-Bold", size: 14)// Leading 20
    static let But2EnMd: Font = .custom("SUIT-Medium", size: 14)
    static let But2EnRr: Font = .custom("SUIT-Regular", size: 14)
    static let But3EnBd: Font = .custom("SUIT-Bold", size: 13)// Leading 18
    static let But3EnMd: Font = .custom("SUIT-Medium", size: 13)
    static let But3EnRr: Font = .custom("SUIT-Regular", size: 13)
    static let But4EnBd: Font = .custom("SUIT-Bold", size: 12)// Leading 18
    static let But4EnMd: Font = .custom("SUIT-Medium", size: 12)
    static let But4EnRr: Font = .custom("SUIT-Regular", size: 12)
}
