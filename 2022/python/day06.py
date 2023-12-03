from collections import Counter


def is_unique(s):
    return Counter([*s]).most_common(1)[0][1] <= 1


def solve(message, j):
    i = 0
    while j < len(message):
        if is_unique(message[i:j]):
            return j
        i += 1
        j += 1


def parse_input():
    return [line.strip() for line in open("inputs/day06.txt", 'r')]


def main():
    line = parse_input()[0]
    print(solve(line, 4))
    print(solve(line, 14))


if __name__ == "__main__":
    main()
