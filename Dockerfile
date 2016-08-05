FROM mono
ADD . /usr/src/app
RUN mcs /usr/src/app/Program.cs
EXPOSE 8080
CMD [ "mono", "/usr/src/app/SimplePingServer.exe" ]
