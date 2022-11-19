# Lab 12: Docker

Num: Lab12

## **Questions to answer**

1. Compare and contrast `ENTRYPOINT` and `CMD` in Dockerfile. In what situation would you use each of them?
    - Both of the instructions define commands that container executes when it launches not while image building as a `RUN`.
    - Both of them can be overriden in the same `Dockerfile` and also in the command line using flag `--entrypoint` for `ENTRYPOINT` and typing command after `docker run {image-name}` for `CMD`.
    
    - `**ENTRYPOINT**` defines an executable which is an entry point of the container. By default, it is the `/bin/sh -c`.
    
    - `**CMD**` defines arguments that will pass to an executable which is defined in `ENTRYPOINT`. So, when entrypoint is not specified its default value is `/bin/sh -c` then `CMD` can be any command that can be executed in `bin/sh`.
    
2. List five security precautions you will take when building or deploying a Docker resource (image or container).
    
    I didn’t understand whether we should get these precautions from the docker client while executing commands or from the Web. So, the following precautions are taken from [here](https://blog.aquasec.com/docker-security-best-practices\):
    
    - ****Keep Host and Docker Up to Date****: it is important to prevent known vulnerabilities that can help attackers harm not only the container, but also the host machine.
    - ****Do Not Expose the Docker Daemon Socket****:
        
        The Docker daemon socket is a Unix network socket that facilitates communication with the Docker API. By default, this socket is owned by the root user. If anyone else obtains access to the socket, they will have permissions equivalent to root access to the host.
        
        To avoid this issue, follow these best practices:
        
        - Never make the daemon socket available for remote connections, unless you are using Docker's encrypted HTTPS socket, which supports authentication.
        - Do not run Docker images with an option like `-v /var/run/docker.sock://var/run/docker.sock`, which exposes the socket in the resulting container.
    - ****Run Docker in Rootless Mode****:
        
        Docker provides “rootless mode”, which lets you run Docker daemons and containers as non-root users. This is extremely important to mitigate vulnerabilities in daemons and container runtimes, which can grant root access of entire nodes and clusters to an attacker.
        
        Rootless mode runs Docker daemons and containers within a user namespace. This is similar to the userns-remap mode, but unlike it, rootless mode runs daemons and containers without root privileges by default.
        
        To run Docker in rootless mode:
        
        1. Install Docker in root mode - see [instructions](https://docs.docker.com/engine/security/rootless/).
        2. Use the following command to launch the Daemon when the host starts: 
            
            ```bash
            $ systemctl --user enable docker
            $ sudo loginctl enable-linger $(whoami)
            ```
            
        3. Here is how to run a container as rootless using Docker context:
            
            ```bash
            $ docker context use rootless
            $ docker run -d -p 8080:80 nginx
            ```
            
    - ****Restrict System Calls from Within Containers****: In a container, you can choose to allow or deny any system calls. Not all system calls are required to run a container.
    - **Set Filesystem and Volumes to Read-only**:
        
        A simple and effective security trick is to run containers with a read-only filesystem. This can prevent malicious activity such as deploying malware on the container or modifying configuration.
        
        The following code sets a Docker container to read only:
        
        ```bash
        $ docker run --read-only alpine sh -c 'echo' "running as read only" > /tmp'
        ```
        
    - ****Limit Container Resources****: when a container is compromised, attackers may try to make use of the underlying host resources to perform malicious activity.
3. Show a single line command that will remove all exited Docker containers. Do not use any text filtering editor. Show test results.
    
    For the command `docker ps -a` we can add `-f` option to filter containers by status (e.g. exited): `docker ps -a -f status=exited`
    
    Then we can add `-q` option to obtain IDs of such containers.
    
    After that we simply remove them using `docker rm` and evaluating the expression of obtaining IDs of exited containers:
    
    ![Untitled](Lab%2012%20Docker%200baa8f3c809d42caa887dff3f44293c3/Untitled.png)
    
4. Show how you can copy files to a running container without entering the container’s interactive shell.
    
    We can do it using `docker cp` command that lets copy files from/to container to/from host machine
    
    ![Untitled](Lab%2012%20Docker%200baa8f3c809d42caa887dff3f44293c3/Untitled%201.png)
    
5. Create a dockerized web application running on nginx. The web index page `index.html` should be located on your host machine. The directory containing the index page should be mounted to the container and served from there.
    
    > This means that you should be able to modify the web index page on your host machine without interacting with the container. Show all steps taken for the configuration including the test results.
    > 
    - Firstly, we create a directory that will be mount to the container’s `usr/share/nginx/html` and the file `index.html` that will be used by nginx. Let’s create directory `app/` and simple `index.html` inside this directory:
        
        ```html
        <html>
        <h1>SNA HW</h1>
          <p>SNA rocks :)</p>
        </html>
        ```
        
        ![Untitled](Lab%2012%20Docker%200baa8f3c809d42caa887dff3f44293c3/Untitled%202.png)
        
    - We can use bind mount to mount the local directory to a container. For security reasons, we will make this directory read only for container. To do this we can run container using this command
        
        ```bash
        # contents of the file bind_mount.sh
        docker run -d \
          -it \
          --name ex5 \
          --mount type=bind,source="$(pwd)"/app,target=/usr/share/nginx/html,readonly \
          nginx:latest
        ```
        
        ![Untitled](Lab%2012%20Docker%200baa8f3c809d42caa887dff3f44293c3/Untitled%203.png)
        
    - That’s all, let’s run the script:
        
        ![Untitled](Lab%2012%20Docker%200baa8f3c809d42caa887dff3f44293c3/Untitled%204.png)
        
        ![Untitled](Lab%2012%20Docker%200baa8f3c809d42caa887dff3f44293c3/Untitled%205.png)
        
    - We can see that container’s file `usr/share/nginx/html/index.html` is exactly the same as `app/index.html` on our host machine.
    - Let’s change this file on our host machine and check result:
        
        ```html
        <html></html>
        ```
        
        ![Untitled](Lab%2012%20Docker%200baa8f3c809d42caa887dff3f44293c3/Untitled%206.png)
        
6. Setup rsyslog on your host machine as a central logging server. Create a Docker container and configure it to forward its log to your central logging server.
    
    > Show steps and test results.
    > 
    
    ### Not implemented
    

### **Bonus**

1. Dockerize any open source application of your choice, and host it on Docker hub. Share link to the repository.
    - [https://hub.docker.com/repository/docker/iskanred/inno-sna-course](https://hub.docker.com/repository/docker/iskanred/inno-sna-course)
    
    The script that is used on container start:
    
    ```bash
    #!bin/bash
    
    echo "Hello! The container is started successfully!"
    echo "Let's count to 5 and it will stop."
    
    COUNT_MAX=5
    counter=0
    
    while sleep 1
    do 
        if [[ $counter == $COUNT_MAX ]]
        then
            break
        fi
    
        echo $(($counter + 1))
        ((counter++))
    done
    
    echo "Bye, bye!"
    ```
    
2. Find and fix the problems in the following Dockerfile. There are some issues building the image and also running the container:
    
    ```docker
    FROM alpine
    RUN apt-get update && apt-get install -y python3 --no-install-recommends
    RUN touch index.html
    RUN echo "<html><h1>Testing web</h1></html>" >> index.html
    CMD ["python", "-m", "http.server"]
    ```
    
    > Show all steps taken to fix it, and a working solution.
    > 
    - Firstly, apline distributive has a default package manages named `apk` not `apt-get`. Therefore, RUN layer and buidling the image cannot be executed successfully.
        
        ```docker
        FROM alpine
        RUN apk update && apk install python3
        RUN touch index.html
        RUN echo "<html><h1>Testing web</h1></html>" >> index.html
        CMD ["python", "-m", "http.server"]
        ```
        
    - Then we see that we install python3 package that provides us `python3` executable. But in the `Dockerfile` we use `python` executable. Let’s fix it:
        
        ```docker
        FROM alpine
        RUN apk update && apk add python3
        RUN touch index.html
        RUN echo "<html><h1>Testing web</h1></html>" >> index.html
        CMD ["python3", "-m", "http.server"]
        ```
        
    - From here the container works successfully and server starts. However, we may need to obtain it from host machine. To do this let’s expose the ports:
        
        ```docker
        FROM alpine
        RUN apk update && apk add python3
        RUN touch index.html
        RUN echo "<html><h1>Testing web</h1></html>" >> index.html
        EXPOSE 8000
        CMD ["python3", "-m", "http.server"]
        ```
        
        > We know that by default http.server uses port 8000
        > 
    - And one more minor fix. It’s better to use `ENTRYPOINT` in this case instead of `CMD` because the command is an executable that will run until stopping the container:
        
        ```docker
        # FINAL VERSION
        FROM alpine
        RUN apk update && apk add python3
        RUN touch index.html
        RUN echo "<html><h1>Testing web</h1></html>" >> index.html
        EXPOSE 8000
        ENTRYPOINT ["python3", "-m", "http.server"]
        ```
        
    - Now we can finally build and run it:
        
        ```bash
        $ docker build -t ex8:latest .
        $ docker run -p 80:8000 -d --name ex8-container ex8
        ```
        
        ![Untitled](Lab%2012%20Docker%200baa8f3c809d42caa887dff3f44293c3/Untitled%207.png)
        
    - Now we can easily obtain the page from host machine:
        
        ```bash
        $ curl localhost:80
        ```
        
        ![Untitled](Lab%2012%20Docker%200baa8f3c809d42caa887dff3f44293c3/Untitled%208.png)
        
-