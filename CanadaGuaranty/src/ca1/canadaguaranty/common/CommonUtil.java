package ca1.canadaguaranty.common;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.Locale;

import android.app.Activity;
import android.content.Context;
import android.net.Uri;
import android.util.Log;
import ca1.canadaguaranty.BaseActivity;

public final class CommonUtil
{
	private static final String LOG_TAG = "CommonUtil";
	
	public static File getFilesFolder(Activity context, Locale l)
	{
		CGContactsData.Resources r = l == null ? CGContactsData.getResources() : CGContactsData.getResources(l);		
		if (Locale.CANADA.equals(r.locale))		
			return context.getApplication().getDir("data_en", Context.MODE_PRIVATE);
		else
		{
			StringBuilder dirName = new StringBuilder();
			dirName.append("data_").append(r.locale.getLanguage());
			return context.getApplication().getDir(dirName.toString(), Context.MODE_PRIVATE);
		}
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
	
	public static void loadDataFile(BaseActivity context, Locale l, final String sourceUrl, final String dataFileName, final long validPeriod)
	{
		Uri fileUri = Uri.parse(dataFileName);
		String fileName = fileUri.getLastPathSegment();
					
		{
			File dataFile = new File(getFilesFolder(context, l), fileName);
			if (dataFile.exists() && (System.currentTimeMillis() - dataFile.lastModified()) < validPeriod)
			{
				context.onFileDownloadCompleted(sourceUrl, dataFile.getPath());				
			}
			else
			{
				Log.i(LOG_TAG, "Data file not found in data dir : " + dataFile.getAbsolutePath() + " Trying to load file...");
				FileLoader loader = new FileLoader(context, sourceUrl, dataFile.getAbsolutePath(), l.getLanguage());
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
	
	public static String capitalizeString(String string)
	{
		char[] chars = string.toLowerCase().toCharArray();
		boolean found = false;
		for (int i = 0; i < chars.length; i++)
		{
			if (!found && Character.isLetter(chars[i]))
			{
				chars[i] = Character.toUpperCase(chars[i]);
				found = true;
			}
			else if (Character.isWhitespace(chars[i]) || chars[i] == '.'
				|| chars[i] == '\'')
			{ // You can add other chars here
				found = false;
			}
		}
		return String.valueOf(chars);
	}
}
