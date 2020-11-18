//
//  YDDialogViewModel.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 17/11/20.
//

import Foundation

// MARK: Delegate
public protocol YDDialogNavigationDelegate: AnyObject {
  func onAction()
}

protocol YDDialogViewModelDelegate: AnyObject {
  func onAction()
}

// MARK: ViewModel
class YDDialogViewModel {
  // MARK: Properties
  let navigation: YDDialogNavigationDelegate

  // MARK: Init
  init(navigation: YDDialogNavigationDelegate) {
    self.navigation = navigation
  }
}

extension YDDialogViewModel: YDDialogViewModelDelegate {
  func onAction() {
    navigation.onAction()
  }
}
