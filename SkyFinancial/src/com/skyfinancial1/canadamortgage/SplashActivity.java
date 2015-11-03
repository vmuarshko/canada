package com.skyfinancial1.canadamortgage;

import java.util.ArrayList;

import com.skyfinancial1.canadamortgage.common.CommonUtil;
import com.skyfinancial1.canadamortgage.common.SFContactsData;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.ImageView;

public class SplashActivity extends SFBaseActivity 
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.splash);
        
        ImageView imageLoadingIndicator = (ImageView) findViewById(R.id.imageLoadingIndicator);
        if (imageLoadingIndicator != null)
        {
        	Animation animation = AnimationUtils.loadAnimation(this, R.anim.rotate_loading);
        	imageLoadingIndicator.startAnimation(animation);
        }
    }
    
    @Override
    protected void onStart()
    {
    	super.onStart();
    	
    	CommonUtil.loadDataFile(this, SFContactsData.BLOG_SOURCE_URL, SFContactsData.BLOG_FILE_NAME, CommonUtil.HOURS_12);
    	CommonUtil.loadDataFile(this, SFContactsData.RATES_SOURCE_URL, SFContactsData.RATES_FILE_NAME, CommonUtil.HOURS_12);
    }
    
    private ArrayList<String> loadedFiles = new ArrayList<String>();
    
	public void onFileDownloadCompleted(final String sourceUrl, final String targetPath)
	{
		super.onFileDownloadCompleted(sourceUrl, targetPath);
		
		loadedFiles.add(targetPath);
		
		if (loadedFiles.size() >= 2)
		{
	        handler.postDelayed(new Runnable()
			{			
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