FROM mono
ADD . /usr/src/app
WORKDIR /usr/src/app
RUN mcs SimplePingServer/Program.cs

EXPOSE 9000
CMD [ "mono", "SimplePingServer/Program.exe" ]

