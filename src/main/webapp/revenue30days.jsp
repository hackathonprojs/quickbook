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

<%
String income20141022 = retrieveNetIncome("2014-10-21", "2014-10-22");
String income20141021 = retrieveNetIncome("2014-10-20", "2014-10-21");
String income20141020 = retrieveNetIncome("2014-10-19", "2014-10-20");
String income20141019 = retrieveNetIncome("2014-10-18", "2014-10-19");
String income20141018 = retrieveNetIncome("2014-10-17", "2014-10-18");
String income20141017 = retrieveNetIncome("2014-10-16", "2014-10-17");
String income20141016 = retrieveNetIncome("2014-10-15", "2014-10-16");
String income20141015 = retrieveNetIncome("2014-10-14", "2014-10-15");
String income20141014 = retrieveNetIncome("2014-10-13", "2014-10-14");
String income20141013 = retrieveNetIncome("2014-10-12", "2014-10-13");
String income20141012 = retrieveNetIncome("2014-10-11", "2014-10-12");
String income20141011 = retrieveNetIncome("2014-10-10", "2014-10-11");
String income20141010 = retrieveNetIncome("2014-10-09", "2014-10-10");
String income20141009 = retrieveNetIncome("2014-10-08", "2014-10-09");
String income20141008 = retrieveNetIncome("2014-10-07", "2014-10-08");
String income20141007 = retrieveNetIncome("2014-10-06", "2014-10-07");
String income20141006 = retrieveNetIncome("2014-10-05", "2014-10-06");
String income20141005 = retrieveNetIncome("2014-10-04", "2014-10-05");
String income20141004 = retrieveNetIncome("2014-10-03", "2014-10-04");
String income20141003 = retrieveNetIncome("2014-10-02", "2014-10-03");
String income20141002 = retrieveNetIncome("2014-10-01", "2014-10-02");
String income20141001 = retrieveNetIncome("2014-09-30", "2014-10-01");
String income20140930 = retrieveNetIncome("2014-09-29", "2014-09-30");
String income20140929 = retrieveNetIncome("2014-09-28", "2014-09-29");
String income20140928 = retrieveNetIncome("2014-09-27", "2014-09-28");
String income20140927 = retrieveNetIncome("2014-09-26", "2014-09-27");
String income20140926 = retrieveNetIncome("2014-09-25", "2014-09-26");
String income20140925 = retrieveNetIncome("2014-09-24", "2014-09-25");
String income20140924 = retrieveNetIncome("2014-09-23", "2014-09-24");
String income20140923 = retrieveNetIncome("2014-09-22", "2014-09-23");
String income20140922 = retrieveNetIncome("2014-09-21", "2014-09-22");
String income20140921 = retrieveNetIncome("2014-09-20", "2014-09-21");
%>

{
2014-10-22: <%=income20141022%>,
2014-10-21: <%=income20141021%>,
2014-10-20: <%=income20141020%>,
2014-10-19: <%=income20141019%>,
2014-10-18: <%=income20141018%>,
2014-10-17: <%=income20141017%>,
2014-10-16: <%=income20141016%>,
2014-10-15: <%=income20141015%>,
2014-10-14: <%=income20141014%>,
2014-10-13: <%=income20141013%>,
2014-10-12: <%=income20141012%>,
2014-10-11: <%=income20141011%>,
2014-10-10: <%=income20141010%>,
2014-10-09: <%=income20141009%>,
2014-10-08: <%=income20141008%>,
2014-10-07: <%=income20141007%>,
2014-10-06: <%=income20141006%>,
2014-10-05: <%=income20141005%>,
2014-10-04: <%=income20141004%>,
2014-10-03: <%=income20141003%>,
2014-10-02: <%=income20141002%>,
2014-10-01: <%=income20141001%>,
2014-09-30: <%=income20140930%>,
2014-09-29: <%=income20140929%>,
2014-09-28: <%=income20140928%>,
2014-09-27: <%=income20140927%>,
2014-09-26: <%=income20140926%>,
2014-09-25: <%=income20140925%>,
2014-09-24: <%=income20140924%>,
2014-09-23: <%=income20140923%>,
2014-09-22: <%=income20140922%>,
2014-09-21: <%=income20140921%>,
}

