package com.jencor1.mortgage;

import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class RatesActivity extends BaseActivity
{
//	private RatesXMLHandler handler = null;
//	
//	private ListView __list = null;
//	private ListView getListView()
//	{
//		if (__list == null)
//			__list = (ListView) findViewById(android.R.id.list);
//		return __list;
//	}		
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.rates);
     
        initDefaultControls();
        
		WebView webView = (WebView) findViewById(R.id.webView);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.setWebViewClient(new WebViewClient());
		webView.loadUrl("http://www.jencormortgage.com/jencor-rates-table-only/");
        
//        
//        
//        File dataFolder = CommonUtil.getFilesFolder(this);
//        File dataFile = new File(dataFolder, JMContactsData.RATES_FILE_NAME);
//        if (!dataFile.exists()) 
//        {  
//        	showErrorMessage(getString(R.string.error_rates_file_not_found));
//        	return;
//        }
//        
//        handler = new RatesXMLHandler();
//        try
//        {
//        	XMLDataReader.readFromXML(new FileInputStream(dataFile), handler); 
//        }
//        catch (Exception ex)
//        {
//        	showErrorMessage(ex.getLocalizedMessage());
//        }
//        
//        if (handler.lenderRates.size() > 0 && getListView() != null)
//        {
//        	getListView().setAdapter(new RatesAdapter());
//        }
    }
    
//    private final class RatesAdapter extends BaseAdapter
//    {
//
//		@Override
//		public int getCount()
//		{
//			return handler == null || handler.lenderRates == null ? null : handler.lenderRates.size();
//		}
//
//		@Override
//		public Object getItem(int position)
//		{
//			return handler == null || handler.lenderRates == null ? null : handler.lenderRates.get(position);
//		}
//
//		@Override
//		public long getItemId(int position)
//		{
//			return position;
//		}
//
//		@Override
//		public View getView(int position, View view, ViewGroup parent)
//		{
//			if (view == null)
//			{
//				view = LayoutInflater.from(RatesActivity.this).inflate(R.layout.rate_list_item, null);				
//			}
//			
//			RatesXMLHandler.LenderRate rate = handler.lenderRates.get(position);
//
//			TextView textRate = (TextView) view.findViewById(R.id.rate);
//			if (textRate != null)
//				textRate.setText(rate.ourRate + "%");
//			
//			TextView text1 = (TextView) view.findViewById(R.id.text1);
//			if (text1 != null)
//				text1.setText(rate.mortType);
//
//			TextView text2 = (TextView) view.findViewById(R.id.text2);
//			if (text2 != null)
//				text2.setText(rate.mortgageType);
//			
//			return view;
//		}
//    	
//    }

}
