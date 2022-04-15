FROM tomcat:latest
# Take the war and copy to webapps of tomcat
COPY /var/lib/jenkins/workspace/06/webapp/target/*.war /usr/local/tomcat/webapps/hello-world.war
