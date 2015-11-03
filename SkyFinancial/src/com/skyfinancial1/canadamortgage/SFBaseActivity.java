package com.skyfinancial1.canadamortgage;

import com.skyfinancial1.canadamortgage.common.MenuManager;

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
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

public class SFBaseActivity extends Activity
{
	public static final int DIALOG_ERROR = 0;
	public static final int DIALOG_PROGRESS = 1;

	public static final int DIALOG_USER = 100;
	
	public String lastErrorMessage;	
	public String progressMessage;
	
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
    	ImageView btnHome = (ImageView) findViewById(R.id.btnHome);
    	if (btnHome != null)
    	{
    		btnHome.setOnClickListener(new View.OnClickListener()
			{				
				@Override
				public void onClick(View v)
				{
		    		Intent intent = new Intent(SFBaseActivity.this, HomeActivity.class);
		    		startActivity(intent);
		    		finish();
				}
			});
    	}
    }
    
    @Override
    protected void onResume()
    {    	    	
    	super.onResume();    	
    	
		if (mProgressDialog != null)
			mProgressDialog.dismiss();
		
    	TextView textHeaderTitle = (TextView) findViewById(R.id.textViewSubheader);
    	if (textHeaderTitle != null)
    	{
    		try
			{
				ActivityInfo info = getPackageManager().getActivityInfo(this.getComponentName(), 0);
				if (info.labelRes != 0)
				{
					textHeaderTitle.setText(getString(info.labelRes));
				}
			} 
    		catch (NameNotFoundException e)
			{
			}    		
    	}		
    }
    
	@Override
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
	}
    
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

}
