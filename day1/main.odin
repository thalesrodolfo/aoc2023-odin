package day1

import "core:os"
import "core:fmt"

main :: proc () {
    data, ok := os.read_entire_file("input.txt")    
    defer delete(data)
    
    if !ok {
        fmt.println("Failed to read file")
    }

    day1(string(data))
}