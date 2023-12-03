winning_moves = {"A": "Y", "B": "Z", "C": "X"}
loosing_moves = {"A": "Z", "B": "X", "C": "Y"}
same_moves = {"A": "X", "B": "Y", "C": "Z"}
points_per_move = {"X": 1, "Y": 2, "Z": 3}


def eval_game(opp_move, your_move):
    if same_moves[opp_move] == your_move:
        return 3
    return 6 if winning_moves[opp_move] == your_move else 0


def determine_move(opp_move, win_cond):
    cond_to_moves = {"X": loosing_moves, "Y": same_moves, "Z": winning_moves}
    return cond_to_moves[win_cond][opp_move]


def solve(data):
    score = 0
    for game in data:
        score += points_per_move[game[1]] + eval_game(game[0], game[1])
    return score


def parse_input():
    data = [line.strip() for line in open("inputs/day02.txt", 'r')]
    data = [x.split(" ") for x in data]
    return data


def main():
    p1 = solve(parse_input())
    p2 = solve(map(lambda x: (x[0], determine_move(x[0], x[1])), parse_input()))
    print((p1, p2))


if __name__ == "__main__":
    main()
