package ca1.canadaguaranty;

import java.util.ArrayList;
import java.util.Locale;

import ca1.canadaguaranty.common.CGContactsData;
import ca1.canadaguaranty.common.CommonUtil;
import ca1.canadaguaranty.R;

import android.app.AlarmManager;
import android.content.Intent;
import android.os.Bundle;

public class SplashActivity extends BaseActivity 
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.splash);        
    }
    
    @Override
    protected void onStart()
    {
    	super.onStart();
    	
    	CommonUtil.loadDataFile(this, Locale.CANADA, CGContactsData.getResources(Locale.CANADA).NEWS_SOURCE_URL
    		, CGContactsData.NEWS_FILE_NAME, AlarmManager.INTERVAL_HALF_DAY);
    	CommonUtil.loadDataFile(this, Locale.CANADA_FRENCH, CGContactsData.getResources(Locale.CANADA_FRENCH).NEWS_SOURCE_URL
    		, CGContactsData.NEWS_FILE_NAME, AlarmManager.INTERVAL_HALF_DAY);

    	CommonUtil.loadDataFile(this, Locale.CANADA, CGContactsData.getResources(Locale.CANADA).NATIONAL_SALES_TEAM_URL
    		, CGContactsData.NATIONAL_SALES_TEAM_FILE_NAME, AlarmManager.INTERVAL_DAY);
    	CommonUtil.loadDataFile(this, Locale.CANADA_FRENCH, CGContactsData.getResources(Locale.CANADA_FRENCH).NATIONAL_SALES_TEAM_URL
    		, CGContactsData.NATIONAL_SALES_TEAM_FILE_NAME, AlarmManager.INTERVAL_DAY);

    	CommonUtil.loadDataFile(this, Locale.CANADA, CGContactsData.getResources(Locale.CANADA).PRODUCTS_URL
    		, CGContactsData.PRODUCTS_FILE_NAME, AlarmManager.INTERVAL_DAY);
    	CommonUtil.loadDataFile(this, Locale.CANADA_FRENCH, CGContactsData.getResources(Locale.CANADA_FRENCH).PRODUCTS_URL
    		, CGContactsData.PRODUCTS_FILE_NAME, AlarmManager.INTERVAL_DAY);
    }
    
    private ArrayList<String> loadedFiles = new ArrayList<String>();
    
	@Override
	public void onFileDownloadCompleted(final String sourceUrl, final String targetPath)
	{
		super.onFileDownloadCompleted(sourceUrl, targetPath);
		
		int counter = 0;
		synchronized (loadedFiles)
		{
			loadedFiles.add(targetPath);
			counter = loadedFiles.size();
		}
		
		if (counter >= 2)	// TODO: Update for more files
		{
	        handler.postDelayed(new Runnable()
			{			
				@Override
				public void run()
				{
					Intent intent = new Intent(SplashActivity.this, NewsListActivity.class);
					startActivity(intent);
					finish();			
				}
			}, 200);
		}
	}	    
}