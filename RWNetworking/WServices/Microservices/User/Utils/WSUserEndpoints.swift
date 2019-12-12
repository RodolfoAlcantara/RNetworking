//
//  WSUserEndpoints.swift
//  RWNetworking
//
//  Created by Rodolfo Benjamin Alcantara Solorio on 04/12/19.
//  Copyright © 2019 Rodolfo Benjamin Alcantara Solorio. All rights reserved.
//

#if DEBUG
    fileprivate let mainURL = "https://gist.githubusercontent.com/"
#else
    fileprivate let mainURL = "https://gist.githubusercontent.com/"
#endif

internal struct URLUSER {
    let WSUSERGETDATA = mainURL + "crisalgarol/1683c82a40ce47fd6e61051edbee2ae4/raw/29bf85633e51f221dfc97518fb31c54822cfbf75/rw.json"
    let WSUSERPOSTDATA = mainURL + "/postData"
}
