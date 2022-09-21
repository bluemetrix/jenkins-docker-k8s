FROM httpd:latest

COPY ./Webpage/home.html /usr/local/apache2/htdocs/

COPY ./Webpage/docker-to-kube.png /usr/local/apache2/htdocs/
