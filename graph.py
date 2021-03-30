graph = []

for i in range(0, 100):
    graph.append([])
    for j in range(0, 100):
        if i == j:
            graph[i].append('/')
        else:
            graph[i].append(' ')

for row in reversed(graph):
    print(''.join(row))