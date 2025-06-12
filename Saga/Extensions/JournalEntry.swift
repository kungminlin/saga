//
//  JournalEntry.swift
//  Saga
//
//  Created by Kung-Min Lin on 6/12/25.
//

import Foundation

extension [JournalEntry] {
    var streaks: Int {
        guard !isEmpty else { return 0 }
        let entry_dates = compactMap { $0.created_at }.sorted()
        
        // Get full day value of first date in array
        let referenceDate = Calendar.current.startOfDay(for: entry_dates.first!)
        // Get an array of (non-decreasing) integers
        let dayDiffs = entry_dates.map { (date) -> Int in
            Calendar.current.dateComponents([.day], from: referenceDate, to: date).day!
        }
        
        // Return max streak
        return maximalConsecutiveNumbers(in: dayDiffs)
    }
}

// Find maximal length of a subsequence of consecutive numbers in the array.
// It is assumed that the array is sorted in non-decreasing order.
// Consecutive equal elements are ignored.

private func maximalConsecutiveNumbers(in array: [Int]) -> Int{
    var longest = 0 // length of longest subsequence of consecutive numbers
    var current = 1 // length of current subsequence of consecutive numbers

    for (prev, next) in zip(array, array.dropFirst()) {
        if next > prev + 1 {
            // Numbers are not consecutive, start a new subsequence.
            current = 1
        } else if next == prev + 1 {
            // Numbers are consecutive, increase current length
            current += 1
        }
        if current > longest {
            longest = current
        }
    }
    return longest
}
