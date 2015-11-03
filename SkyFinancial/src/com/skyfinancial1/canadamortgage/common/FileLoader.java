package com.skyfinancial1.canadamortgage.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;

import com.skyfinancial1.canadamortgage.R;
import com.skyfinancial1.canadamortgage.SFBaseActivity;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Uri;
import android.os.AsyncTask;
import android.util.Log;

public class FileLoader
{
	private static final String LOG_TAG = "FileLoader"; 
	
	private static final int SERVER_CODE_OK = 200;
	
	private static final String TMP = ".tmp";

	private SFBaseActivity activity;
	
	private String sourceUrl;
	private String targetPath;
	
	private DownloadFileAsync loaderThread = null;
	
	public FileLoader(SFBaseActivity activity, final String sourceUrl, final String fileName)
	{
		this.activity = activity;
		this.sourceUrl = sourceUrl;
		
		File targetPathFile = new File(CommonUtil.getFilesFolder(activity), fileName);
		targetPath = targetPathFile.getPath();		
	}
	
	public void close()
	{
		if (loaderThread != null)
		{
			loaderThread.cancel(true);
			loaderThread = null;
		}
	}
	
	public void loadFileData()
	{
		loaderThread = new DownloadFileAsync();
		loaderThread.execute(sourceUrl, targetPath);
	}		
	
	// Async thread used to download server files
	private class DownloadFileAsync extends AsyncTask<String, String, String> 
	{				
    	private String sourceUrl; 
    	private String targetPath; 
		
        @Override
        protected void onPreExecute() 
        {
            super.onPreExecute();
            activity.progressMessage = activity.getString(R.string.loadind_file);
            activity.showDialog(SFBaseActivity.DIALOG_PROGRESS);
        }

        protected boolean loadFromNetwork(final String sourceUrl)
        {
            int count;
            boolean downloadSucceeded = false;
            
    		ConnectivityManager cm = (ConnectivityManager) activity.getApplicationContext()
			.getSystemService(Context.CONNECTIVITY_SERVICE);
			if (cm.getActiveNetworkInfo() != null) 
			{
				if (cm.getActiveNetworkInfo().isConnected())
				{					
		            try 
		            {            	            	
		    			HttpClient client = new DefaultHttpClient();    			
		    			HttpGet get = new HttpGet(sourceUrl);
		    			HttpResponse response = client.execute(get);
		    			
		                String targetFilePath = null;
		    			
		    			if (SERVER_CODE_OK == response.getStatusLine().getStatusCode())
		    			{              
	    	                targetFilePath = targetPath + TMP;
		    				
			                long lenghtOfFile = response.getEntity().getContentLength();
			
			                InputStream input = new BufferedInputStream(response.getEntity().getContent(), 8192);	                         
			                OutputStream output = new FileOutputStream(targetFilePath);
			
			                byte data[] = new byte[2048];
			
			                
			                while ((count = input.read(data)) != -1) 
			                {
			                    output.write(data, 0, count);
			                }
			
			                output.flush();
			                output.close();
			                input.close();
		
			                File targetFile = new File(targetFilePath);
			                
			                downloadSucceeded = targetFile.exists() ;//&& targetFile.length() == lenghtOfFile;
			                
			                if (downloadSucceeded)
			                {
			                	File oldFile = new File(targetPath);
			                	if (oldFile.exists())
			                		oldFile.delete();
			                	
			                	targetFile.renameTo(oldFile);
			                }
			            }
		            } 
		            catch (Exception e) 
		            {
		            	downloadSucceeded = false;
		            	Log.e("FileLoader", "loadFromNetwork", e);
		            }					
				}
			}			
			return downloadSucceeded;
        }
                
        @Override
        protected String doInBackground(String... aurl) 
        {
        	sourceUrl = aurl[0]; 
        	targetPath = aurl[1]; 
        	
        	loadFromNetwork(sourceUrl);
        	        	
        	return null;
        }
        
        @Override
        protected void onPostExecute(String unused) 
        {
        	if (activity != null && !activity.isFinishing() && activity.mProgressDialog != null && activity.mProgressDialog.isShowing())
        		activity.mProgressDialog.dismiss();
        	loaderThread = null;
        	
        	File dataFile = new File(targetPath);
        	if (dataFile.exists())
        	{
        		try
        		{
        			if (activity != null && !activity.isFinishing())
        				activity.onFileDownloadCompleted(sourceUrl, targetPath);
        		}
        		catch (Exception ex)
        		{
        			// Do nothing
        		}
        	}
        	else
        	{
        		Uri fileUri = Uri.parse(targetPath);
        		String fileName = fileUri.getLastPathSegment();
        		
				try
				{
					InputStream is = activity.getAssets().open("data/" + fileName);
					if (is != null)
					{
						if (CommonUtil.copyStreamToFile(is, dataFile))
						{
		        			if (activity != null && !activity.isFinishing())
		        				activity.onFileDownloadCompleted(sourceUrl, targetPath);														
						}
					}
				}
				catch (Exception ex)
				{
					Log.d(LOG_TAG, "loadDateFile from asset", ex);									
				}        		        		
        	}
        }
    }		
}
