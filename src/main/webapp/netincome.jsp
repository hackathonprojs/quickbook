<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.*" %>

<%@ page import="com.intuit.ipp.core.*" %>
<%@ page import="com.intuit.ipp.data.*" %>
<%@ page import="com.intuit.ipp.exception.*" %>
<%@ page import="com.intuit.ipp.security.*" %>
<%@ page import="com.intuit.ipp.services.*" %>

<%@ page import="me.xbt.common.*" %>

<%
		// get revenue report.  
		
		// get inputs
		String startdate = "2014-10-01"; // default value
		String enddate = "2014-10-20"; // default value
		if (request.getParameter("startdate") != null && !"".equals(request.getParameter("startdate"))) {
			startdate = request.getParameter("startdate");
		}
		if (request.getParameter("enddate") != null && !"".equals(request.getParameter("enddate"))) {
			enddate = request.getParameter("enddate");
		}
		

		String netIncome = "";
		
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
%>
<%=sNetIncome%>

