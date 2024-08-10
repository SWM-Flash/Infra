cd "$(dirname "$0")"
cd ../create_solution
pip3 install -r requirements.txt -t .
zip -r ../create_solution.zip .