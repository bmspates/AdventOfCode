def get_priority(x):
    lowercase = x == x.lower()
    return ord(x) - ord("a" if lowercase else "A") + (1 if lowercase else 27)


def solve(data):
    priority_sum, group_sum = 0, 0
    for line in data:
        l = len(line)
        lhs = {*line[:l // 2]}
        rhs = {*line[l // 2:]}
        priority_sum += sum(list(map(get_priority, lhs.intersection(rhs))))
    for i in range(0, len(data), 3):
        s0 = {*data[i]}
        s1 = {*data[i + 1]}
        s2 = {*data[i + 2]}
        group_sum += sum(list(map(get_priority, s0.intersection(s1).intersection(s2))))
    return priority_sum, group_sum


def parse_input():
    return [line.strip() for line in open("inputs/day03.txt", 'r')]


def main():
    print(solve(parse_input()))


if __name__ == "__main__":
    main()
