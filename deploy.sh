docker build -t app . &> /dev/null
if [ $? -ne 0 ]; then
    echo 'Docker build failed'
    exit 1
fi

docker run -d -p 9000:9000 app
exit 0
