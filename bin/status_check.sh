status_ok() {
  curl -sSf $1 >/dev/null 2>&1
}

API_URL=${1:-"http://localhost:9393"}
# Check API is up

if status_ok "$API_URL"; then
  echo "[✔︎] API is up and running!"
else
  echo "[x] Timed out waiting for the server to be up."
  exit 1
fi

# Check user admin created
if status_ok "$API_URL/users/admin"; then
  echo "[✔︎] Admin user created"
else
  echo "[x] Admin user not created"
fi
# Check ontology imported
if status_ok "$API_URL/ontologies/STY"; then
  echo "[✔︎] Ontology STY imported"
else
  echo "[x] Ontology STY not imported"
fi

# Check ontology parsed
if status_ok "$API_URL/ontologies/STY/classes/http%3A%2F%2Fpurl.bioontology.org%2Fontology%2FSTY%2FT092"; then
  echo "[✔︎] Ontology parsed successfully"
else
  echo "[x] Ontology not parsed"
fi

# Check search
response=$(curl -s -w "\n%{http_code}" "http://localhost:9393/search?q=organization&ontologies=STY")
body=$(echo "$response" | sed '$d')
status=$(echo "$response" | tail -n 1)

total_count=$(echo "$body" | grep -o '"totalCount":[0-9]*' | grep -o '[0-9]*')

if [ "$status" = "200" ] && [ "$total_count" -eq 3 ]; then
  echo "[✔︎] Ontology search successful"
else
  echo "[x] Ontology search failed"
fi

# Check annotator
response=$(curl -s -w "\n%{http_code}" "http://localhost:9393/annotator?text=organization&ontologies=STY")
body=$(echo "$response" | sed '$d')
status=$(echo "$response" | tail -n 1)
annotated_class_exists=$(echo "$body" | grep -q '"annotatedClass"' && echo "yes" || echo "no")

if [ "$status" = "200" ] && [ "$annotated_class_exists" = "yes" ]; then
  echo "[✔︎] Ontology annotator successful"
else
  echo "[x] Ontology annotator failed"
fi
# Check mapping