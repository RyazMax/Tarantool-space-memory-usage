import argparse
import csv
import random
import string

DEFAULT_ROWS = 10_000
DEFAULT_COLUMNS = 20
DEFAULT_OUTPUT_FILE = 'data.csv'
DEFAULT_STRING_LEN = 150
DEFAULT_MAX_NUMBER = 2 ** 32 - 1
DEFAULT_JSON_LEVEL_WIDTH = 3

parser = argparse.ArgumentParser(description='Generates csv with data for testing DBMS space usage')

parser.add_argument('--rows', type=int, dest='rows', default=DEFAULT_ROWS, help='Rows of data')
parser.add_argument('--cols', type=int, dest='columns', default=DEFAULT_COLUMNS, help='Columns of data')
parser.add_argument('-o', dest='output', default=DEFAULT_OUTPUT_FILE, help='Output csv file')

args = parser.parse_args()

# Generating
def random_row(i, columns):
    res = [i]
    for i in range(columns - 1):
        if i % 2 == 1:
            res.append(''.join(random.choices(string.ascii_uppercase + string.digits, k=DEFAULT_STRING_LEN)))
        else:
            res.append(random.randint(0, DEFAULT_MAX_NUMBER))
    return res

def random_json(lvl):
    if lvl == 0:
        return random.randint(0, DEFAULT_MAX_NUMBER)

    res = {}
    for i in range(DEFAULT_JSON_LEVEL_WIDTH):
        res['a' + i] = random_json(lvl - 1)
    return res

with open(args.output, 'w') as output:
    writer = csv.writer(output, delimiter=',')
    for i in range(args.rows):
        writer.writerow(random_row(i, args.columns))


