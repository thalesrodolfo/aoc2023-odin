package day2

import "core:fmt"
import "core:strings"
import "core:strconv"

part1 :: proc(input: string) {
    total_ids := 0

    bag := map[string]int {
        "red" = 12,
        "green" = 13,
        "blue" = 14,
    }

    for line in strings.split_lines(input) {
        parts := strings.split(line, ":")

        game := parts[0]
        content := parts[1]

        should_count := true

        for qty_color in strings.split(content, ";") {
            p := strings.split(strings.trim_space(qty_color), " ")

            counter := 0
            for counter <= len(p) - 1 {
                qty := p[counter]
                color := strings.trim_right(p[counter+1], ",")

                if _, ok := bag[color]; ok {
                    if strconv.atoi(qty) > bag[color] {
                        should_count = false
                    }
                }

                counter += 2
            }
        }

        if should_count {
                game_id := strings.split(game, " ")[1]
                total_ids += strconv.atoi(game_id)
        }

    }

    fmt.println("PART1 TOTAL: ", total_ids)
}


part2 :: proc(input: string) {
    total := 0
    for line in strings.split_lines(input) {
        bag := make(map[string]int)
        parts := strings.split(line, ":")

        game := parts[0]
        content := parts[1]

        for qty_color in strings.split(content, ";") {
            p := strings.split(strings.trim_space(qty_color), " ")

            counter := 0
            for counter <= len(p) - 1 {
                qty := p[counter]
                color := strings.trim_right(p[counter+1], ",")

                if v, ok := bag[color]; ok {
                    if strconv.atoi(qty) > bag[color] {
                        bag[color] = strconv.atoi(qty)
                    }
                } else {
                    bag[color] = strconv.atoi(qty)
                }

                counter += 2
            }
        }

        fmt.println("line:", line)
        fmt.println("bag:", bag)

        result := bag["red"] * bag["green"] * bag["blue"]

        fmt.println("result:", result)

        total += result
    }

    fmt.println("Part 2 total:", total)
}