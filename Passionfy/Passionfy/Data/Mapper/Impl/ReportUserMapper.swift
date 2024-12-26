//
//  ReportUserMapper.swift
//  Passionfy
//
//  Created by Sergio Sánchez Sánchez on 26/12/24.
//

import Foundation

class ReportUserMapper: Mapper {
    typealias Input = ReportUser
    typealias Output = ReportUserDTO
    
    func map(_ input: ReportUser) -> ReportUserDTO {
        return ReportUserDTO(
            reporterId: input.reporterId,
            reportedId: input.reportedId,
            reason: input.reason
        )
    }
}
