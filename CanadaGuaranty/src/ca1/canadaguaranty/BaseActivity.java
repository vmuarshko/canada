package ca1.canadaguaranty;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Bundle;
import android.os.Handler;
import android.text.TextUtils;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import ca1.canadaguaranty.R;

public abstract class BaseActivity extends Activity implements OnClickListener
{
	public static final int DIALOG_ERROR = 0;
	public static final int DIALOG_PROGRESS = 1;

	public static final int DIALOG_USER = 100;
	
	public String lastErrorMessage;	
	public String progressMessage;
	
	protected enum MenuBarItem
	{
		News(R.id.btnMenuNews, R.drawable.icon_news_inactive, R.drawable.icon_news_active
			, R.drawable.banner_news, NewsListActivity.class)
		, Products(R.id.btnMenuProducts, R.drawable.icon_products_inactive, R.drawable.icon_products_active
			, R.drawable.banner_products, ProductListActivity.class)
		, Calculators(R.id.btnMenuCalculators, R.drawable.icon_calc_inactive, R.drawable.icon_calc_active
			, R.drawable.banner_calc, CalculatorListActivity.class)
		, Email(R.id.btnMenuEmail, R.drawable.icon_email_inactive, R.drawable.icon_email_active
			, R.drawable.banner_email, NewsletterActivity.class)
		, Contacts(R.id.btnMenuContact, R.drawable.icon_contact_inactive, R.drawable.icon_contact_active
			, R.drawable.banner_contact, ContactsActivity.class)
		;
		
		private final int btnId;
		private final int inactiveImage;
		private final int activeImage;
		private final int bannerImage;
		private final Class<?> activityToCall;
				
		MenuBarItem(final int btnId, final int inactiveImage, final int activeImage, final int bannerImage,
			final Class<?> activityToCall)
		{
			this.btnId = btnId;
			this.inactiveImage = inactiveImage;
			this.activeImage = activeImage;
			this.bannerImage = bannerImage;
			this.activityToCall = activityToCall;
		}
		
		public int getBtnId() { return btnId; }		
		public int getInactiveImage() { return inactiveImage; }
		public int getActiveImage() { return activeImage; }
		public int getBannerImage() { return bannerImage; }
		public Class<?> getActivityToCall() { return activityToCall; }

		
		public static MenuBarItem findByBanner(int bannerId)
		{
			for (MenuBarItem i: MenuBarItem.values())
			{
				if (i.bannerImage == bannerId)
					return i;
			}			
			return null;
		}
	}
	
	protected Handler handler = new Handler();

