#!/bin/sh
set -eu
node --version
npm --version
python --version
python3 -m pip --version
python -m venv /tmp/check-venv
/tmp/check-venv/bin/python -m pip --version
/tmp/check-venv/bin/python -c 'import ssl, sqlite3, csv, json, zipfile; print("Python standard library OK")'
git --version
bash --version >/dev/null
curl --version >/dev/null
