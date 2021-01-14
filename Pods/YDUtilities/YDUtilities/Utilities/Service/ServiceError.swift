//
//  ServiceError.swift
//  YDUtilities
//
//  Created by Douglas Hennrich on 09/12/20.
//

import Foundation

public enum YDServiceError: Error {
  case badRequest             // Status code 400
  case notFound               // Status code 404
  case internalServerError    // Status code 500

  case cantCreateUrl
  case noService
  case unknow(error: Error)

  var message: String {
    switch self {
    case .badRequest:
      return "API inválida"

    case .notFound:
      return "API não encontrada"

    case .internalServerError:
      return "Erro na API"

    case .cantCreateUrl:
      return "Erro ao montar a API"

    case .noService:
      return "Sem serviço"

    case .unknow:
      return "Erro inesperado"
    }
  }

  var type: YDServiceError {
    switch self {
    case .badRequest:
      return .badRequest
    case .notFound:
      return .notFound
    case .internalServerError:
      return .internalServerError
    case .cantCreateUrl:
      return .cantCreateUrl
    case .noService:
      return .noService
    case .unknow(let error):
      return .unknow(error: error)
    }
  }
}
