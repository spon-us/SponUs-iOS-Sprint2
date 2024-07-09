//
//  TermsOfUseView.swift
//  Spon-Us
//
//  Created by 황인성 on 7/9/24.


import SwiftUI

struct TermsOfUseView: View {
    var body: some View {
        ScrollView {
              VStack(alignment: .leading, spacing: 12) {
                  
                Group {
                  Text("서비스 이용약관 (상품, 서비스 등 이용 일반 회원용)")
                    .font(Font.custom("SUIT", size: 16).weight(.bold))
                    .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                  Text("제1조(목적)")
                    .font(Font.custom("SUIT", size: 16).weight(.bold))
                    .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                  Text("본 약관은 스포너스가 운영하는 모바일 애플리케이션 '스포너스'을 통해 제공되는 전자상거래 서비스와 관련하여 당사자의 권리 의무 및 책임사항을 규정하는 것을 목적으로 합니다.\nPC통신, 무선 등을 이용하는 전자상거래에 대하여도 그 성질에 반하지 않는 한 본 약관을 준용합니다.")
                    .font(Font.custom("SUIT", size: 14).weight(.medium))
                    .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제2조(정의)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("본 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n'회사'라 함은, 스포너스가 재화 또는 용역을 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 상품을 거래할 수 있도록 설정한 가상의 영업장을 운영하는 주체를 말하며, 아울러 '스포너스'을 통해 제공되는 전자상거래 관련 서비스의 의미로도 사용합니다.\n'모바일앱'이라 함은, '회사'가 개발 및 운영을 담당하고, '이용자'의 편의를 위하여 제공하는 모바일 애플리케이션을 말합니다.\n본 조에서 정의되지 않은 본 약관 상의 용어는 일반적인 거래관행에 따라 해석합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제3조(약관 외 준칙)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("본 약관에서 정하지 아니한 사항은 법령 또는 '회사'가 정한 서비스의 개별 약관, 운영정책 및 규칙(이하 '세부지침'이라 합니다)의 규정에 따릅니다. 또한 본 약관과 세부지침이 충돌할 경우에는 세부지침이 우선합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제4조(약관의 명시 및 개정)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'는 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지, 전화번호, 모사전송번호(FAX), 전자우편주소, 사업자등록번호, 통신판매업신고번호 등을 '이용자'가 쉽게 알 수 있도록 '사이트'의 초기 서비스화면에 게시합니다. 다만, 본 약관의 내용은 '이용자'가 연결화면을 통하여 확인할 수 있도록 할 수 있습니다.\n'회사'는 '이용자'가 약관에 동의하기에 앞서 약관에 정해진 내용 중 청약철회, 배송책임, 환불조건 등과 같은 내용을 '이용자'가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 통하여 '이용자'의 확인을 구합니다.\n'회사'는 전자상거래 등에서의 소비자보호에 관한 법률', '약관의 규제에 관한 법률', '전자거래기본법', '정보통신망 이용촉진 등에 관한 법률', '소비자보호법' 등 관계 법령(이하 '관계법령' 이라 합니다)에 위배되지 않는 범위 내에서 본 약관을 개정할 수 있습니다.\n'회사'가 본 약관을 개정하고자 할 경우, 적용일자 및 개정사유를 명시하여 현행약관과 함께 온라인 쇼핑몰의 초기화면에 그 적용일자 7일전부터 적용일자 전날까지 공지합니다. 다만, '이용자'에게 불리한 내용으로 약관을 변경하는 경우 최소 30일 이상 유예기간을 두고 공지합니다.\n'회사'가 본 약관을 개정한 경우, 개정약관은 적용일자 이후 체결되는 계약에만 적용되며 적용일자 이전 체결된 계약은 개정 전 약관이 적용됩니다. 다만, 이미 계약을 체결한 '이용자'가 개정약관의 내용을 적용받고자 하는 뜻을 '회사'에게 전달하고, '회사'가 여기에 동의한 경우 개정약관을 적용합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제5조(서비스의 제공 및 변경)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'가 제공하는 서비스는 연중무휴, 1일 24시간 제공을 원칙으로 합니다. 다만, 시스템의 유지보수를 위한 점검, 통신 장비의 교체 등 특별한 사유가 있는 경우 서비스의 전부 또는 일부에 대하여 일시적으로 제공을 중단할 수 있습니다.\n'회사'는 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우, 전기통신사업법에 의한 기간통신사업자가 전기통신서비스를 중지하는 등 부득이한 사유가 발생한 경우 서비스의 전부 또는 일부를 제한하거나 중지할 수 있습니다.\n'회사'가 서비스를 정지하거나 이용을 제한하는 경우 그 사유 및 기간, 복구 예정 일시 등을 지체 없이 '이용자'에게 알립니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제6조(제공하는 서비스)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'가 제공하는 서비스는 다음과 같습니다.\n전자상거래 플랫폼 개발 및 운영서비스\n상품 정보검색 서비스\n광고 및 프로모션 서비스\n기타 '회사'가 정하는 서비스")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제7조(회원가입)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'가 정한 양식에 따라 '이용자'가 회원정보를 기입한 후 본 약관에 동의한다는 의사표시를 함으로써 회원가입을 신청합니다.\n'회사'는 전항에 따라 회원가입을 신청한 '이용자' 중 다음 각호의 사유가 없는 한 '회원'으로 등록합니다.\n가입신청자가 본 약관에 따라 회원자격을 상실한 적이 있는 경우. 다만, '회사'의 재가입 승낙을 얻은 경우에는 예외로 합니다.\n회원정보에 허위, 기재누락, 오기 등 불완전한 부분이 있는 경우\n기타 회원으로 등록하는 것이 '회사'의 운영에 현저한 지장을 초래하는 것으로 인정되는 경우\n회원가입 시기는 '회사'의 가입승낙 안내가 '회원'에게 도달한 시점으로 합니다.\n'회사'의 서비스를 1년 동안 이용하지 않는 '회원'의 경우 휴면계정으로 전환하고 서비스 이용을 제한할 수 있습니다.\n휴면계정 전환 시 계정 활성을 위해 필요한 아이디(ID), 비밀번호, 이름, 중복가입 방지를 위한 본인 인증값(DI), 휴대전화 번호를 제외한 나머지 정보는 삭제됩니다. 다만, 관계법령에 의해 보존할 필요가 있는 경우 '회사'는 정해진 기간 동안 회원정보를 보관합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제8조(회원탈퇴 및 자격상실 등)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회원'은 '회사'에 언제든지 탈퇴를 요청할 수 있으며, '회사'는 지체없이 회원탈퇴 요청을 처리합니다. 다만 이미 체결된 거래계약을 이행할 필요가 있는 경우에는 본약관이 계속 적용됩니다.\n'쇼핑몰'은 다음 각호의 사유가 발생한 경우 '회사'의 자격을 제한 또는 정지시킬 수 있습니다.\n회원가입 시 허위정보를 기재한 경우\n다른 이용자의 정상적인 이용을 방해하는 경우\n관계법령 또는 본 약관에서 금지하는 행위를 한 경우\n공서양속에 어긋나는 행위를 한 경우\n기타 '회원'으로 등록하는 것이 적절하지 않은 것으로 판단되는 경우\n'회사'의 서비스를 1년 동안 이용하지 않는 '회원'의 경우 휴면계정으로 전환하고 서비스 이용을 제한할 수 있습니다.\n휴면계정 전환 시 계정 활성을 위해 필요한 아이디(ID), 비밀번호, 이름, 중복가입 방지를 위한 본인 인증값(DI), 휴대전화 번호를 제외한 나머지 정보는 삭제됩니다. 다만, 관계법령에 의해 보존할 필요가 있는 경우 '회사'는 정해진 기간 동안 회원정보를 보관합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                }
                  Group {
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제9조(회원에 대한 통지)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'는 '회원' 회원가입 시 기재한 전자우편, 이동전화번호, 주소 등을 이용하여 '회원'에게 통지 할 수 있습니다.\n'회사'가 불특정 다수 '회원'에게 통지하고자 하는 경우 1주일 이상 '사이트'의 게시판에 게시함으로써 개별 통지에 갈음할 수 있습니다. 다만 '회원'이 서비스를 이용함에 있어 중요한 사항에 대하여는 개별 통지합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제10조(회사의 의무)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'는 계속적이고 안정적인 서비스의 제공을 위하여 설비에 장애가 생기거나 설비가 멸실된 때에는 이를 지체없이 수리 또는 복구하며, 다음 각호의 사유 발생 시 부득이한 경우 예고 없이 서비스의 전부 또는 일부의 제공을 일시 중지할 수 있습니다. 이 경우 그 사유 및 중지 기간 등을 지체 없이 '이용자'에게 공지합니다.\n시스템의 긴급점검, 증설, 교체, 시설의 보수 또는 공사를 위해 필요한 경우\n시스템 또는 기타 서비스 설비의 장애, 유무선 Network 장애 등으로 정상적인 서비스 제공이 불가능한 경우\n국가비상사태, 정전, 불가항력적 사유에 의한 경우\n'회사'는 '이용계약'의 체결, 계약사항의 변경 및 해지 등 '이용자'와의 계약관련 절차 및 내용 등에 있어 이용자에게 편의를 제공하도록 노력합니다.\n'회사'는 본 약관의 '상품의 판매가격 및 이용료'. '판매대금의 정산 및 지급' 규정에 따라 '판매회원'에게 대금을 정산할 의무를 부담합니다. 다만 본 약관의 '면책규정'에서 정하는 바와 같이 '판매회원'이 '일반회원'에게 제공한 서비스와 관련된 분쟁에 대하여는 책임을 부담하지 않습니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제11조(이용자의 의무)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'이용자'는 본 약관에 동의하고 사실에 근거하여 회원가입 신청서를 작성해야 합니다. '이용자'가 허위정보 또는 타인의 정보를 도용한 경우 '회사'에 대하여 일체의 권리를 주장할 수 없으며, '회사'는 이로 인하여 발생한 손해에 대하여 책임을 부담하지 않습니다.\n'이용자'는 본 약관에서 규정하는 사항, '회사'가 정한 제반 규정, 기타 '회사'가 공지하는 사항을 준수하여야 합니다. 또한 '이용자'는 '회사'의 업무를 방해하는 행위 및 명예를 훼손하는 행위를 하여서는 안 됩니다.\n'이용자'는 주소, 연락처, 전자우편 주소 등 회원정보가 변경된 경우 즉시 온라인을 통하여 이를 수정해야 합니다. 변경된 정보를 수정하지 않거나 수정이 지연되어 발생하는 책임은 이용자가 부담합니다.\n'이용자'는 자신의 회원ID와 비밀번호를 직접 관리해야 합니다. '이용자'의 관리상의 부주의로 발생한 문제에 대하여는 '회사'가 책임을 부담하지 않습니다.\n'이용자'는 '회사'의 명시적 동의가 없는 한 서비스 이용 권한, 기타 이용 계약상의 지위에 대하여 매도, 증여, 담보제공 등의 처분행위를 할 수 없습니다.\n'판매회원'은 자신이 제공하는 '상품'에 대하여 정확한 정보를 제공하여야 하며, 본 약관 '판매회원의 의무'에 따른 의무를 준수하여야 합니다. 이를 위반하여 발생하는 모든 책임은 '판매회원'이 부담합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제12조(등록된 상품정보의 취소 및 삭제)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'공고 게시자'는 '전용화면'을 통해 상품 정보를 등록해야 합니다. 다만 '회사'는 다음 각호의 사유가 있는 경우 그 등록을 취소하거나 삭제할 수 있습니다.\n상품등록양식에 어긋난 등록, 허위 및 중복 등록, 판매를 가장한 등록\n중요 판매정보에 오기 또는 모순이 있는 등록\n과다한 허위출고 또는 명백한 허위출고의 반복\n'공고 게시자'와 연락이 두절된 경우\n기타 '회사'의 상품관련 서비스 비용이 과다하게 발생하는 경우")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제13조(상품의 등록 및 관리)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'공고 게시자'는 '상품'에 관한 정보를 '전용화면'에서 직접 등록하여야 하며, 그 내용이 사실과 부합하도록 상시 관리하여야 합니다.\n'공고 게시자'는 '상품'의 가치에 영향을 미치는 정보에 대하여 그 진실성을 보장하여야 합니다. 표시된 '상품'의 정보에 허위사실이 있을 경우 그로 인한 모든 책임은 '공고 게시자'가 부담합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제14조(상품의 판매 가격 및 이용료)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'가 부과하는 '서비스 이용료'는 서비스 이용료, 기타 이용료로 구분됩니다. 각 서비스 및 서비스 이용료의 구체적인 내용은 해당 서비스화면에 별도로 게재합니다.\n'회사'는 필요한 경우 서비스이용료를 신설하거나 변경할 수 있으며, 그 내용은 '전용화면'을 통하여 통지합니다.\n일반 회원은 회사의 서비스 이용대가로 수수료, 회원료 등 각 상품의 구매시 또는 별도로 회사가 정한 요율이나 기준에 따라 서비스 이용료를 회사에 지급해야 한다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제15조(판매 부적합 상품)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'는 관계법령 또는 일반 거래관행, 사회통념에 따라 개별적으로 판매부적합 상품 여부를 판단하여 제재할 수 있습니다.\n'공고 게시자'의 고의 또는 과실로 판매부적합 상품이 등록된 경우, '회사'는 즉시 해당 상품의 판매를 중지시키고 이 사실을 '공고 게시자'에게 통보합니다. 만약, '판매회원'의 고의에 의한 등록으로 판단될 경우 '회사'는 '이용계약'을 해지할 수 있습니다.\n'공고 게시자'의 고의 또는 과실로 판매부적합 상품이 판매된 경우, '회사'는 즉시 해당 상품의 판매를 중지하고 즉시 '이용계약'을 해지합니다. 이 때 '회사'는 필요한 경우 관계 기관에 위 사실을 즉시 신고할 수 있습니다.\n판매부적합 상품을 등록한 경우 그 등록에 사용된 이용료 등 제반 비용은 환불되지 않으며, '공고 게시자'은 매매 부적합 물품의 등록 및 판매에 대한 모든 법적인 책임을 부담합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제16조(결제 방법)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'일반회원'이 구매한 '상품'에 대한 대금은 다음 각호의 방법으로 결제할 수 있습니다.\n'회사'가 지급한 결제 가능한 쿠폰에 의한 결제\n카카오페이\n'회사'는 '일반회원'이 결제수단에 대한 정당한 사용권한을 가지고 있는지 여부를 확인할 수 있으며, 이에 대한 확인이 완료될 때까지 거래 진행을 중지하거나, 확인이 불가능한 거래를 취소할 수 있습니다.\n'회사'의 정책 및 결제업체(이동통신사, 카드회사 등) 또는 결제대행업체(PG)의 기준에 따라 '일반회원' 당 월 누적 결제액 및 충전한도정당한 사용권한을 가지고 있는지 여부를 확인할 수 있으며, 이에 대한 확인이 완료될 때까지 거래 진행을 중지하거나, 확인이 불가능한 거래를 취소할 수 있습니다.\n'회사'의 정책 및 결제업체(이동통신사, 카드회사 등) 또는 결제대행업체(PG)의 기준에 따라 '일반회원' 당 월 누적 결제액 및 충전한도가 제한될 수 있습니다.\n대금의 지급 또는 결제를 위하여 입력한 정보에 대한 책임은 '일반회원'이 전적으로 부담합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제17조(청약철회)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'공고 게시자'과 재화 등의 구매에 관한 계약을 체결한 '일반회원'은 본 약관에 따른 수신확인의 통지를 받은 날 부터 7일 이내에 청약을 철회할 수 있습니다.\n전항의 규정에도 불구하고 다음 각 호의 사유에 해당하는 경우, 배송받은 재화의 반품 또는 교환이 제한됩니다.\n'일반회원'에게 책임있는 사유로 상품이 멸실 또는 훼손된 경우(다만, 재화를 확인하기 위하여 포장 등을 훼손한 경우는 예외로 합니다)\n'일반회원'의 사용 또는 소비에 의하여 재화의 가치가 현저히 감소한 경우\n시간의 경과로 재판매가 곤란할 정도로 재화의 가치가 현저히 감소한 경우\n같은 성능을 지닌 재화 등으로 복제가 가능한 경우 그 원본이 되는 재화의 포장을 훼손한 경우\n'일반회원'의 주문에 의하여 개별적으로 생산한 제품으로서 청약철회 및 교환의 제한에 대하여 사전에 고지한 경우\n'공고 게시자' 또는 '회사'가 전 항의 청약철회 제한 사유를 '일반회원'가 알기 쉽게 명시하거나, 시용상품을 제공하는 등의 조치를 취하지 않은 경우 '구매자'의 청약철회가 제한되지 않습니다.\n본조의 규정에도 불구하고, '일반회원'은 상품 등의 내용이 표시, 광고 내용과 다르거나 계약내용과 다르게 이행된 때에는 당해 상품을 공급받은 날로부터 3월 이내, 그 사실을 안날 또는 알 수 있었던 날로부터 30일 이내에 청약철회 등을 할 수 있습니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제18조(저작권의 귀속 및 이용)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'스포너스'이 제공하는 서비스 및 관련된 모든 지식재산권은 '회사'에 귀속됩니다\n'이용자'는 '스포너스'에게 지식재산권이 있는 정보를 사전 승낙없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나, 제3자가 이용하게 하여서는 안됩니다.\n'이용자'가 서비스 내에 게시한 게시물, 이용후기 등 콘텐츠(이하 '콘텐츠')의 저작권은 해당 '콘텐츠'의 저작자에게 귀속됩니다.\n전항의 규정에도 불구하고 '회사'는 서비스의 운영, 전시, 전송, 배포, 홍보 등의 목적으로 별도의 허락 없이 무상으로 저작권법 및 공정한 거래관행에 합치되는 범위 내에서 다음 각호와 같이 '이용자'가 등록한 저작물을 이용할 수 있습니다.\n'회사'가 제공하는 서비스 내에서 '이용자'가 작성한 '콘텐츠'의 복제, 수정, 전시, 전송, 배포 등 저작권을 침해하지 않는 범위 내의 2차적 저작물 또는 편집 저작물 작성을 위한 사용. 다만 '이용자'가 해당 '콘텐츠'의 삭제 또는 사용중지를 요청하는 경우 관련법에 따라 보존해야하는 사항을 제외하고 관련 '콘텐츠'를 모두 삭제 또는 사용중지합니다.\n서비스의 운영, 홍보, 서비스 개선 및 새로운 서비스 개발을 위한 범위내의 사용\n미디어, 통신사 등을 통한 홍보목적으로 '콘텐츠'를 제공, 전시하도록 하는 등의 사용")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                }
                  Group {
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제19조(분쟁의 해결)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("회사'는 '이용자'가 제기하는 불만사항 및 의견을 지체없이 처리하기 위하여 노력합니다. 다만, 신속한 처리가 곤란한 경우 '이용자'에게 그 사유와 처리일정을 즉시 통보합니다.\n'회사'와 '이용자'간 발생한 분쟁에 관한 소송은 민사소송법에 따른 관할법원에 제기하며, 준거법은 대한민국의 법령을 적용합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제20조('회사'의 의무)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'는 관계법령, 본 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 약관이 정하는 바에 따라 지속적 · 안정적으로 재화 및 용역을 제공하는데 최선을 다하여야 합니다.\n'회사'는 '이용자'가 안전하게 인터넷 서비스를 이용할 수 있도록 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.\n'회사'가 상품에 대하여 '표시 · 광고의 공정화에 관한 법률' 제3조 소정의 부당한 표시 · 광고행위를 하여 '이용자'가 손해를 입은 때에는 이를 배상할 책임을 집니다.\n'회사'는 '이용자'의 수신동의 없이 영리목적으로 광고성 전자우편, 휴대전화 메시지, 전화, 우편 등을 발송하지 않습니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제21조(이용자 및 회원의 의무)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'이용자'는 회원가입 신청 시 사실에 근거하여 신청서를 작성해야 합니다. 허위, 또는 타인의 정보를 등록한 경우 '회사'에 대하여 일체의 권리를 주장할 수 없으며, '회사'는 이로 인하여 발생한 손해에 대하여 책임을 부담하지 않습니다.\n'이용자'는 본 약관에서 규정하는 사항과 기타 '회사'가 정한 제반 규정 및 공지사항을 준수하여야 합니다. 또한 '이용자'는 '회사'의 업무를 방해하는 행위 및 '회사'의 명예를 훼손하는 행위를 하여서는 안 됩니다.\n'이용자'는 주소, 연락처, 전자우편 주소 등 회원정보가 변경된 경우 즉시 이를 수정해야 합니다. 변경된 정보를 수정하지 않거나 수정을 게을리하여 발생하는 책임은 '이용자'가 부담합니다.\n'이용자'는 다음의 행위를 하여서는 안됩니다.\n'회사'에 게시된 정보의 변경\n'회사'가 정한 정보 외의 다른 정보의 송신 또는 게시\n'회사' 및 제3자의 저작권 등 지식재산권에 대한 침해\n'회사' 및 제3자의 명예를 훼손하거나 업무를 방해하는 행위\n외설 또는 폭력적인 메시지, 화상, 음성 기타 관계법령 및 공서양속에 반하는 정보를 '회사'의 '사이트'에 공개 또는 게시하는 행위\n'회원'은 부여된 아이디(ID)와 비밀번호를 직접 관리해야 합니다.\n'회원'이 자신의 아이디(ID) 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 '회사'에 통보하고 안내에 따라야 합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제22조(저작권의 귀속 및 이용)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'쇼핑몰'이 제공하는 서비스 및 이와 관련된 모든 지식재산권은 '회사'에 귀속됩니다\n'이용자'는 '쇼핑몰'에게 지식재산권이 있는 정보를 사전 승낙없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나, 제3자가 이용하게 하여서는 안됩니다.\n'이용자'가 서비스 내에 게시한 게시물, 이용후기 등 콘텐츠(이하 '콘텐츠')의 저작권은 해당 '콘텐츠'의 저작자에게 귀속됩니다.\n전항의 규정에도 불구하고 '회사'는 서비스의 운영, 전시, 전송, 배포, 홍보 등의 목적으로 별도의 허락 없이 무상으로 저작권법 및 공정한 거래관행에 합치되는 범위 내에서 다음 각호와 같이 '이용자'가 등록한 저작물을 이용할 수 있습니다.\n'회사'가 제공하는 서비스 내에서 '이용자'가 작성한 '콘텐츠'의 복제, 수정, 전시, 전송, 배포 등 저작권을 침해하지 않는 범위 내의 2차적 저작물 또는 편집 저작물 작성을 위한 사용. 다만 '이용자'가 해당 '콘텐츠'의 삭제 또는 사용중지를 요청하는 경우 관련법에 따라 보존해야하는 사항을 제외하고 관련 '콘텐츠'를 모두 삭제 또는 사용중지합니다.\n서비스의 운영, 홍보, 서비스 개선 및 새로운 서비스 개발을 위한 범위내의 사용\n미디어, 통신사 등을 통한 홍보목적으로 '콘텐츠'를 제공, 전시하도록 하는 등의 사용")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("제23조(분쟁의 해결)")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("'회사'는 '이용자'가 제기하는 불만사항 및 의견을 지체없이 처리하기 위하여 노력합니다. 다만 신속한 처리가 곤란한 경우 '이용자'에게 그 사유와 처리일정을 즉시 통보해 드립니다.\n'회사'와 '이용자'간 전자상거래에 관한 분쟁이 발생한 경우, '이용자'는 한국소비자원, 전자문서 · 전자거래분쟁조정위원회 등 분쟁조정기관에 조정을 신청할 수 있습니다.\n'회사'와 '이용자'간 발생한 분쟁에 관한 소송은 민사소송법에 따른 관할법원에 제기하며, 준거법은 대한민국의 법령을 적용합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                  VStack(alignment: .leading, spacing: 12) {
                    Text("부칙")
                      .font(Font.custom("SUIT", size: 16).weight(.bold))
                      
                      .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                    Text("제1조(시행일)\n본 약관은 2024.01.23부터 적용합니다.")
                      .font(Font.custom("SUIT", size: 14).weight(.medium))
                      
                      .foregroundColor(Color(red: 0.44, green: 0.45, blue: 0.47))
                  }
                }
              }
              .padding(.horizontal, 20)
        }
    }
}

#Preview {
    TermsOfUseView()
}
