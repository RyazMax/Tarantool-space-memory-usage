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

JSON_STRING = """
{
    "glossary": {
        "title": "example glossary",
		"GlossDiv": {
            "title": "S",
			"GlossList": {
                "GlossEntry": {
                    "ID": "SGML",
					"SortAs": "SGML",
					"GlossTerm": "Standard Generalized Markup Language",
					"Acronym": "SGML",
					"Abbrev": "ISO 8879:1986",
					"GlossDef": {
                        "para": "A meta-markup language, used to create markup languages such as DocBook.",
						"GlossSeeAlso": ["GML", "XML"]
                    },
					"GlossSee": "markup"
                }
            }
        }
    }
}
"""

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
            # To create int and string data.csv
            # res.append(''.join(random.choices(string.ascii_uppercase + string.digits, k=DEFAULT_STRING_LEN)))
            
            # To create int and json data.csv
            res.append(JSON_STRING)
        else:
            res.append(random.randint(0, DEFAULT_MAX_NUMBER))
    return res

with open(args.output, 'w') as output:
    writer = csv.writer(output, delimiter=',')
    for i in range(args.rows):
        writer.writerow(random_row(i, args.columns))


