//
//  Constant.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation
import CoreGraphics

struct Constant {
    // MARK: - View Params
    static let cornerRadius = CGFloat(5)
    static let shadowRadius = CGFloat(2)
    static let shadowOffset = CGSize(width: 0, height: 1)
    static let shadowOpacity = Float(0.6)
    
    // MARK: - Account Params
    static let minPasswordLength = 6
    
    // MARK: - String
    static let titleError = "Lỗi"
    static let titleLoginError = "Đăng nhập thất bại"
    static let titleResetPassword = "Đặt lại mật khẩu"
    static let titleResetPasswordError = "Đặt lại mật khẩu thất bại"
    static let titleSignup = "Đăng ký Tài khoản"
    static let titleSignupError = "Đăng ký Tài khoản thất bại"
    static let titleSignoutError = "Đăng xuất thất bại"
    static let titleUserNotification = "Money* Hàng ngày"
    
    static let messageError = "Vui lòng thử lại."
    static let messageErrorEmptyEmail = "Vui lòng không bỏ trống email."
    static let messageErrorEmptyPassword = "Vui lòng không bỏ trống mật khẩu."
    static let messageErrorShortPassword = "Mật khẩu đăng nhập không đủ 6 ký tự."
    static let messageErrorInvalidEmail = "Địa chỉ email không hợp lệ. Vui lòng kiểm tra lại."
    static let messageLoginErrorWrongPassword = "Mật khẩu không đúng. Vui lòng kiểm tra lại."
    static let messageLoginErrorUserNotFound = "Tài khoản không tồn tại. Vui lòng tạo tài khoản."
    static let messageLoginErrorUserDisabled = "Tài khoản đang tạm thời bị khoá. Vui lòng liên hệ với chúng tôi tại tran.duc.tanb@sun-asterisk.com."
    static let messageResetPasswordErrorEmptyField = "Vui lòng không bỏ trống email."
    static let messageResetPasswordErrorInvalidRecipientEmail = "Email không tồn tại hoặc chưa được đăng ký tài khoản. Vui lòng kiểm tra lại."
    static let messageResetPasswordErrorSuccessfulAuth = "Đã gửi yêu cầu đặt lại mật khẩu. Vui lòng kiểm tra email để đặt lại mật khẩu."
    static let messageResetPasswordConfirmation = "Bạn có muốn đặt lại mật khẩu cho tài khoản %@ không?"
    static let messageSignupErrorEmptyConfirmPassword = "Vui lòng không bỏ trống xác nhận mật khẩu."
    static let messageSignupErrorWeakPassword = "Mật khẩu đăng nhập không đủ mạnh. Vui lòng chọn mật khẩu có tính bảo mật cao hơn."
    static let messageSignupErrorPasswordNotMatch = "Xác nhận mật khẩu không giống với mật khẩu."
    static let messageSignupErrorEmailAlreadyInUse = "Tài khoản đã tồn tại. Vui lòng tạo một tài khoản khác."
    static let messageSignupSuccessful = "Đăng ký thành công! Bạn có thể dùng email %@ để đăng nhập."
    static let bodyUserNotification = "Hãy cập nhật thu - chi trong ngày hôm nay của bạn để quản lý tài chính tốt hơn."
    
    static let buttonDeny = "Không"
    static let buttonAllow = "Đồng ý"
    static let buttonOK = "OK"
}
