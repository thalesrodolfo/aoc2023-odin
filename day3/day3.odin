package day3

import "core:strings"
import "core:fmt"
import "core:strconv"

Ocur :: struct {
    begin: int,
    end: int
}

part1 :: proc(input: string) {

    control := make(map[int][dynamic]Ocur)
    current_line := 0
    lines := strings.split_lines(input)

    for line in lines {
        current_digit := ""
        begin_index := -1

        for c, index in line {
            if strconv._digit_value(c) > 9 {
                if current_digit == "" {
                    continue
                } else {
                    add_current_digit(current_line, &begin_index, &current_digit, &control)
                }
            } else {
                if current_digit == "" {
                    begin_index = index
                }

                current_digit = strings.concatenate({current_digit, fmt.tprint(c)})
            } 
        }
        
        if current_digit != "" {
            add_current_digit(current_line, &begin_index, &current_digit, &control)
        }

        current_line += 1
    }

    result := 0
    for line, list_occur in control {
        total_line := 0 
        content_line := lines[line]

        for occur in list_occur {
            left_right_adjacent := left_and_right_check(line, occur, content_line)

            has_adjacent_in_previous_line := false
            has_adjacent_in_next_line := false

            if line > 0 {
                previous_line := lines[line - 1]
                has_adjacent_in_previous_line = check_adjacent_in_line(previous_line, occur) 

            }

            if line < len(lines) -1 {
                next_line := lines[line + 1]
                has_adjacent_in_next_line = check_adjacent_in_line(next_line, occur) 
            }

            if left_right_adjacent ||
                has_adjacent_in_next_line ||
                has_adjacent_in_previous_line {

                    str_number := content_line[occur.begin: occur.end]
                    total_line += strconv.atoi(str_number)
                }

        }

        result += total_line

    }
    fmt.println("result: ", result)
}

add_current_digit :: proc(current_line: int, begin_index: ^int, current_digit: ^string, control: ^map[int][dynamic]Ocur) {
    o := Ocur{begin_index^, begin_index^ + len(current_digit^)}

    r, ok := control[current_line]

    if !ok {
        control[current_line] = {o}
    } else {
        new_list := r
        append_elem(&new_list, o)
        control[current_line] = new_list
    }

    begin_index^ = -1
    current_digit^ = ""
}

check_adjacent_in_line :: proc(line: string, occur: Ocur) -> bool{
    b := occur.begin
    e := occur.end

    if b > 0 {
        b -= 1
    }

    if e < len(line) - 1 {
        e += 1
    }

    part := line[b:e]

    for c in part {
        u : rune = rune(c)
        if u != '.' && strconv._digit_value(u) > 9 {
            return true
        }
    }

    return false
}

left_and_right_check :: proc(line: int, occur: Ocur, content_line: string) -> bool {
    if occur.begin > 0 {
        u : rune = rune(content_line[occur.begin - 1])

        if u != '.' && strconv._digit_value(u) > 9 {
            return true
        }
    }

    if occur.end < len(content_line){
        s : rune = rune(content_line[occur.end])

        if s != '.' && strconv._digit_value(s) > 9 {
            return true
        }
    }
        
    return false
}