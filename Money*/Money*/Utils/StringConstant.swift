//
//  StringConstant.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation

struct StringConstant {
    static let titleError = "Lỗi"
    static let titleLoginError = "Đăng nhập thất bại"
    static let titleResetPassword = "Đặt lại mật khẩu"
    static let titleResetPasswordError = "Đặt lại mật khẩu thất bại"
    static let titleSignup = "Đăng ký Tài khoản"
    static let titleSignupError = "Đăng ký Tài khoản thất bại"
    
    static let messageError = "Vui lòng thử lại."
    static let messageLoginErrorEmptyField = "Email bỏ trống hoặc mật khẩu đăng nhập không đủ 6 ký tự."
    static let messageLoginErrorInvalidEmail = "Địa chỉ email không hợp lệ. Vui lòng kiểm tra lại."
    static let messageLoginErrorWrongPassword = "Mật khẩu không đúng. Vui lòng kiểm tra lại."
    static let messageLoginErrorUserNotFound = "Tài khoản không tồn tại. Vui lòng tạo tài khoản."
    static let messageLoginErrorUserDisabled = "Tài khoản đang tạm thời bị khoá. Vui lòng liên hệ với chúng tôi tại tran.duc.tanb@sun-asterisk.com."
    static let messageResetPasswordErrorEmptyField = "Vui lòng không bỏ trống email."
    static let messageResetPasswordErrorInvalidRecipientEmail = "Email không tồn tại hoặc chưa được đăng ký tài khoản. Vui lòng kiểm tra lại."
    static let messageResetPasswordErrorSuccessfulAuth = "Đã gửi yêu cầu đặt lại mật khẩu. Vui lòng kiểm tra email để đặt lại mật khẩu."
    static let messageResetPasswordConfirmation = "Bạn có muốn đặt lại mật khẩu cho tài khoản %@ không?"
    static let messageSignupErrorEmptyField = "Vui lòng điền đầy đủ thông tin email, mật khẩu đăng nhập và xác nhận mật khẩu."
    static let messageSignupErrorShortPassword = "Mật khẩu đăng nhập không đủ 6 ký tự."
    static let messageSignupErrorPasswordNotMatch = "Xác nhận mật khẩu không giống với mật khẩu."
    
    static let buttonDeny = "Không"
    static let buttonAllow = "Đồng ý"
}
