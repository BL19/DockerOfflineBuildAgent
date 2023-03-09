echo "> Setting up docker agent"
docker build -t dockeragent:latest .
echo ">> Creating diagnostics directory"
mkdir -p ./azp_diagnostics
