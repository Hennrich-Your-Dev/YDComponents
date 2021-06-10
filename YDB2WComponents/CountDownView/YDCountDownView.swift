//
//  YDCountDownView.swift
//  YDB2WComponents
//
//  Created by Douglas Hennrich on 09/06/21.
//

import UIKit
import YDExtensions
import YDB2WModels

public class YDCountDownView: UIView {
  // MARK: Components
  let titleLabel = UILabel()
  let stackView = UIStackView()
  let daysView = YDCountDownComponentView(description: "dias")
  let hoursView = YDCountDownComponentView(description: "horas")
  let minutesView = YDCountDownComponentView(description: "minutos")
  let secondsView = YDCountDownComponentView(description: "segundos")

  // MARK: Init
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public init() {
    super.init(frame: .zero)
    configureUI()
  }

  // MARK: Actions
  public func start(with date: Date) {
    //
  }
}

// MARK: UI
extension YDCountDownView {
  private func configureUI() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    layer.cornerRadius = 6

    configureTitleLabel()
    configureStackView()
  }

  private func configureTitleLabel() {
    addSubview(titleLabel)
    titleLabel.textColor = Zeplin.black
    titleLabel.font = .boldSystemFont(ofSize: 14)
    titleLabel.textAlignment = .center
    titleLabel.text = "A live já vai começar, não sai do lugar!"

    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      titleLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }

  private func configureStackView() {
    addSubview(stackView)
    stackView.alignment = .center
    stackView.axis = .horizontal
    stackView.spacing = 8
    stackView.distribution = .equalCentering

    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 20)
    ])

    //
    let views = [
      daysView,
      createSeparatorDots(),
      hoursView,
      createSeparatorDots(),
      minutesView,
      createSeparatorDots(),
      secondsView
    ]

    views.forEach { stackView.addArrangedSubview($0) }
  }

  private func createSeparatorDots() -> UILabel {
    let dots = UILabel()
    dots.textColor = Zeplin.grayNight
    dots.font = .boldSystemFont(ofSize: 20)
    dots.text = ":"
    return dots
  }
}
