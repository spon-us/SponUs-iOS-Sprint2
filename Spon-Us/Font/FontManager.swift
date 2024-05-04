//
//  FontManager.swift
//  Spon-Us
//
//  Created by 박현수 on 5/4/24.
//

import SwiftUI

extension Text {
    func korFont(_ font: Font) -> some View {
        self.font(font)
            .kerning(-2.5)
    }
}

extension Font {
    
    //MARK: - KR_Font: Spaing -2.5%
    static let D1KrBd: Font = .custom("SUIT-SemiBold", size: 56)// Leading 72
    static let D1KrMd: Font = .custom("SUIT-Regular", size: 56)// Leading 72
    static let D1KrRr: Font = .custom("SUIT-Light", size: 56)// Leading 72
    static let D2KrBd: Font = .custom("SUIT-SemiBold", size: 48)// Leading 62
    static let D2KrMd: Font = .custom("SUIT-Regular", size: 48)// Leading 62
    static let D2KrRr: Font = .custom("SUIT-Light", size: 48)// Leading 62
    static let D3KrBd: Font = .custom("SUIT-SemiBold", size: 40)// Leading 52
    static let D3KrMd: Font = .custom("SUIT-Regular", size: 40)// Leading 52
    static let D3KrRr: Font = .custom("SUIT-Light", size: 40)// Leading 52
    static let D4KrBd: Font = .custom("SUIT-SemiBold", size: 36)// Leading 44
    static let D4KrMd: Font = .custom("SUIT-Regular", size: 36)// Leading 44
    static let D4KrRr: Font = .custom("SUIT-Light", size: 36)// Leading 44
    static let D5KrBd: Font = .custom("SUIT-SemiBold", size: 32)// Leading 42
    static let D5KrMd: Font = .custom("SUIT-Regular", size: 32)// Leading 42
    static let D5KrRr: Font = .custom("SUIT-Light", size: 32)// Leading 42
    static let D6KrBd: Font = .custom("SUIT-SemiBold", size: 28)// Leading 38
    static let D6KrMd: Font = .custom("SUIT-Regular", size: 28)// Leading 38
    static let D6KrRr: Font = .custom("SUIT-Light", size: 28)// Leading 38
    
    static let H1KrBd: Font = .custom("SUIT-SemiBold", size: 32)// Leading 42
    static let H1KrMd: Font = .custom("SUIT-Regular", size: 32)// Leading 42
    static let H1KrRr: Font = .custom("SUIT-Light", size: 32)// Leading 42
    static let H2KrBd: Font = .custom("SUIT-SemiBold", size: 28)// Leading 38
    static let H2KrMd: Font = .custom("SUIT-Regular", size: 28)// Leading 38
    static let H2KrRr: Font = .custom("SUIT-Light", size: 28)// Leading 38
    static let H3KrBd: Font = .custom("SUIT-SemiBold", size: 24)// Leading 34
    static let H3KrMd: Font = .custom("SUIT-Regular", size: 24)// Leading 34
    static let H3KrRr: Font = .custom("SUIT-Light", size: 24)// Leading 34
    static let H4KrBd: Font = .custom("SUIT-SemiBold", size: 20)// Leading 28
    static let H4KrMd: Font = .custom("SUIT-Regular", size: 20)// Leading 28
    static let H4KrRr: Font = .custom("SUIT-Light", size: 20)// Leading 28
    static let H5KrBd: Font = .custom("SUIT-SemiBold", size: 18)// Leading 26
    static let H5KrMd: Font = .custom("SUIT-Regular", size: 18)// Leading 26
    static let H5KrRr: Font = .custom("SUIT-Light", size: 18)// Leading 26
    
    static let T1KrBd: Font = .custom("SUIT-SemiBold", size: 24)// Leading 34
    static let T1KrMd: Font = .custom("SUIT-Regular", size: 24)
    static let T1KrRr: Font = .custom("SUIT-Light", size: 24)
    static let T2KrBd: Font = .custom("SUIT-SemiBold", size: 20)// Leading 28
    static let T2KrMd: Font = .custom("SUIT-Regular", size: 20)
    static let T2KrRr: Font = .custom("SUIT-Light", size: 20)
    static let T3KrBd: Font = .custom("SUIT-SemiBold", size: 18)// Leading 26
    static let T3KrMd: Font = .custom("SUIT-Regular", size: 18)
    static let T3KrRr: Font = .custom("SUIT-Light", size: 18)
    static let T4KrBd: Font = .custom("SUIT-SemiBold", size: 16)// Leading 24
    static let T4KrMd: Font = .custom("SUIT-Regular", size: 16)
    static let T4KrRr: Font = .custom("SUIT-Light", size: 16)
    
