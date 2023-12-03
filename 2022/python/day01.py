def solve(data):
    calories = []
    cal_count = 0
    for line in data:
        if line == "":
            calories.append(cal_count)
            cal_count = 0
        else:
            cal_count += int(line)
    calories.sort()
    return max(calories), sum(calories[-3:])


def parse_input():
    return [line.strip() for line in open("inputs/day01.txt", 'r')]


def main():
    print(solve(parse_input()))


if __name__ == "__main__":
    main()
