import csv
from matplotlib import pyplot as plt
import numpy as np

rows = []
mysql = []
psql = []
tarantool = []

with open('graph.csv', 'r') as file:
    reader = csv.reader(file)
    next(reader, None)
    for row in reader:
        rows.append(row[0])
        mysql.append(row[1])
        psql.append(row[2])
        tarantool.append(row[3])

rows = np.array(rows)
mysql = np.array(mysql, dtype=float) / 1024 ** 2
psql = np.array(psql, dtype=float) / 1024 ** 2
tarantool = np.array(tarantool, dtype=float) / 1024 ** 2

plt.plot(rows, tarantool)
plt.plot(rows, mysql)
plt.plot(rows, psql)

plt.legend(['Tarantool', 'MySQL', 'PostgreSQL'])
plt.xlabel("Rows")
plt.ylabel("Size(MB)")

plt.show()