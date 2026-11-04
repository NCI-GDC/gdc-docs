import json

name = input("GraphQL query file: ")
out = name[:-5] + "_escaped.json"

with open(name, newline="") as f:
    query = f.read()

with open(out, "w", newline="") as f:
    f.write(json.dumps(query)[1:-1])

print(f"Saved to {out}")