    static let B1KrBd: Font = .custom("SUIT-SemiBold", size: 15)// Leading 22
    static let B1KrMd: Font = .custom("SUIT-Regular", size: 15)
    static let B1KrRr: Font = .custom("SUIT-Light", size: 15)
    static let B2KrBd: Font = .custom("SUIT-SemiBold", size: 14)// Leading 20
    static let B2KrMd: Font = .custom("SUIT-Regular", size: 14)
    static let B2KrRr: Font = .custom("SUIT-Light", size: 14)
    static let B3KrBd: Font = .custom("SUIT-SemiBold", size: 13)// Leading 18
    static let B3KrMd: Font = .custom("SUIT-Regular", size: 13)
    static let B3KrRr: Font = .custom("SUIT-Light", size: 13)
    static let B4KrBd: Font = .custom("SUIT-SemiBold", size: 12)// Leading 18
    static let B4KrMd: Font = .custom("SUIT-Regular", size: 12)
    static let B4KrRr: Font = .custom("SUIT-Light", size: 12)
    
    static let C1KrBd: Font = .custom("SUIT-SemiBold", size: 13)// Leading 18
    static let C1KrMd: Font = .custom("SUIT-Regular", size: 13)
    static let C1KrRr: Font = .custom("SUIT-Light", size: 13)
    static let C2KrBd: Font = .custom("SUIT-SemiBold", size: 12)// Leading 18
    static let C2KrMd: Font = .custom("SUIT-Regular", size: 12)
    static let C2KrRr: Font = .custom("SUIT-Light", size: 12)
    static let C3KrBd: Font = .custom("SUIT-SemiBold", size: 11)// Leading 16
    static let C3KrMd: Font = .custom("SUIT-Regular", size: 11)
    static let C3KrRr: Font = .custom("SUIT-Light", size: 11)
    static let C4KrBd: Font = .custom("SUIT-SemiBold", size: 10)// Leading 16
    static let C4KrMd: Font = .custom("SUIT-Regular", size: 10)
    static let C4KrRr: Font = .custom("SUIT-Light", size: 10)
    
    static let But1KrBd: Font = .custom("SUIT-SemiBold", size: 16)// Leading 24
    static let But1KrMd: Font = .custom("SUIT-Regular", size: 16)
    static let But1KrRr: Font = .custom("SUIT-Light", size: 16)
    static let But2KrBd: Font = .custom("SUIT-SemiBold", size: 14)// Leading 20
    static let But2KrMd: Font = .custom("SUIT-Regular", size: 14)
    static let But2KrRr: Font = .custom("SUIT-Light", size: 14)
    static let But3KrBd: Font = .custom("SUIT-SemiBold", size: 13)// Leading 18
    static let But3KrMd: Font = .custom("SUIT-Regular", size: 13)
    static let But3KrRr: Font = .custom("SUIT-Light", size: 13)
    static let But4KrBd: Font = .custom("SUIT-SemiBold", size: 12)// Leading 18
    static let But4KrMd: Font = .custom("SUIT-Regular", size: 12)
    static let But4KrRr: Font = .custom("SUIT-Light", size: 12)
    
    //MARK: - EN_Font: Spaing 0%
    static let D1EnBd: Font = .custom("SUIT-SemiBold", size: 56)// Leading 72
    static let D1EnMd: Font = .custom("SUIT-Regular", size: 56)// Leading 72
    static let D1EnRr: Font = .custom("SUIT-Light", size: 56)// Leading 72
    static let D2EnBd: Font = .custom("SUIT-SemiBold", size: 48)// Leading 62
    static let D2EnMd: Font = .custom("SUIT-Regular", size: 48)// Leading 62
    static let D2EnRr: Font = .custom("SUIT-Light", size: 48)// Leading 62
    static let D3EnBd: Font = .custom("SUIT-SemiBold", size: 40)// Leading 52
    static let D3EnMd: Font = .custom("SUIT-Regular", size: 40)// Leading 52
    static let D3EnRr: Font = .custom("SUIT-Light", size: 40)// Leading 52
    static let D4EnBd: Font = .custom("SUIT-SemiBold", size: 36)// Leading 44
    static let D4EnMd: Font = .custom("SUIT-Regular", size: 36)// Leading 44
    static let D4EnRr: Font = .custom("SUIT-Light", size: 36)// Leading 44
    static let D5EnBd: Font = .custom("SUIT-SemiBold", size: 32)// Leading 42
    static let D5EnMd: Font = .custom("SUIT-Regular", size: 32)// Leading 42
    static let D5EnRr: Font = .custom("SUIT-Light", size: 32)// Leading 42
    static let D6EnBd: Font = .custom("SUIT-SemiBold", size: 28)// Leading 38
    static let D6EnMd: Font = .custom("SUIT-Regular", size: 28)// Leading 38
    static let D6EnRr: Font = .custom("SUIT-Light", size: 28)// Leading 38
    
