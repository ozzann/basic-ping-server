FROM mono
ADD . /usr/src/app
WORKDIR /usr/src/app
RUN mcs SimplePingServer/Program.cs

CMD [ "mono", "SimplePingServer/Program.exe" ]

