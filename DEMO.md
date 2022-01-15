# Demonstration

To demonstrate the use of the control machine, we will setup a few containers representing machines of particular roles.  Each machine
will be a simple Docker container which allows ssh access and is not appropriate for use outside of the demo environment.

To start, let's build the base image for use by each machine.

```bash
cd ansiblecm/demo/machine

docker build --tag machine .
```

The resulting Docker image is a CentOS 7 machine with a single user allowing ssh access.  With the image, we will start a few web machines
and one database machine.

```bash
docker run -d --rm -p 22 -p 8080:8080 --name web1 machine
docker run -d --rm -p 22 -p 8081:8080 --name web2 machine
docker run -d --rm -p 22 -p 8082:8080 --name web3 machine
docker run -d --rm -p 22 -p 27017:27017 --name db1 machine

```

Each web machine will be running a web server, but at this point, it is not installed as verified by browsing to their exposed host port on [http://localhost:8080](http://localhost:8080)

The database machine will be running MongoDB, but at this point it is not installed yet as verified by browsing to its'
exposed host port on [http://localhost:27017](http://localhost:27017)


Now, let's update the **ansiblecm/demo/playbook/inventory** file with the virtual IPs of the 4 machines.  To obtain the IP of each machine
run the following:

```bash
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' web1
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' web2
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' web3
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db1

```


To demonstrate the use of an ansible one liner, let's install Java 8 on just the web machines.  Depending on your network speed
this could take 2 minutes or so.  The install will prompt you for the password of the centos user which is simply **centos**.

```bash
<<<<<<< HEAD
docker run -it --rm --entrypoint ansible -v $PWD/demo/playbook:/tmp/playbook:Z jmal98/ansiblecm:2.9.3 web -m yum -a 'name=java-1.8.0-openjdk-headless state=present'  -i inventory/hosts -u centos -k -b
=======
docker run -it --rm --entrypoint ansible -v $PWD/demo/playbook:/tmp/playbook:Z jmal98/ansiblecm:4.0.0 web -m yum -a 'name=java-1.8.0-openjdk-headless state=present'  -i inventory/hosts -u centos -k -b
>>>>>>> b5bd0f4e539d333fb14a4f07cb76e0892b46e838
```

To prove that java was installed on the web machines, let's run below which should show the version of java installed on web1.

```bash
docker exec -it web1 java -version
```

Now, let's invoke the full playbook which will install the web server and MongoDB on the machines.  Depending on your network speed
this could take 5 minutes or so.  Again, the execution of the playbook will prompt you for the password of the centos user which is **centos**.

```bash
docker run -it --rm -v $PWD/demo/playbook:/tmp/playbook:Z jmal98/ansiblecm:4.0.0 site.yml -i inventory/hosts -k
```

If all goes well the web machines will be running a web server, which is accessible via their exposed host ports.

* web1: [http://localhost:8080](http://localhost:8080)
* web1: [http://localhost:8081](http://localhost:8081)
* web1: [http://localhost:8082](http://localhost:8082)

Also, MongoDB should be up and it's status should be accessible via it's exposed host port [http://localhost:27017](http://localhost:27017)


That's it.  You just used the control machine to install a typical web stack with a NoSQL MongoDB database.  Feel free to play around
with the playbook and iterate changes on the machines.


When you're ready to shutdown the machines:

```bash
docker rm -fv web1 web2 web3 db1
```


Enjoy.