	public ProgressDialog mProgressDialog;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        
        progressMessage = getString(R.string.please_wait);        
    }
    
    protected void initDefaultControls()
    {
		for (MenuBarItem item: MenuBarItem.values())
		{
    		Button btn = (Button) findViewById(item.getBtnId());
    		if (btn != null) btn.setOnClickListener(this);			
		}    	
		Button btnBack = (Button) findViewById(R.id.btnBack);
		if (btnBack != null)
		{
			btnBack.setOnClickListener(new OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
					finish();					
				}
			});
		}						
    }
    
    protected void enableBackButton(boolean enable)
    {
		Button btnBack = (Button) findViewById(R.id.btnBack);
		if (btnBack != null)
		{
			btnBack.setVisibility(enable ? View.VISIBLE : View.GONE);
		}
    }
    
    protected void senMenuBarActiveButton(MenuBarItem item)
    {
    	for (MenuBarItem i: MenuBarItem.values())
    	{
    		Button btn = (Button) findViewById(i.getBtnId());
    		if (btn != null)
    		{
    			if (item != null && i.equals(item))
    			{
    				btn.setCompoundDrawablesWithIntrinsicBounds(0, i.getActiveImage(), 0, 0);
    				btn.setBackgroundResource(R.drawable.menu_btn_active);
    				btn.setTextColor(getResources().getColor(R.color.menu_btn_active_text));
    			}
    			else
    			{
    				btn.setCompoundDrawablesWithIntrinsicBounds(0, i.getInactiveImage(), 0, 0);
    				btn.setBackgroundResource(R.drawable.menu_btn_inactive);
    				btn.setTextColor(getResources().getColor(R.color.menu_btn_inactive_text));
    			}
    		}
    	}
    }

    protected void setPageTitle(final String title)
    {
    	TextView textViewTitle = (TextView) findViewById(R.id.textViewTitle);
    	if (textViewTitle != null)
    		textViewTitle.setText(title);
    }
    
    @Override
    protected void onStart()
    {
    	super.onStart();
    	TextView textViewTitle = (TextView) findViewById(R.id.textViewTitle);
    	ImageView imageViewBanner = (ImageView) findViewById(R.id.imageViewBanner);
    	if (textViewTitle != null && imageViewBanner != null)
    	{
    		try
			{
				ActivityInfo info = getPackageManager().getActivityInfo(this.getComponentName(), 0);
				if (info.labelRes != 0 && TextUtils.isEmpty(textViewTitle.getText()))
				{
					textViewTitle.setText(getString(info.labelRes));
				}
				if (info.icon != 0)
				{
					imageViewBanner.setImageResource(info.icon);
					senMenuBarActiveButton(MenuBarItem.findByBanner(info.icon));
				}				
			} 
    		catch (NameNotFoundException e)
			{
			}    		
    	}		    	
    }
    
    @Override
    protected void onResume()
    {    	    	
    	super.onResume();    	
    	
		if (mProgressDialog != null)
			mProgressDialog.dismiss();
		
    }
    
	/*@Override
	public boolean onCreateOptionsMenu(Menu menu) 
	{
	    MenuInflater inflater = getMenuInflater();
	    inflater.inflate(R.menu.main_menu, menu);
	    return true;
	}
	
	@Override
	public boolean onPrepareOptionsMenu (Menu menu)
	{
		return MenuManager.prepareMainMenu(menu, this);
	}
	
	@Override
	public boolean onOptionsItemSelected(MenuItem item) 
	{
		if (!MenuManager.handleMainMenu(item, this))
	        return super.onOptionsItemSelected(item);
		else
			return true;
	}*/
    
	@Override
	protected Dialog onCreateDialog(int id) 
	{
	    Dialog dialog = null;
	    switch(id) 
	    {
		    case DIALOG_ERROR:
		    {
		    	AlertDialog.Builder builder = new AlertDialog.Builder(this);
		    	builder.setMessage(lastErrorMessage)
		    	       .setCancelable(false)
		    	       .setPositiveButton(getResources().getString(R.string.button_ok), new DialogInterface.OnClickListener() {
		    	        @Override
						public void onClick(DialogInterface dialog, int id) {
		    	                dialog.dismiss();
		    	           }
		    	       });
		    	dialog = builder.create();	    	
		    } break;
		    case DIALOG_PROGRESS:
		    {
		    	mProgressDialog = new ProgressDialog(this);
		    	mProgressDialog.setMessage(progressMessage);
		    	mProgressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
		    	mProgressDialog.setCancelable(true);
		    	mProgressDialog.show();
		    	return mProgressDialog;
		    } 
	    }
	    return dialog;
	}

	@Override
	protected void onPrepareDialog(int dialogId, Dialog dialog)
	{
	    switch(dialogId) 
	    {
		    case DIALOG_ERROR:
		    {
		    	((AlertDialog)dialog).setMessage(lastErrorMessage);
		    } break;    
		    case DIALOG_PROGRESS:
		    {
		    	if (mProgressDialog != null)
		    	{
		    		mProgressDialog.setMessage(progressMessage);
		    	}
		    } 
	    }	
	}
	
	public void showErrorMessage(final String message)
	{
		lastErrorMessage = message;
		showDialog(DIALOG_ERROR);
	}
	
	public void onFileDownloadCompleted(final String sourceUrl, final String targetPath)
	{
		if (mProgressDialog != null)
			mProgressDialog.dismiss();		
	}

	@Override
	public void onClick(View v)
	{
		Class<?> activityToCall = null;
		for (MenuBarItem item: MenuBarItem.values())
		{
			if (v.getId() == item.getBtnId())
			{
				activityToCall = item.getActivityToCall();
			}
		}
		
		if (activityToCall != null)
		{
			final Intent intent = new Intent(this, activityToCall);
			startActivity(intent);
			finish();
		}
	}	

}
