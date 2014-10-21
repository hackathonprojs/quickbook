package me.xbt;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

public class RevenueServlet extends HttpServlet {

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ServletOutputStream out = resp.getOutputStream();
        
        String netIncome = "";
        try {
        	netIncome = getNetIncome();
        } catch (FMSException ex) {
        	ex.printStackTrace();
        }
        
        
        out.write(netIncome.getBytes());
        out.flush();
        out.close();
    }
	
	private String getNetIncome() throws FMSException {
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
 		rService.setStart_date("2014-10-01");
 		rService.setEnd_date("2014-10-20");
 		
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
 		
 		return sNetIncome;
        		
	}
    
}
