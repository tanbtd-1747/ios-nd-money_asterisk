//
//  StringConstant.swift
//  Money*
//
//  Created by tran.duc.tan on 3/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import Foundation

struct StringConstant {
    static let titleLoginError = "Đăng nhập thất bại"
    static let titleResetPassword = "Đặt lại mật khẩu"
    static let titleResetPasswordError = "Đặt lại mật khẩu thất bại"
    
    static let messageLoginErrorEmptyField = "Vui lòng không bỏ trống email hoặc mật khẩu đăng nhập."
    static let messageLoginErrorFailedAuth = "Địa chỉ email hoặc mật khẩu không đúng. Vui lòng kiểm tra lại."
    static let messageResetPasswordErrorEmptyField = "Vui lòng không bỏ trống email."
    static let messageResetPasswordErrorFailedAuth = "Email không tồn tại hoặc chưa được đăng ký tài khoản. Vui lòng kiểm tra lại."
    static let messageResetPasswordErrorSuccessfulAuth = "Đã gửi yêu cầu đặt lại mật khẩu. Vui lòng kiểm tra email để đặt lại mật khẩu."
    static let messageResetPasswordConfirmation = "Bạn có muốn đặt lại mật khẩu cho tài khoản %@ không?"
    
    static let buttonResetPasswordDeny = "Không"
    static let buttonResetPasswordAllow = "Đồng ý"
}
