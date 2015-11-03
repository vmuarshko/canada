package com.skyfinancial1.canadamortgage.common;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;

import android.app.Activity;
import android.app.Application;
import android.net.Uri;
import android.util.Log;

import com.skyfinancial1.canadamortgage.SFBaseActivity;

public final class CommonUtil
{
	private static final String LOG_TAG = "CommonUtil";
	
	public static File getFilesFolder(Activity context)
	{
		return context.getApplication().getDir("data", Application.MODE_PRIVATE);
	}
	
	public static boolean copyStreamToFile(InputStream is, File targetFile)
	{
		boolean result = false;
		
		InputStream input = null;
		OutputStream output = null;
		try
		{
            input = new BufferedInputStream(is, 8192);	                         
            output = new FileOutputStream(targetFile);

            byte data[] = new byte[8192];
            
            int count = 0;
            while ((count = input.read(data)) != -1) 
            {
                output.write(data, 0, count);
            }
            result = true;
		}
		catch (Exception ex)
		{
			Log.d(LOG_TAG, "copyStreamToFile", ex);						
		}
		finally
		{
			try
			{
				if (output != null)
				{
		            output.flush();
		            output.close();
				}
				if (input != null)
					input.close();
			}
			catch (IOException ex)
			{
				Log.d(LOG_TAG, "copyStreamToFile", ex);				
			}			
		}		
		return result;
	}
	
	public static final long HOUR = 1000l * 60l * 60l;
	public static final long HOURS_12 = HOUR * 12;
	public static final long HOURS_24 = HOUR * 24;
	
	public static void loadDataFile(SFBaseActivity context, final String sourceUrl, final String dataFileName, final long validPeriod)
	{
		Uri fileUri = Uri.parse(dataFileName);
		String fileName = fileUri.getLastPathSegment();
					
		{
			File dataFile = new File(getFilesFolder(context), fileName);
			if (dataFile.exists() && (System.currentTimeMillis() - dataFile.lastModified()) < validPeriod)
			{
				context.onFileDownloadCompleted(sourceUrl, dataFile.getPath());				
			}
			else
			{
				Log.i(LOG_TAG, "Data file not found in data dir : " + fileName + " Trying to load file...");
				FileLoader loader = new FileLoader(context, sourceUrl, dataFileName);
				loader.loadFileData();
			}
		}				
	}
	
	private static final int maxBufferSize = 1024 * 1024;
	private static final int maxStirngSize = 1024 * 65;
    
	/**
	 * Concert input stream into string
	 * @param is input stream
	 * @param delimiter used to separate strings
	 * @return string representation of the stream
	 * @throws Exception
	 */
    public static String streamToString(InputStream is, final String delimiter) throws Exception
    {
		StringBuilder sb = new StringBuilder();

		BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"), 8192);

		String line;
		while ((line = reader.readLine()) != null) 
		{
			if (sb.length() >= maxBufferSize) break;
			
			if (line != null && line.length() < maxStirngSize && delimiter != null)
				sb.append(line).append(delimiter);
		}
		return sb.toString();
    }
	
}
