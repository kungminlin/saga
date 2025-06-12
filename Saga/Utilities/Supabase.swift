//
//  Supabase.swift
//  Saga
//
//  Created by Kung-Min Lin on 2/27/25.
//

import Foundation
import Supabase

let supabaseURL = Bundle.main.object(forInfoDictionaryKey: "SupabaseURL") as! String

let supabaseKey = Bundle.main.object(forInfoDictionaryKey: "SupabaseKey") as! String

let supabase = SupabaseClient(supabaseURL: URL(string: supabaseURL)!, supabaseKey: supabaseKey)
