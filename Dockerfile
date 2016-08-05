FROM mono:last
ADD . /home/anna/csharp-app
RUN mcs /home/anna/csharp-app/program.cs
CMD [ "mono", "home/anna/csharp-app/program.exe" ]
RUN /bin/bash -c "source test_ping_server_app.sh"
