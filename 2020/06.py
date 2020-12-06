def part_one(data):
    return sum([ len(answers[0].keys()) for answers in data ])

def part_two(data):
    count = 0
    for answers in data:
        count += sum([ 1 for question in answers[0].keys() if answers[0][question] == answers[1] ])
    return count


data = [ line.strip() for line in open("inputs/day6.txt", 'r') ]

answers, questions, people = [], dict(), 0
for line in data:
    if line == "":
        answers.append((questions, people))
        questions, people = dict(), 0
        continue
    people += 1
    for char in line:
        questions[char] = 1 if char not in questions.keys() else questions[char] + 1
answers.append((questions, people))

print(part_one(answers))
print(part_two(answers))
