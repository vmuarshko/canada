package com.skyfinancial1.canadamortgage.common;

import com.skyfinancial1.canadamortgage.CalcListActivity;
import com.skyfinancial1.canadamortgage.ContactListActivity;
import com.skyfinancial1.canadamortgage.HomeActivity;
import com.skyfinancial1.canadamortgage.NewsListActivity;
import com.skyfinancial1.canadamortgage.QuickAppActivity;
import com.skyfinancial1.canadamortgage.R;
import com.skyfinancial1.canadamortgage.RatesActivity;

import android.app.Activity;
import android.content.Intent;
import android.view.Menu;
import android.view.MenuItem;

public class MenuManager
{
	public static boolean prepareMainMenu(Menu menu, Activity activity)
	{		
		return true;
	}
	
	public static boolean handleMainMenu(MenuItem item, Activity activity)
	{
	    // Handle item selection
	    switch (item.getItemId()) 
	    {
	    case R.id.menu_rates:
	    {
			Intent intent = new Intent(activity, RatesActivity.class);
			activity.startActivity(intent);					
	    } break;
	    case R.id.menu_calculator:
	    {
	    	Intent intent = new Intent(activity, CalcListActivity.class);
	    	activity.startActivity(intent);
	    } break;
	    case R.id.menu_quick_app:
	    {
	    	Intent intent = new Intent(activity, QuickAppActivity.class);
	    	activity.startActivity(intent);
	    } break;
	    case R.id.menu_news:
	    {
	    	Intent intent = new Intent(activity, NewsListActivity.class);
	    	activity.startActivity(intent);
	    } break;
	    case R.id.menu_contacts:
	    {
	    	Intent intent = new Intent(activity, ContactListActivity.class);
	    	activity.startActivity(intent);
	    } break;
	    default:
	        return false;
	    }
        if (!activity.isTaskRoot())
        	activity.finish();
        return true;		
	}	
}
