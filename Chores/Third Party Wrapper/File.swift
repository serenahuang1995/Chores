//
//  File.swift
//  Chores
//
//  Created by 黃瀞萱 on 2021/5/23.
//
//

//import KRProgressHUD
////
////enum HUDType {
////
////    case success(String)
////
////    case failure(String)
////}
////
//class KRProgressHUD {
//
//    static let shared = KRProgressHUD()
////
//  public static func showSuccess(withMessage message: String? = nil) {
//      shared.show(withMessage: message, iconType: .success)
//  }
//
//  /// Shows the HUD with information glyph.
//  /// The HUD dismiss after `duration` secound.
//  ///
//  /// - Parameter message: HUD's message.
//  public static func showInfo(withMessage message: String? = nil) {
//      shared.show(withMessage: message, iconType: .info)
//  }
//
//  /// Shows the HUD with warning glyph.
//  /// The HUD dismiss after `duration` secound.
//  ///
//  /// - Parameter message: HUD's message.
//  public static func showWarning(withMessage message: String? = nil) {
//      shared.show(withMessage: message, iconType: .warning)
//  }
//
//  /// Shows the HUD with error glyph.
//  /// The HUD dismiss after `duration` secound.
//  ///
//  /// - Parameter message: HUD's message.
//  public static func showError(withMessage message: String? = nil) {
//      shared.show(withMessage: message, iconType: .error)
//  }
//
//  /// Shows the HUD with image.
//  /// The HUD dismiss after `duration` secound.
//  ///
//  /// - Parameters:
//  ///   - image: Image that display instead of activity indicator.
//  ///   - size: Image size.
//  ///   - message: HUD's message.
//  public static func showImage(_ image: UIImage, size: CGSize? = nil, message: String? = nil) {
//      shared.show(withMessage: message, image: image, imageSize: size)
//  }
//
//  /// Shows the message only HUD.
//  /// The HUD dismiss after `duration` secound.
//  ///
//  /// - Parameter message: HUD's message.
//  public static func showMessage(_ message: String) {
//      shared.show(withMessage: message, isOnlyText: true)
//  }
//
//  /// Updates the HUD message.
//  ///
//  /// - Parameter message: Message.
//  public static func update(message: String) {
//      shared.messageLabel.text = message
//  }
//
//  /// Hides the HUD.
//  ///
//  /// - Parameter completion: Hide completion handler.
//  public static func dismiss(_ completion: CompletionHandler? = nil) {
//      shared.dismiss(completion: completion)
//  }
//}
