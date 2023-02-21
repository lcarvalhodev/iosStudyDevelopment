//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Leandro Almeida de Carvalho on 12/01/23.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(accessToken: "any_token")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "any_name", email: "any_email@mail.com", password: "any_password", confirmPassword: "any_password")
}

func makeAuthenticationModel() -> AuthenticationModel {
    return AuthenticationModel(email: "any_email@mail.com", password: "any_password")
}
