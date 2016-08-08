FROM mono
ADD . /usr/src/app
RUN mcs /usr/src/app/SimplePingServer/Program.cs

EXPOSE 9000
CMD [ "mono", "/usr/src/app/SimplePingServer/Program.exe" ]
