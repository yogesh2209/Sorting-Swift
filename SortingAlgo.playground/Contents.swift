//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var list = [ 10, 0, 3, 9, 2, 14, 26, 27, 1, 5, 8, -1, 8 ]

/*

 TYPES OF SORTING ALGORITHMS
 
    1. Selection Sort
    2. Bubble Sort
    3. Insertion Sort
    4. Merge Sort
    5. Quick Sort
 
*/
/*
 Parameters we talk about when we deal with any sorting algorithms
    1. Time complexity
    2. Space complexity - in place or memory usage grows with input size
    2. stability - if two elements are same, they should appear in the same order which they was in original unsorted list
*/

/* ----------------- Selection Sort --------------- */

/*
 Logic : assume first is min and then compare it with others - find small and put it  first position
 */

/*
 Time Complexity - O(n^2)
*/

func selectionSort(arr : inout Array<Int>) -> Array<Int>? {
    if arr.count == 0 { return nil }
    var iMin = 0
    for index in 0..<arr.count-2 {
        iMin = index
        for j in index+1..<arr.count {
            if arr[j] < arr[iMin] {
                iMin = j
            }
        }
        //Swap element at ith position and min
        let temp = arr[index]
        arr[index] = arr[iMin]
        arr[iMin] = temp
    }
    return arr
}


selectionSort(arr: &list)



/* ----------------- Bubble Sort --------------- */

/*
 Logic : largest element at the end during each pass. Compare i with adjacent element and check which one is small and then swap accordingly.
*/

/*
 Time Complexity - O(n^2) but in best case can be O(n) because of flag
 */

func bubbleSort(arr : inout Array<Int>) -> Array<Int>? {
    if arr.count == 0 { return nil }
    for k in 0..<arr.count - 1 {
        var flag = 0
        for index in 0..<arr.count - k - 1 {
            if arr[index] > arr[index + 1] {
                let temp = arr[index] //Swap arr[index] and arr[index+1]
                arr[index] = arr[index+1]
                arr[index+1] = temp
                flag = 1
            }
        }
        if flag == 0 {
            return arr //Already sorted array
        }
    }
    return arr
}

bubbleSort(arr: &list)


/* ----------------- Insertion Sort --------------- */

/*
 Logic : left side sorted array and right side unsorted array, pick one element from unsorted and put it in right order in sorted array
*/
 

//Not best sorting algo in terms of performance but it is little more than efficient than selection & bubble in terms of practical scenarios
/*
 Time Complexity - O(n^2)
 */

func insertionSort(arr : inout Array<Int>) -> Array<Int>? {
    for i in 1..<arr.count {
        let value = arr[i]
        var hole = i
        while (hole > 0 && arr[hole - 1] > value) {
            arr[hole] = arr[hole - 1]
            hole = hole - 1
        }
        arr[hole] = value
    }
    return arr
}

insertionSort(arr: &list)

/* ----------------- Merge Sort --------------- */

/*
 Logic : Divide and merge
 */
/*
 Time Complexity - O(nlogn) in worst case
 Space Complexity - O(n)
 NOT IN PLACE
 STABLE
 */
func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    let middleIndex = array.count / 2
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    return merge(leftPile: leftArray, rightPile: rightArray)
}

func merge<T: Comparable>(leftPile: [T], rightPile: [T]) -> [T] {
    
    var orderedPile = [T]()
    if orderedPile.capacity < leftPile.count + rightPile.count {
        orderedPile.reserveCapacity(leftPile.count + rightPile.count)
    }
    
    let nLength = leftPile.count
    let rLength = rightPile.count
    
    var i = 0
    var j = 0
    var k = 0
    
    while i < nLength && j < rLength {
        if leftPile[i] < rightPile[j] {
            orderedPile.append(leftPile[i])
            i += 1
            k = k + 1
        } else {
            orderedPile.append(rightPile[j])
            j += 1
            k = k + 1
        }
    }
    
    while i < nLength {
        orderedPile.append(leftPile[i])
        i = i + 1
        k = k + 1
    }
    
    while j < rLength {
        orderedPile.append(rightPile[j])
        j = j + 1
        k = k + 1
    }
    
    return orderedPile
}

let sortedArray = mergeSort(list)
let list2 = ["Tom", "Harry", "Ron", "Chandler", "Monica"]
let sortedArray2 = mergeSort(list2)


/* ----------------- Quick Sort --------------- */

/*
 Logic : Assume last element pivot, find partition index where left will be smaller and right will be larger than pivot element
 */


/*
 Time Complexity - O(nlogn) in best or average case and O(n^2) in worst case
 IN PLACE
 NOT STABLE
 */

func partitionIndex<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[high]
    var i = low
    for j in low..<high {
        if a[j] <= pivot {
            (a[i], a[j]) = (a[j], a[i])
            i += 1
        }
    }
    (a[i], a[high]) = (a[high], a[i])
    return i
}

func quicksort<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionIndex(&a, low: low, high: high)
        quicksort(&a, low: low, high: p - 1)
        quicksort(&a, low: p + 1, high: high)
    }
}

quicksort(&list, low: 0, high: list.count - 1)
