# Embedded Jetty template application

This is a template for a web application that uses embedded Jetty. The sample code consists of a JSP (this page) and a simple servlet.

## Running the application locally

First build with:

    $mvn clean install

Then run it with:

    $java -cp target/classes:target/dependency/* com.example.Main
    or run Main.java from eclipse directly
    
## Usage

revenue from certain date to another date
http://localhost:8080/revenue.jsp?startdate=2014-09-01&enddate=2014-10-22

30 days revenue
http://localhost:8080/revenue30days.jsp
http://localhost:8080/revenue30days.jsp?refreshCache=1

