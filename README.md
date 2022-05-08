# Python - Mod_Wsgi

This is the repo for running a python app under `mod_wsgi` on apache in a docker container

Many of the docker repo's out there use flask local server in their images. This repo use apache production ready server.

 * Download the repo
 * build the image: `docker build -t apache-flask .`
 * run container: `docker run -d -p 80:80 --name <name> apache-flask`
