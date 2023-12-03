import re


class Range:
    def __init__(self, start, end):
        self.start = int(start)
        self.end = int(end)

    def __str__(self):
        return "(" + str(self.start) + "," + str(self.end) + ")"

    def contains(self, other):
        return self.start <= other.start and self.end >= other.end \
               or (other.start <= self.start and other.end >= self.end)

    def overlaps(self, other):
        overlap = other.end >= self.start >= other.start \
                  or self.end >= other.start >= self.start
        return overlap


def build_ranges(groups) -> tuple[Range, Range]:
    r1 = Range(int(groups[0]), int(groups[1]))
    r2 = Range(int(groups[2]), int(groups[3]))
    return r1, r2


def solve(data):
    ranges, contain_count, overlap_count = [], 0, 0
    for line in data:
        result = re.search(r"(\d*)-(\d*),(\d*)-(\d*)", line)
        rs: tuple[Range, Range] = build_ranges(result.groups())
        ranges.append(rs)
        contain_count += 1 if rs[0].contains(rs[1]) else 0
        overlap_count += 1 if rs[0].overlaps(rs[1]) else 0

    return contain_count, overlap_count


def parse_input():
    return [line.strip() for line in open("inputs/day04.txt", 'r')]


def main():
    print(solve(parse_input()))


if __name__ == "__main__":
    main()
