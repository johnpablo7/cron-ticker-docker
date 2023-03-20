docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t john1987/cron-ticker:latest --push .

docker buildx build --platform linux/amd64,linux/arm64 -t john1987/cron-ticker:oso --push .

docker buildx build --platform linux/amd64,linux/arm64 -t john1987/cron-ticker:gato --push .
