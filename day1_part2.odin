package main

import "core:fmt"
import "core:strconv"
import "core:os"
import "core:strings"


day1_part2 :: proc() {
    data, ok := os.read_entire_file("input.txt")
    defer delete(data)
    
    if !ok {
        fmt.println("Failed to read file")
    }

    lines, _ := strings.split_lines(string(data))
    defer delete(lines)
    
    total : int = 0

    for line in lines {
        result := make(map[int]string)
        defer delete(result)        

        parse_digits(&result, line)
        parse_string_numbers(&result, line)

        first, last: string = get_first_last(result)
        total += strconv.atoi(strings.concatenate({first, last}))
    }

    fmt.println(total)
}


parse_digits :: proc(result: ^map[int]string, line: string) {
    for c, index in line {
        if strconv._digit_value(c) < 10 {
            result[index] = fmt.tprint(c)
        }
    }
}


parse_string_numbers :: proc(result: ^map[int]string, line:string) {
    numbers := []string{"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

    for n in numbers {
        tmp := line
        found_pos := strings.index(tmp, n)

        for found_pos > -1 {
            result[found_pos] = tmp[found_pos:found_pos+len(n)] // put into the map
            replace_string := tmp[:found_pos+len(n)] // position in the string which will be "deleted" (replaced)
            tmp, _ = strings.replace(tmp, replace_string, strings.repeat("z", len(replace_string)), 1) // replace part with z's (simulate deletion) 
            found_pos = strings.index(tmp, n) // seach again in the string without the part "deleted" while indexes remain correct
        }
    }
}


get_first_last :: proc(result: map[int]string) -> (string, string) {
    biggest := 0
    lowest := 1000

    for y, x in result {
        if y > biggest {
            biggest = y
        }

        if y < lowest {
            lowest = y
        }
    }

    first: string = get_str_number(result[lowest])
    last: string = get_str_number(result[biggest])

    return first, last
}


get_str_number :: proc(value: string) -> string {
    if strconv._digit_value(rune(value[0])) > 9 {
        switch value {
            case "one": return "1"
            case "two": return "2"
            case "three": return "3"
            case "four": return "4"
            case "five": return "5"
            case "six": return "6"
            case "seven": return "7"
            case "eight": return "8"
            case "nine": return "9"
        }
    } 

    return value
}