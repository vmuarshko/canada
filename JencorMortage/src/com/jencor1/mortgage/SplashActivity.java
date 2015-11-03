package com.jencor1.mortgage;

import java.util.ArrayList;

import com.jencor1.mortgage.common.CommonUtil;
import com.jencor1.mortgage.common.JMContactsData;
import com.jencor1.mortgage.R;

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
    	
    	CommonUtil.loadDataFile(this, JMContactsData.BLOG_SOURCE_URL, JMContactsData.BLOG_FILE_NAME, CommonUtil.HOURS_12);
    	//CommonUtil.loadDataFile(this, JMContactsData.RATES_SOURCE_URL, JMContactsData.RATES_FILE_NAME, CommonUtil.HOURS_12);
    }
    
    private ArrayList<String> loadedFiles = new ArrayList<String>();
    
	@Override
	public void onFileDownloadCompleted(final String sourceUrl, final String targetPath)
	{
		super.onFileDownloadCompleted(sourceUrl, targetPath);
		
		loadedFiles.add(targetPath);
		
		if (loadedFiles.size() >= 1)
		{
	        handler.postDelayed(new Runnable()
			{			
				@Override
				public void run()
				{
					Intent intent = new Intent(SplashActivity.this, HomeActivity.class);
					startActivity(intent);
					finish();			
				}
			}, 500);
		}
	}	    
}