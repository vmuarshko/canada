package com.jencor1.mortgage.common;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.entity.BufferedHttpEntity;
import org.apache.http.impl.client.DefaultHttpClient;

import com.jencor1.mortgage.BaseActivity;
import com.jencor1.mortgage.R;

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

	private BaseActivity activity;
	
	private String sourceUrl;
	private String targetPath;
	
	private DownloadFileAsync loaderThread = null;
	
	public FileLoader(BaseActivity activity, final String sourceUrl, final String fileName)
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
            activity.showDialog(BaseActivity.DIALOG_PROGRESS);
        }

        protected boolean loadFromNetwork(final String sourceUrl)
        {
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
			
			                HttpEntity entity = response.getEntity();
			                
			                long lenghtOfFile = entity.getContentLength();
			                
							InputStream input = (new BufferedHttpEntity(entity)).getContent();
									
			                OutputStream output = new FileOutputStream(targetFilePath);
			
			                
			                byte[] buffer = new byte[4 * 1024]; // or other buffer size
			                int read;

			                while ((read = input.read(buffer)) != -1) {
			                    output.write(buffer, 0, read);
			                }
			                
			
			                output.flush();
			                output.close();
			                input.close();
			                entity.consumeContent();
			                
			                File targetFile = new File(targetFilePath);
			                
			                downloadSucceeded = targetFile.exists() && targetFile.length() > 0;
			                
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
