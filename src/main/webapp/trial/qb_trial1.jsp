<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.intuit.ipp.core.*" %>
<%@ page import="com.intuit.ipp.data.*" %>
<%@ page import="com.intuit.ipp.security.*" %>
<%@ page import="com.intuit.ipp.services.*" %>
<%
// following https://developer.intuit.com/docs/0025_quickbooksapi/0055_devkits/0201_ipp_java_devkit_3.0/0001_synchronous_calls/0001_data_service_apis
String consumerKey = "qyprdjjxjhvmRvpAfaYgHfbVsbz1KH";
String consumerSecret = "mf8ASlocS1DjsZKmThXdWiHkHao81dAvz1TMWZYR";
String accessToken = "qyprdZfe92xmLpx1IiOKvIVIb39oGXMChsO34csqoIGyzgWH";
String accessTokenSecret = "mcSpZrugBMCtBh1hAAFQOhMONsqJTLgk5g1XVPcv";

OAuthAuthorizer oauth = new OAuthAuthorizer(consumerKey, consumerSecret, accessToken, accessTokenSecret);

String appToken = "1b868c6cb467eb4abeba8bab22a839a6fe0e";
String companyID = "1291602300"; // need to create a company in quickbook connect first.

Context context = new Context(oauth, appToken, ServiceType.QBO, companyID);

DataService service = new DataService(context);

Customer customer=new Customer();
customer.setId("1");
//customer.setDisplayName("Mary");

//Customer resultCustomer = service.add(customer);

Customer resultCustomer = service.findById(customer);

System.out.println(resultCustomer);
System.out.println(resultCustomer.getFullyQualifiedName());

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Insert title here</title>
</head>
<body>



</body>
</html>