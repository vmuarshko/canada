package com.skyfinancial1.canadamortgage;

import android.os.Bundle;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class RatesActivity extends SFBaseActivity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.rates);
     
        
        initDefaultControls();
		WebView webview = (WebView) findViewById(R.id.webView);
		webview.setWebViewClient(new WebViewClient());
		webview.setWebChromeClient(new WebChromeClient());
		webview.loadUrl("http://www.mortgagecentreedmonton.com/mortgage-app/");
		
//		webview.getSettings().setLoadWithOverviewMode(true);
//		webview.getSettings().setUseWideViewPort(true);
		
//		webview.setInitialScale(5);
//		webview.getSettings().setLoadWithOverviewMode(true);
//		webview.getSettings().setUseWideViewPort(true);
//		webview.getSettings().setJavaScriptEnabled(true);
        
//        File dataFolder = CommonUtil.getFilesFolder(this);
//        File dataFile = new File(dataFolder, SFContactsData.RATES_FILE_NAME);
//        if (!dataFile.exists()) 
//        {  
//        	showErrorMessage(getString(R.string.error_rates_file_not_found));
//        	return;
//        }
//        
//        RatesXMLHandler handler = new RatesXMLHandler();
//        try
//        {
//        	XMLDataReader.readFromXML(new FileInputStream(dataFile), handler); 
//        }
//        catch (Exception ex)
//        {
//        	showErrorMessage(ex.getLocalizedMessage());
//        }
//        
//        TableLayout layoutRates = (TableLayout) findViewById(R.id.tableLayoutRates);
//        if (handler.lenderRates.size() > 0 && layoutRates != null)
//        {
//        	int startId = R.id.tableRowHeader + 1;
//        	for (RatesXMLHandler.LenderRate rate: handler.lenderRates)
//        	{
//        		TableRow tableRow = new TableRow(this);
//        		tableRow.setId(startId++);
//        		
//        		TableRow.LayoutParams rowParams = new TableRow.LayoutParams(
//                        LayoutParams.FILL_PARENT,
//                        LayoutParams.WRAP_CONTENT);
//        		tableRow.setLayoutParams(rowParams);
//        		tableRow.setPadding(5, 8, 5, 8);
//        		
//        		TextView text1 = new TextView(this);
//        		text1.setId(startId++);
//        		text1.setText(rate.mortType);
//        		text1.setTextAppearance(this, android.R.attr.textAppearanceMedium);
//        		text1.setLayoutParams(new TableRow.LayoutParams(
//                        LayoutParams.FILL_PARENT,
//                        LayoutParams.WRAP_CONTENT));
//        		tableRow.addView(text1);
//        		
//        		TextView text2 = new TextView(this);
//        		text2.setId(startId++);
//        		text2.setText(rate.ourRate + "%");
//        		text2.setTextAppearance(this, android.R.attr.textAppearanceMedium);
//        		text2.setTypeface(null, Typeface.BOLD);
//        		text2.setLayoutParams(new TableRow.LayoutParams(
//                        LayoutParams.FILL_PARENT,
//                        LayoutParams.WRAP_CONTENT));
//        		tableRow.addView(text2);
//        		
//        		layoutRates.addView(tableRow, new TableRow.LayoutParams(
//                        LayoutParams.FILL_PARENT,
//                        LayoutParams.WRAP_CONTENT));
//        	}
//        }
    }

}
