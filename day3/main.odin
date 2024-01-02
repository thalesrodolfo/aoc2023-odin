package day3

import "core:os"
import "core:fmt"

main :: proc () {
    data, ok := os.read_entire_file("day3_input.txt")
    defer delete(data)
    
    if !ok {
        fmt.println("Failed to read file")
    }

    part1(string(data))
}