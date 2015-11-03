package com.skyfinancial1.canadamortgage;

import com.skyfinancial1.canadamortgage.common.SFContactsData;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class HomeActivity extends SFBaseActivity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home);
     
        initDefaultControls();

        Button btnVisitWebsite = (Button) findViewById(R.id.btnVisitWebsite);
        if (btnVisitWebsite != null)
        {
        	btnVisitWebsite.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
		    		Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(SFContactsData.HOME_URL));
		    		startActivity(browserIntent);
				}
			});
        }

        Button btnInterestRates = (Button) findViewById(R.id.btnInterestRates);
        if (btnInterestRates != null)
        {
        	btnInterestRates.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
					Intent intent = new Intent(HomeActivity.this, RatesActivity.class);
					startActivity(intent);					
				}
			});
        }

        Button btnNews = (Button) findViewById(R.id.btnNews);
        if (btnNews != null)
        {
        	btnNews.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
					Intent intent = new Intent(HomeActivity.this, NewsListActivity.class);
					startActivity(intent);					
				}
			});
        }
        
        Button btnContact = (Button) findViewById(R.id.btnContact);
        if (btnContact != null)
        {
        	btnContact.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
					Intent intent = new Intent(HomeActivity.this, ContactListActivity.class);
					startActivity(intent);					
				}
			});
        }
        
        Button btnSkyBudget = (Button) findViewById(R.id.btnSkyBudget);
        if (btnSkyBudget != null)
        {
        	btnSkyBudget.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
		    		Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(SFContactsData.SKY_BUDGET_URL));
		    		startActivity(browserIntent);
				}
			});
        }
        
        Button btnQuickApp = (Button) findViewById(R.id.btnQuickApp);
        if (btnQuickApp != null)
        {
        	btnQuickApp.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
					Intent intent = new Intent(HomeActivity.this, QuickAppActivity.class);
					startActivity(intent);					
				}
			});
        }
        
        Button btnMortgageCalculators = (Button) findViewById(R.id.btnMortgageCalculators);
        if (btnMortgageCalculators != null)
        {
        	btnMortgageCalculators.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
					Intent intent = new Intent(HomeActivity.this, CalcListActivity.class);
					startActivity(intent);					
				}
			});
        }
    }

}
