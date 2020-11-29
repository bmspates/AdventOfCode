import fileinput, numpy

def count_digits(layer, digit):
    count = 0
    for row in layer:
        for num in row:
            count += 1 if num == digit else 0
    return count

data = [ line.strip() for line in open("inputs/day8.txt", 'r') ]
# data = [ line.strip() for line in open("inputs/tests/8.txt", 'r') ]
data = data[0]
data = [ int(char) for char in data ]

width = 25
height = 6
layers = len(data) // (width * height)
layer_len = len(data) // layers

row = [ 0 for _ in range(width) ]
image = [] # image[layer][y][x]
for _ in range(layers):
    layer = []
    for __ in range(height):
        layer.append(row.copy())
    image.append(layer)

for i in range(len(data)):
    layer = i // layer_len
    x = (i % layer_len) % width
    y = (i % layer_len) // width
    image[layer][y][x] = data[i]

zero_count = dict()
for l_num, layer in enumerate(image):
    num_zeros = count_digits(layer, 0)
    zero_count[l_num] = num_zeros
min_ = (0, width * height + 1)
for layer in zero_count.keys():
    if zero_count[layer] < min_[1]:
        min_ = (layer, zero_count[layer])
fewest_label, _ = min_
print(count_digits(image[fewest_label], 1) * count_digits(image[fewest_label], 2))

for y in range(len(image[0])): 
    for x in range(len(image[0][0])):
        i = 0
        while image[i][y][x] == 2:
            i += 1
        image[0][y][x] = image[i][y][x]
print(numpy.array(image[0]))