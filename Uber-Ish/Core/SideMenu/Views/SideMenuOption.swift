//
//  SideMenuOption.swift
//  Uber-Ish
//
//  Created by Cool-Ish on 8/17/23.
//

import SwiftUI

struct SideMenuOption: View {
    var viewModel: SideMenuOptionViewModel
    
    var body: some View {
        HStack {
            Image(systemName: viewModel.iconName)
                .font(.title2)
                .imageScale(.medium)
            
            Text(viewModel.title)
                .font(.system(size: 16, weight: .semibold))
                .padding(6)
            
            Spacer()
        }
    }
}

struct SideMenuOption_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOption(viewModel: .messages)
    }
}
