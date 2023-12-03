class File:
    def __init__(self, name: str, size: int):
        self.name = name
        self.size = size
        self.type = "FILE"


class Directory:
    def __init__(self, name: str, parent):
        self.children: list[Directory] = []
        self.files: list[File] = []
        self.name: str = name
        self.parent: Directory = self if parent is None else parent
        self.root: Directory = self.parent if parent is None else parent.root
        self.type: str = "DIR"

    def size(self):
        size = 0
        for child in self.children:
            size += child.size()
        for child in self.files:
            size += child.size
        return size

    def size_smaller(self, num):
        size = self.size()
        ret_val = 0
        if size < num:
            ret_val += size
        for child in self.children:
            ret_val += child.size_smaller(num)
        return ret_val

    def find_smallest_larger_than(self, num, dirs):
        size = self.size()
        if size > num:
            dirs.append(size)
        for child in self.children:
            child.find_smallest_larger_than(num, dirs)
        print(f"in {self.name}")
        print(dirs)
        return min(dirs)

    # `cd ./{dir}` should not be O(len(children)) ... but I am not making a shell or an OS here I'm helping Santa
    #    in which case I would certainly not store the fs root "pointer" in every directory but ¯\_(ツ)_/¯
    def cd(self, name):
        if name == "/":
            return self.root
        elif name == "..":
            return self.parent

        for child in self.children:
            if child.name == name:
                return child
        return None

    def add_child(self, name):
        if Directory(name, self) in self.children:
            raise Exception
        self.children.append(Directory(name, self))

    def add_file(self, name, size):
        if File(name, size) in self.files:
            raise Exception
        self.files.append(File(name, size))

    def add(self, name, type_or_size):
        if type_or_size == "dir":
            self.add_child(name)
        else:
            self.add_file(name, int(type_or_size))


def solve(filesystem_root):
    part_one = filesystem_root.size_smaller(100000)
    part_two = filesystem_root.find_smallest_larger_than(30000000 - (70000000 - filesystem_root.size()), [])
    return part_one, part_two


def parse_input():
    lines = [line.split() for line in open("inputs/day07.txt", 'r')]
    filesystem_root = Directory("/", None)
    pwd = filesystem_root
    for line in lines:
        match line:
            case ["$", "cd", name]:
                pwd = pwd.cd(name)
            case ["$", "ls"]:
                pass
            case [type_or_size, name]:  # For the output of ls, will need to rework if new command adds output
                pwd.add(name, type_or_size)
                print(f"Added {name} of type or size {type_or_size}")

    return filesystem_root


if __name__ == "__main__":
    print(solve(parse_input()))
