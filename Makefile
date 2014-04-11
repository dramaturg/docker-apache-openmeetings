
all:
	docker build -t dramaturg/apache-openmeetings .

run:
	docker run -d -t -i --name apache-openmeetings -p 5080:5080 -p 1935:1935 -p 8088:8088 dramaturg/apache-openmeetings

