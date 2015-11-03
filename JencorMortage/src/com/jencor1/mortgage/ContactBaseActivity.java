package com.jencor1.mortgage;

import com.jencor1.mortgage.common.JMContactsData;
import com.jencor1.mortgage.R;

import android.content.Intent;
import android.net.Uri;
import android.view.View;
import android.widget.ImageView;

public class ContactBaseActivity extends BaseActivity
{
    @Override
    protected void initDefaultControls()
    {
    	super.initDefaultControls();
    	
    	ImageView btnTwitter = (ImageView) findViewById(R.id.btnTwitter);
    	if (btnTwitter != null)
    	{
    		btnTwitter.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
		    		Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(JMContactsData.TWITTER_ADDRESS));
		    		startActivity(browserIntent);
				}
			});
    	}
    	
    	ImageView btnFacebook = (ImageView) findViewById(R.id.btnFacebook);
    	if (btnFacebook != null)
    	{
    		btnFacebook.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
		    		Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(JMContactsData.FACEBOOK_ADDRESS));
		    		startActivity(browserIntent);
				}
			});
    	}
    }
}
