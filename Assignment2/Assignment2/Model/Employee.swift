//
//  Employee.swift
//  Assignment2
//
//  Created by Howard Barde on 4/8/25.
//
import Foundation

struct Employee: Identifiable, Codable {
    var id: String { uuid }
    let uuid: String
    let fullName: String
    let phoneNumber: String
    let emailAddress: String
    let biography: String
    let photoUrlSmall: String
    let photoUrlLarge: String
    let team: String
    let employeeType: String

    enum CodingKeys: String, CodingKey {
        case uuid, fullName = "full_name", phoneNumber = "phone_number", emailAddress = "email_address", biography, photoUrlSmall = "photo_url_small", photoUrlLarge = "photo_url_large", team, employeeType = "employee_type"
    }
}

enum EmployeeType: String {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}

