FROM mono
ADD . /usr/src/app
RUN mcs /usr/src/app/program.cs
EXPOSE 8080
CMD [ "mono", "/usr/src/app/program.exe" ]