    static let H1EnBd: Font = .custom("SUIT-SemiBold", size: 32)// Leading 42
    static let H1EnMd: Font = .custom("SUIT-Regular", size: 32)// Leading 42
    static let H1EnRr: Font = .custom("SUIT-Light", size: 32)// Leading 42
    static let H2EnBd: Font = .custom("SUIT-SemiBold", size: 28)// Leading 38
    static let H2EnMd: Font = .custom("SUIT-Regular", size: 28)// Leading 38
    static let H2EnRr: Font = .custom("SUIT-Light", size: 28)// Leading 38
    static let H3EnBd: Font = .custom("SUIT-SemiBold", size: 24)// Leading 34
    static let H3EnMd: Font = .custom("SUIT-Regular", size: 24)// Leading 34
    static let H3EnRr: Font = .custom("SUIT-Light", size: 24)// Leading 34
    static let H4EnBd: Font = .custom("SUIT-SemiBold", size: 20)// Leading 28
    static let H4EnMd: Font = .custom("SUIT-Regular", size: 20)// Leading 28
    static let H4EnRr: Font = .custom("SUIT-Light", size: 20)// Leading 28
    static let H5EnBd: Font = .custom("SUIT-SemiBold", size: 18)// Leading 26
    static let H5EnMd: Font = .custom("SUIT-Regular", size: 18)// Leading 26
    static let H5EnRr: Font = .custom("SUIT-Light", size: 18)// Leading 26
    
    static let T1EnBd: Font = .custom("SUIT-SemiBold", size: 24)// Leading 34
    static let T1EnMd: Font = .custom("SUIT-Regular", size: 24)
    static let T1EnRr: Font = .custom("SUIT-Light", size: 24)
    static let T2EnBd: Font = .custom("SUIT-SemiBold", size: 20)// Leading 28
    static let T2EnMd: Font = .custom("SUIT-Regular", size: 20)
    static let T2EnRr: Font = .custom("SUIT-Light", size: 20)
    static let T3EnBd: Font = .custom("SUIT-SemiBold", size: 18)// Leading 26
    static let T3EnMd: Font = .custom("SUIT-Regular", size: 18)
    static let T3EnRr: Font = .custom("SUIT-Light", size: 18)
    static let T4EnBd: Font = .custom("SUIT-SemiBold", size: 16)// Leading 24
    static let T4EnMd: Font = .custom("SUIT-Regular", size: 16)
    static let T4EnRr: Font = .custom("SUIT-Light", size: 16)
    
    static let B1EnBd: Font = .custom("SUIT-SemiBold", size: 15)// Leading 22
    static let B1EnMd: Font = .custom("SUIT-Regular", size: 15)
    static let B1EnRr: Font = .custom("SUIT-Light", size: 15)
    static let B2EnBd: Font = .custom("SUIT-SemiBold", size: 14)// Leading 20
    static let B2EnMd: Font = .custom("SUIT-Regular", size: 14)
    static let B2EnRr: Font = .custom("SUIT-Light", size: 14)
    static let B3EnBd: Font = .custom("SUIT-SemiBold", size: 13)// Leading 18
    static let B3EnMd: Font = .custom("SUIT-Regular", size: 13)
    static let B3EnRr: Font = .custom("SUIT-Light", size: 13)
    static let B4EnBd: Font = .custom("SUIT-SemiBold", size: 12)// Leading 18
    static let B4EnMd: Font = .custom("SUIT-Regular", size: 12)
    static let B4EnRr: Font = .custom("SUIT-Light", size: 12)
    
    static let C1EnBd: Font = .custom("SUIT-SemiBold", size: 13)// Leading 18
    static let C1EnMd: Font = .custom("SUIT-Regular", size: 13)
    static let C1EnRr: Font = .custom("SUIT-Light", size: 13)
    static let C2EnBd: Font = .custom("SUIT-SemiBold", size: 12)// Leading 18
    static let C2EnMd: Font = .custom("SUIT-Regular", size: 12)
    static let C2EnRr: Font = .custom("SUIT-Light", size: 12)
    static let C3EnBd: Font = .custom("SUIT-SemiBold", size: 11)// Leading 16
    static let C3EnMd: Font = .custom("SUIT-Regular", size: 11)
    static let C3EnRr: Font = .custom("SUIT-Light", size: 11)
    static let C4EnBd: Font = .custom("SUIT-SemiBold", size: 10)// Leading 16
    static let C4EnMd: Font = .custom("SUIT-Regular", size: 10)
    static let C4EnRr: Font = .custom("SUIT-Light", size: 10)
    
    static let But1EnBd: Font = .custom("SUIT-SemiBold", size: 16)// Leading 24
    static let But1EnMd: Font = .custom("SUIT-Regular", size: 16)
    static let But1EnRr: Font = .custom("SUIT-Light", size: 16)
    static let But2EnBd: Font = .custom("SUIT-SemiBold", size: 14)// Leading 20
    static let But2EnMd: Font = .custom("SUIT-Regular", size: 14)
    static let But2EnRr: Font = .custom("SUIT-Light", size: 14)
    static let But3EnBd: Font = .custom("SUIT-SemiBold", size: 13)// Leading 18
    static let But3EnMd: Font = .custom("SUIT-Regular", size: 13)
    static let But3EnRr: Font = .custom("SUIT-Light", size: 13)
    static let But4EnBd: Font = .custom("SUIT-SemiBold", size: 12)// Leading 18
    static let But4EnMd: Font = .custom("SUIT-Regular", size: 12)
    static let But4EnRr: Font = .custom("SUIT-Light", size: 12)
}
