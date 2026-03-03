DB_HOST=localhost
DB_USERNAME=rails
DB_PASSWORD=secret
DB_NAME=blog

podman build --no-cache --rm --file Containerfile.Blog --tag rails:blog --build-arg DB_HOST=$DB_HOST --build-arg DB_USERNAME=$DB_USERNAME --build-arg DB_PASSWORD=$DB_PASSWORD --build-arg DB_NAME=$DB_NAME .
podman run --interactive --tty --publish 3002:3000 --env DB_HOST=$DB_HOST --env DB_USERNAME=$DB_USERNAME --env DB_PASSWORD=$DB_PASSWORD --env DB_NAME=$DB_NAME rails:blog
echo "browse https://localhost:3002/"
