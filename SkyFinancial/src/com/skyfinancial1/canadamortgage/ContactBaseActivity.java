package com.skyfinancial1.canadamortgage;

import com.skyfinancial1.canadamortgage.common.SFContactsData;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;

public class ContactBaseActivity extends SFBaseActivity
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
		    		Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(SFContactsData.TWITTER_ADDRESS));
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
		    		Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(SFContactsData.FACEBOOK_ADDRESS));
		    		startActivity(browserIntent);
				}
			});
    	}
    }
}
