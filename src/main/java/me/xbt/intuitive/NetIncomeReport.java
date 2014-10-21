package me.xbt.intuitive;

import java.util.List;

import me.xbt.common.AppInfo;

import com.intuit.ipp.core.Context;
import com.intuit.ipp.core.ServiceType;
import com.intuit.ipp.data.ColData;
import com.intuit.ipp.data.Columns;
import com.intuit.ipp.data.Report;
import com.intuit.ipp.data.ReportHeader;
import com.intuit.ipp.data.Row;
import com.intuit.ipp.data.Rows;
import com.intuit.ipp.exception.FMSException;
import com.intuit.ipp.security.OAuthAuthorizer;
import com.intuit.ipp.services.ReportName;
import com.intuit.ipp.services.ReportService;



/**
 * get netincome from cashflow report
 * @author t
 *
 */
public class NetIncomeReport {
	
	public static String retrieveNetIncome(String startdate, String enddate) throws FMSException {
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

}
