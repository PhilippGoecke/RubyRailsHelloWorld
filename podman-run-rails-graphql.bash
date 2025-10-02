podman build --no-cache --rm -f Containerfile.GraphQL -t rails:graphql .
podman run --interactive --tty -p 3000:3000 rails:graphql
echo "browse https://localhost:3000/graphql"
