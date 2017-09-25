//
//  Section.swift
//  App
//
//  Created by Remi Robert on 16/09/2017.
//  Copyright © 2017 Remi Robert. All rights reserved.
//

struct Section {
    let header: CellViewModel?
    let footer: CellViewModel?
    let models: [CellViewModel]

    init(models: [CellViewModel],
         header: CellViewModel? = nil,
         footer: CellViewModel? = nil) {
        self.models = models
        self.header = header
        self.footer = footer
    }
}
