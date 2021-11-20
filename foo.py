import urllib

import requests

query = {
    "email": "h20ms419@hirosaki-u.ac.jp",
    "guidetreeout": True,
    "dismatout": True,
    "dealign": False,
    "mbed": True,
    "mbediteration": True,
    "iterations": 0,
    "gtiterations": -1,
    "outfmt": "clustal_num",
    "order": "aligned",
}

with open("uniprot_test.fasta") as f:
    query["sequence"] = f.read()

content = urllib.parse.urlencode(query)
print(content)
base_url = "https://www.ebi.ac.uk/Tools/services/rest/clustalo"

res = requests.post(base_url, data=content, headers={"User-agent": "mochi-test-client"})
print(type(res))
print(res.headers)
print(res.url)
print(res.raw.read())
print(res.content)
