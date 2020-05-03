FROM tomcat:9.0.20-jre8
MAINTAINER anurag.junghare@gmail.com
ENV dbDriver=com.mysql.jdbc.Driver dbConnectionUrl=jdbc:mysql://my-mysql:3306/cicd dbUserName=root dbPassword=password
COPY target/UserLogin.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
