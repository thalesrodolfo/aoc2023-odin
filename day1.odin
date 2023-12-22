package main

import "core:fmt"
import "core:strconv"
import "core:os"
import "core:strings"

get_digits_from_line :: proc(line: string) -> [dynamic]int {
    digits: [dynamic]int

    for char in line {
        digit: int = strconv._digit_value(char)
        if (digit < 10) {
            append_elem(&digits, digit)
        }
    }

    return digits
}

day1 :: proc() {
    data, ok := os.read_entire_file("input.txt")
    defer delete(data)
    
    if !ok {
        fmt.println("Failed to read file")
    }

    lines, _ := strings.split_lines(string(data))
    defer delete(lines)
    
    total : int = 0

    for line in lines {
        digits := get_digits_from_line(line)

        if len(digits) > 0 {
            first := digits[:1][0]
            last := digits[len(digits)-1:][0]

            builder := strings.builder_make()
            strings.write_int(&builder, first)
            strings.write_int(&builder, last)
            str_number: string = strings.to_string(builder)

            total += strconv.atoi(str_number)
        }
        
    }

    fmt.println(total)
}