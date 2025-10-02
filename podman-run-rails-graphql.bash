podman build --no-cache --rm --file Containerfile.GraphQL --tag rails:graphql .
podman run --interactive --tty --publish 3000:3000 rails:graphql
echo "browse https://localhost:3000/graphql"
