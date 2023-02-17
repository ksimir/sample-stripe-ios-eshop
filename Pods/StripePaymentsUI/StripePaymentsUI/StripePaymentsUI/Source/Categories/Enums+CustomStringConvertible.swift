//
//  Enums+CustomStringConvertible.swift
//  Stripe
//
//  Autogenerated by generate_objc_enum_string_values.rb
//  Copyright © 2021 Stripe, Inc. All rights reserved.
//

/// :nodoc:
extension STPCardFieldType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .CVC:
            return "CVC"
        case .expiration:
            return "expiration"
        case .number:
            return "number"
        case .postalCode:
            return "postalCode"
        }
    }
}

/// :nodoc:
extension STPCardFormViewStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .borderless:
            return "borderless"
        case .standard:
            return "standard"
        }
    }
}

/// :nodoc:
extension STPPostalCodeIntendedUsage: CustomStringConvertible {
    public var description: String {
        switch self {
        case .billingAddress:
            return "billingAddress"
        case .cardField:
            return "cardField"
        case .shippingAddress:
            return "shippingAddress"
        }
    }
}
