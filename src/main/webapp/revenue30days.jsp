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
private String retrieveNetIncome(String startdate, String enddate) throws FMSException {
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
 		String sNetIncome = colData.get(1).getValue();
 		System.out.println(sNetIncome);
 		
 		if ("".equals(sNetIncome)) {
 			sNetIncome = "0.00";
 		}
 
 		return sNetIncome;
}
%>

<%!
private String retrieveWithCache(String startdate, String enddate, boolean refreshCache) throws FMSException {
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

String income20141022 = retrieveWithCache("2014-10-21", "2014-10-22", refreshCache);
String income20141021 = retrieveWithCache("2014-10-20", "2014-10-21", refreshCache);
String income20141020 = retrieveWithCache("2014-10-19", "2014-10-20", refreshCache);
String income20141019 = retrieveWithCache("2014-10-18", "2014-10-19", refreshCache);
String income20141018 = retrieveWithCache("2014-10-17", "2014-10-18", refreshCache);
String income20141017 = retrieveWithCache("2014-10-16", "2014-10-17", refreshCache);
String income20141016 = retrieveWithCache("2014-10-15", "2014-10-16", refreshCache);
String income20141015 = retrieveWithCache("2014-10-14", "2014-10-15", refreshCache);
String income20141014 = retrieveWithCache("2014-10-13", "2014-10-14", refreshCache);
String income20141013 = retrieveWithCache("2014-10-12", "2014-10-13", refreshCache);
String income20141012 = retrieveWithCache("2014-10-11", "2014-10-12", refreshCache);
String income20141011 = retrieveWithCache("2014-10-10", "2014-10-11", refreshCache);
String income20141010 = retrieveWithCache("2014-10-09", "2014-10-10", refreshCache);
String income20141009 = retrieveWithCache("2014-10-08", "2014-10-09", refreshCache);
String income20141008 = retrieveWithCache("2014-10-07", "2014-10-08", refreshCache);
String income20141007 = retrieveWithCache("2014-10-06", "2014-10-07", refreshCache);
String income20141006 = retrieveWithCache("2014-10-05", "2014-10-06", refreshCache);
String income20141005 = retrieveWithCache("2014-10-04", "2014-10-05", refreshCache);
String income20141004 = retrieveWithCache("2014-10-03", "2014-10-04", refreshCache);
String income20141003 = retrieveWithCache("2014-10-02", "2014-10-03", refreshCache);
String income20141002 = retrieveWithCache("2014-10-01", "2014-10-02", refreshCache);
String income20141001 = retrieveWithCache("2014-09-30", "2014-10-01", refreshCache);
String income20140930 = retrieveWithCache("2014-09-29", "2014-09-30", refreshCache);
String income20140929 = retrieveWithCache("2014-09-28", "2014-09-29", refreshCache);
String income20140928 = retrieveWithCache("2014-09-27", "2014-09-28", refreshCache);
String income20140927 = retrieveWithCache("2014-09-26", "2014-09-27", refreshCache);
String income20140926 = retrieveWithCache("2014-09-25", "2014-09-26", refreshCache);
String income20140925 = retrieveWithCache("2014-09-24", "2014-09-25", refreshCache);
String income20140924 = retrieveWithCache("2014-09-23", "2014-09-24", refreshCache);
String income20140923 = retrieveWithCache("2014-09-22", "2014-09-23", refreshCache);
String income20140922 = retrieveWithCache("2014-09-21", "2014-09-22", refreshCache);
String income20140921 = retrieveWithCache("2014-09-20", "2014-09-21", refreshCache);
%>

[
{
	day: 0,
	revenue: <%=income20140921%>,
},
{
	day: 1,
	revenue: <%=income20140922%>,
},
{
	day: 2,
	revenue: <%=income20140923%>,
},
{
	day: 3,
	revenue: <%=income20140924%>,
},
{
	day: 4,
	revenue: <%=income20140925%>,
},
{
	day: 5,
	revenue: <%=income20140926%>,
},
{
	day: 6,
	revenue: <%=income20140927%>,
},
{
	day: 7,
	revenue: <%=income20140928%>,
},
{
	day: 8,
	revenue: <%=income20140929%>,
},
{
	day: 9,
	revenue: <%=income20140930%>,
},
{
	day: 10,
	revenue: <%=income20141001%>,
},
{
	day: 11,
	revenue: <%=income20141002%>,
},
{
	day: 12,
	revenue: <%=income20141003%>,
},
{
	day: 13,
	revenue: <%=income20141004%>,
},
{
	day: 14,
	revenue: <%=income20141005%>,
},
{
	day: 15,
	revenue: <%=income20141006%>,
},
{
	day: 16,
	revenue: <%=income20141007%>,
},
{
	day: 17,
	revenue: <%=income20141008%>,
},
{
	day: 18,
	revenue: <%=income20141009%>,
},
{
	day: 19,
	revenue: <%=income20141010%>,
},
{
	day: 20,
	revenue: <%=income20141011%>,
},
{
	day: 21,
	revenue: <%=income20141012%>,
},
{
	day: 22,
	revenue: <%=income20141013%>,
},
{
	day: 23,
	revenue: <%=income20141014%>,
},
{
	day: 24,
	revenue: <%=income20141015%>,
},
{
	day: 25,
	revenue: <%=income20141016%>,
},
{
	day: 26,
	revenue: <%=income20141017%>,
},
{
	day: 27,
	revenue: <%=income20141018%>,
},
{
	day: 28,
	revenue: <%=income20141019%>,
},
{
	day: 29,
	revenue: <%=income20141020%>,
},
{
	day: 30,
	revenue: <%=income20141021%>,
},
]

