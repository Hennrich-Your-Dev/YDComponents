//
//  YDSnackBarView.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 14/01/21.
//

import UIKit

public protocol YDSnackBarDelegatePRE: AnyObject {
  func onSnackAction()
}

// MARK: Enum
public enum YDSnackBarTypePRE {
  case withButton
  case simple
}

public class YDSnackBarView: UIView {
  // MARK: Properties
  public weak var delegate: YDSnackBarDelegatePRE?

  // MARK: Life cycle
  public init() {
    super.init(frame: .zero)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
