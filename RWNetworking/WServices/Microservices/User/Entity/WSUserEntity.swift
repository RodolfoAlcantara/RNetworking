//
//  WSUserEntity.swift
//  RWNetworking
//
//  Created by Rodolfo Benjamin Alcantara Solorio on 04/12/19.
//  Copyright © 2019 Rodolfo Benjamin Alcantara Solorio. All rights reserved.
//

import Foundation

// MARK: - RWNetworkingEntity
public struct RWNetworkingEntity: Codable {
    public var aboutMeHeader, languagesHeader, educationHeader, workExperienceHeader, personalProjectsHeader, programmingHeader, certificationsHeader, extracurricularsHeader: Header
    public var name, address, about, photo: String?
    public var languages: [Language]?
    public var workExperience, education, certifications: [Certification]?
    public var personalProjects: [PersonalProject]?
    public var programmingLanguages, extracurricular: [String]?
    public var contact: Contact?
}

// MARK: - Header
public struct Header: Codable {
    public var title, icon: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do { self.title = try values.decodeIfPresent(String.self, forKey: .title) } catch { }
        do { self.icon = try values.decodeIfPresent(String.self, forKey: .icon) } catch { }
    }
}

// MARK: - Certification
public struct Certification: Codable {
    public var title, certificationDescription: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do { self.title = try values.decodeIfPresent(String.self, forKey: .title) } catch { }
        do { self.certificationDescription = try values.decodeIfPresent(String.self, forKey: .certificationDescription) } catch { }
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case certificationDescription = "description"
    }
}

// MARK: - Contact
public struct Contact: Codable {
    public var phone, email, github: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do { self.phone = try values.decodeIfPresent(String.self, forKey: .phone) } catch { }
        do { self.email = try values.decodeIfPresent(String.self, forKey: .email) } catch { }
        do { self.github = try values.decodeIfPresent(String.self, forKey: .github) } catch { }
    }
}

// MARK: - Language
public struct Language: Codable {
    var language, percentage: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do { self.language = try values.decodeIfPresent(String.self, forKey: .language) } catch { }
        do { self.percentage = try values.decodeIfPresent(String.self, forKey: .percentage) } catch { }
    }
}

// MARK: - PersonalProject
public struct PersonalProject: Codable {
    public var name, icon, personalProjectDescription: String?
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do { self.name = try values.decodeIfPresent(String.self, forKey: .name) } catch { }
        do { self.icon = try values.decodeIfPresent(String.self, forKey: .icon) } catch { }
        do { self.personalProjectDescription = try values.decodeIfPresent(String.self, forKey: .personalProjectDescription) } catch { }
    }
    
    enum CodingKeys: String, CodingKey {
        case name, icon
        case personalProjectDescription = "description"
    }
}

