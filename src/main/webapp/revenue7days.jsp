<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>

<%@ page import="com.intuit.ipp.core.*" %>
<%@ page import="com.intuit.ipp.data.*" %>
<%@ page import="com.intuit.ipp.exception.*" %>
<%@ page import="com.intuit.ipp.security.*" %>
<%@ page import="com.intuit.ipp.services.*" %>

<%@ page import="me.xbt.common.*" %>

<%!
private String retrieveNetIncome(String startdate, String enddate) {
	String sNetIncome = "";
	
	try {
		// get revenue report. 
		
        // following https://developer.intuit.com/docs/0025_quickbooksapi/0055_devkits/0201_ipp_java_devkit_3.0/0001_synchronous_calls/0001_data_service_apis
 		String consumerKey = AppInfo.consumerKey;
 		String consumerSecret = AppInfo.consumerSecret;
 		String accessToken = AppInfo.accessToken;
 		String accessTokenSecret = AppInfo.accessTokenSecret;

 		String appToken = AppInfo.appToken;
 		String companyID = AppInfo.companyID; // need to create a company in quickbook connect first.
 		
 		OAuthAuthorizer oauth = new OAuthAuthorizer(consumerKey, consumerSecret, accessToken, accessTokenSecret);
 		

 		Context context = new Context(oauth, appToken, ServiceType.QBO, companyID);
 		
 		ReportService rService = new ReportService(context);
 		rService.setAccounting_method("Accrual");
 		rService.setStart_date(startdate);
 		rService.setEnd_date(enddate);
 		
 		Report report = rService.executeReport(ReportName.CASHFLOW.toString());
 		
 		
 		System.out.println(report.getHeader());
 		ReportHeader header = report.getHeader();
 		System.out.println("header="+header.getReportName());
 		Columns columns = report.getColumns();
 		System.out.println("columns="+columns);
 		Rows rows = report.getRows();
 		System.out.println("rows="+rows);
 		List<Row> rowList = rows.getRow();
 		Row row0 = rowList.get(0); // first element
//     		System.out.println("group=" + row.getGroup());
//     		System.out.println("type=" + row.getType());
//     		System.out.println("ColData=" + row.getColData());
 		
 		
 		Rows rowsInsideRow0 = row0.getRows();
 		List<Row> rowListInsideRow0 = rowsInsideRow0.getRow();
 		Row netIncomeRow = rowListInsideRow0.get(0);
 		List<ColData> colData = netIncomeRow.getColData();
 		System.out.println(colData.get(0).getValue());
 		if (!"Net Income".equals(colData.get(0).getValue())) {
 			System.err.println("error: should return 'NetIncome', but instead got " + colData.get(0).getValue());
 		}
 		sNetIncome = colData.get(1).getValue();
 		System.out.println(sNetIncome);
 		
 		if ("".equals(sNetIncome)) {
 			sNetIncome = "0.00";
 		}
	} catch (Exception ex) {
		ex.printStackTrace();
	}
 
 	return sNetIncome;
}
%>

<%!
private String retrieveWithCache(String startdate, String enddate, boolean refreshCache) {
	String cachekey = startdate + ":" + enddate;
	String income = "0.00";
	System.out.println("refreshcache=" + refreshCache);
	// if refreshCache is on, always hit quickbook then store in cache.  
	if (refreshCache) {
		income = retrieveNetIncome(startdate, enddate);
		income = getDefault(income);
		Cache.revenues.put(cachekey, income);
	} else {
		// else hit cache first.  if not there, hit quickbook and store in cache.  
		income = Cache.revenues.get(cachekey);
		if (income == null) {
			income = retrieveNetIncome(startdate, enddate);
			income = getDefault(income);
			Cache.revenues.put(cachekey, income);
		}
		System.out.println("use cache");
	}
	
	return income;
}
%>

<%!
private String getDefault(String income) {
	return (income == null || "".equals(income)) ? "0.00" : income;
}
%>

<%
boolean refreshCache = false;
String sRefreshCache = request.getParameter("refreshCache");
if (sRefreshCache != null) {
	refreshCache = true;
}

String income20141021 = "8791.89";
String income20141020 = "8792.79";
String income20141019 = "3601.89";
String income20141018 = "3682.90";
String income20141017 = "4764.80";
String income20141016 = "5867.59";
String income20141015 = "5664.69";

try {
	income20141021 = retrieveNetIncome("2014-10-20", "2014-10-21");
	income20141020 = retrieveWithCache("2014-10-19", "2014-10-20", refreshCache);
	income20141019 = retrieveWithCache("2014-10-18", "2014-10-19", refreshCache);
	income20141018 = retrieveWithCache("2014-10-17", "2014-10-18", refreshCache);
	income20141017 = retrieveWithCache("2014-10-16", "2014-10-17", refreshCache);
	income20141016 = retrieveWithCache("2014-10-15", "2014-10-16", refreshCache);
	income20141015 = retrieveWithCache("2014-10-14", "2014-10-15", refreshCache);
} catch (Throwable ex) {
	ex.printStackTrace();
}
%>

[

{
	"day": 1,
	"revenue": <%=income20141015%>
},
{
	"day": 2,
	"revenue": <%=income20141016%>
},
{
	"day": 3,
	"revenue": <%=income20141017%>
},
{
	"day": 4,
	"revenue": <%=income20141018%>
},
{
	"day": 5,
	"revenue": <%=income20141019%>
},
{
	"day": 6,
	"revenue": <%=income20141020%>
},
{
	"day": 7,
	"revenue": <%=income20141021%>
}
]

