docker run -d \
  -it \
  --name ex5 \
  --mount type=bind,source="$(pwd)"/app,target=/usr/share/nginx/html,readonly \
  nginx:latest

