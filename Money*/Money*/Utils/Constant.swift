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
    static let cornerRadius: CGFloat = 5
    static let shadowRadius: CGFloat = 2
    static let shadowOffset = CGSize(width: 0, height: 1)
    static let shadowOpacity: Float = 0.6
    static let walletCollectionMinimumLineSpacing: CGFloat = 40
    static let walletCollectionActiveDistance: CGFloat = 200
    static let walletCollectionZoomFactor: CGFloat = 0.15
    static let walletCollectionCellWidth: CGFloat = 250
    static let walletCollectionCellHeight: CGFloat = 70
    
    static let transactionLastestNumRecords = 10
    static let transactionCellHeight: CGFloat = 88
    
    // MARK: - Account Params
    static let minPasswordLength = 6
    static let maxNumWallets = 6
    
    // MARK: - Notification Params
    static let defaultNotificationHour = 22
    static let defaultNotificationMinute = 0
    
    // MARK: - String
    static let titleError = "Lỗi"
    static let titleLoginError = "Đăng nhập thất bại"
    static let titleResetPassword = "Đặt lại mật khẩu"
    static let titleResetPasswordError = "Đặt lại mật khẩu thất bại"
    static let titleSignup = "Đăng ký Tài khoản"
    static let titleSignupError = "Đăng ký Tài khoản thất bại"
    static let titleSignoutError = "Đăng xuất thất bại"
    static let titleFeatureNotDone = "Tính năng chưa hỗ trợ"
    
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
    static let messageSnapshotError = "Tải dữ liệu về bị lỗi."
    static let messageDataError = "Dữ liệu bị lỗi!"
    static let messageWalletErrorEmpty = "Chưa có ví. Vui lòng tạo ví trước."
    static let messageWalletErrorEmptyName = "Vui lòng không bỏ trống tên ví."
    static let messageWalletErrorNotNumberBalance = "Số dư chỉ chứa các chữ số 0-9."
    static let messageWalletErrorSave = "Không thể lưu lại ví. Vui lòng thử lại."
    static let messageWalletUpdateError = "Ví không tồn tại. Không thể sửa ví."
    static let messageWalletDeleteError = "Ví không tồn tại. Không thể xoá ví."
    static let messageTransactionErrorEmptyName = "Vui lòng không bỏ trống tên giao dịch."
    static let messageTransactionErrorNotNumberAmount = "Số tiền chỉ chứa các chữ số 0-9."
    static let messageTransactionErrorSave = "Không thể lưu lại giao dịch. Vui lòng thử lại."
    static let messageTransactionErrorAmount = "Không thể lưu lại giao dịch. Số tiền của giao dịch không được lớn hơn số dư trong tài khoản."
    static let messageTransactionUpdateError = "Giao dịch không tồn tại. Không thể sửa giao dịch."
    static let messageTransactionDeleteError = "Giao dịch không tồn tại. Không thể xoá giao dịch."
    
    static let promptNoWallet = "Bạn chưa có ví nào. Hãy tạo ví trong Quản lý Tài khoản."
    
    static let messageFeatureReportNotDone = "Xin lỗi. Chức năng tạo Báo cáo tài chính chưa được hỗ trợ tại phiên bản này."
    static let messageFeatureBudgetNotDone = "Xin lỗi. Chức năng tạo Quỹ Tiết kiệm chưa được hỗ trợ tại phiên bản này."
    
    static let titleUserNotification = "Money* Hàng ngày"
    static let bodyUserNotification = "Hãy cập nhật thu - chi trong ngày hôm nay của bạn để quản lý tài chính tốt hơn."
    
    static let buttonDeny = "Không"
    static let buttonAllow = "Đồng ý"
    static let buttonOK = "OK"
    
    static let sceneTitleDashboard = "Tổng: "
    static let sceneTitleWalletManagement = "Ví của tôi"
    static let sceneTitleAddWallet = "Thêm ví"
    static let sceneTitleEditWallet = "Sửa ví"
    static let sceneTitleWalletType = "Loại ví"
    static let sceneTitleAddTransaction = "Thêm giao dịch"
    static let sceneTitleEditTransaction = "Sửa giao dịch"
    static let sceneTitleTransactionType = "Loại giao dịch"
    
    static let WalletName = [
        0: "Tiền mặt",
        1: "Thẻ ngân hàng",
        2: "Khác"
    ]
    
    static let TransactionName = [
        "expense-restaurant": "Quán ăn/Nhà hàng",
        "expense-coffee": "Đồ uống/ Quán Cafe",
        "expense-bill": "Hoá đơn",
        "expense-shopping": "Mua sắm",
        "expense-transport": "Di chuyển",
        "expense-education": "Giáo dục",
        "expense-entertainment": "Giải trí",
        "expense-gift": "Quà tặng/Quyên góp",
        "expense-travel": "Du lịch",
        "expense-health": "Sức khoẻ",
        "expense-insurance": "Bảo hiểm",
        "expense-pet": "Vật nuôi",
        "expense-investment": "Đầu tư",
        "expense-exchange": "Chuyển khoản đi",
        "expense-other": "Khoản chi khác",
        "income-salary": "Lương",
        "income-bonus": "Thưởng",
        "income-profit": "Tiền lãi",
        "income-sale": "Bán đồ",
        "income-take": "Được cho, tặng",
        "income-exchange": "Chuyển khoản đến",
        "income-other": "Khoản thu khác"
    ]
}
