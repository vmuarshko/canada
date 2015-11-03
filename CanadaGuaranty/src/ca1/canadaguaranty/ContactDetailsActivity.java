package ca1.canadaguaranty;

import java.io.File;
import java.io.FileInputStream;

import ca1.canadaguaranty.common.CGContactsData;
import ca1.canadaguaranty.common.CommonUtil;
import ca1.canadaguaranty.xml.TeamXMLHandler;
import ca1.canadaguaranty.xml.XMLDataReader;
import ca1.canadaguaranty.R;
import android.graphics.Typeface;
import android.os.Bundle;
import android.text.TextUtils;
import android.text.util.Linkify;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.LinearLayout;
import android.widget.Spinner;
import android.widget.TextView;

public class ContactDetailsActivity extends BaseActivity
{
    private TeamXMLHandler handler = new TeamXMLHandler();
	
    private int selection = 0;
    
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.contacts_national);
     
        initDefaultControls();

		enableBackButton(true);
		
        File dataFolder = CommonUtil.getFilesFolder(this, null);
        File dataFile = new File(dataFolder, CGContactsData.NATIONAL_SALES_TEAM_FILE_NAME);
        if (!dataFile.exists()) 
        {  
        	showErrorMessage(getString(R.string.error_contacts_file_not_found));
        	return;
        }
        
        try
        {
        	XMLDataReader.readFromXML(new FileInputStream(dataFile), handler);
        	
            Spinner spinnerTeam = (Spinner) findViewById(R.id.spinnerTeam);
            if (spinnerTeam != null)
            {
            	ArrayAdapter<TeamXMLHandler.Team> adapter = new ArrayAdapter<TeamXMLHandler.Team>(this
            		, android.R.layout.simple_spinner_item
            		, handler.teams);
            	adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
            	spinnerTeam.setAdapter(adapter);
            	spinnerTeam.setSelection(selection);

            	spinnerTeam.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() 
            	{
            	    @Override
            	    public void onItemSelected(AdapterView<?> parentView, View selectedItemView, int position, long id) {
            	        selection = position;
            	        updateContactData();
            	    }

            	    @Override
            	    public void onNothingSelected(AdapterView<?> parentView) 
            	    {
            	        selection = 0;
            	        updateContactData();
            	    }
            	});        	
            }
        	
        }
        catch (Exception ex)
        {
        	showErrorMessage(ex.getLocalizedMessage());
        	return;
        }
        
    }
    
    private void updateContactData()
    {
    	LinearLayout layoutTeam = (LinearLayout) findViewById(R.id.layoutTeam);
    	if (layoutTeam != null)
    	{
    		layoutTeam.removeAllViews();
    		int startId = R.id.layoutTeam + 1;
    		
    		for (TeamXMLHandler.Member member: handler.teams.get(selection).members)
    		{    		
	    		TextView text1 = new TextView(this);
	    		text1.setId(startId++);
	    		text1.setText(member.name);
	    		text1.setTextColor(getResources().getColor(R.color.highlight_color));
	    		text1.setTextAppearance(this, android.R.attr.textAppearanceMedium);
	    		text1.setTypeface(null, Typeface.BOLD);
	    		LinearLayout.LayoutParams params1 = new LinearLayout.LayoutParams(
                    android.view.ViewGroup.LayoutParams.MATCH_PARENT,
                    android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
	    		params1.setMargins(0, (int)getResources().getDimension(R.dimen.view_divider_margin), 0, 0);
	    		text1.setLayoutParams(params1);
	    		layoutTeam.addView(text1);
	    		
	    		text1 = new TextView(this);
	    		text1.setId(startId++);
	    		StringBuilder sb = new StringBuilder().append(member.title);
	    		if (!TextUtils.isEmpty(member.region))
	    			sb.append(", ").append(member.region);
	    		text1.setText(sb.toString());
	    		text1.setTextAppearance(this, android.R.attr.textAppearanceMedium);
	    		text1.setTypeface(null, Typeface.BOLD);
	    		text1.setLayoutParams(new LinearLayout.LayoutParams(
                    android.view.ViewGroup.LayoutParams.MATCH_PARENT,
                    android.view.ViewGroup.LayoutParams.WRAP_CONTENT));
	    		layoutTeam.addView(text1);
	    		
	    		if (!TextUtils.isEmpty(member.tel))
	    		{
		    		text1 = new TextView(this);
		    		text1.setId(startId++);
		    		sb.setLength(0);
		    		text1.setText(sb.append(getString(R.string.contact_tel)).append(": ").append(member.tel).toString());
		    		text1.setAutoLinkMask(Linkify.PHONE_NUMBERS);
		    		text1.setTextAppearance(this, android.R.attr.textAppearanceMedium);
		    		text1.setLayoutParams(new LinearLayout.LayoutParams(
	                    android.view.ViewGroup.LayoutParams.MATCH_PARENT,
	                    android.view.ViewGroup.LayoutParams.WRAP_CONTENT));
		    		layoutTeam.addView(text1);	    			
	    		}
	    		
	    		if (!TextUtils.isEmpty(member.toolFree))
	    		{
		    		text1 = new TextView(this);
		    		text1.setId(startId++);
		    		sb.setLength(0);
		    		sb.append(getString(R.string.contact_toll_free)).append(": ").append(member.toolFree);
		    		if (!TextUtils.isEmpty(member.toolFreeExt))
		    		{
		    			sb.append(' ').append(getString(R.string.contact_toll_free_ext)).append(' ').append(member.toolFreeExt);
		    		}
		    		text1.setText(sb.toString());
		    		text1.setTextAppearance(this, android.R.attr.textAppearanceMedium);
		    		text1.setAutoLinkMask(Linkify.PHONE_NUMBERS);
		    		text1.setLayoutParams(new LinearLayout.LayoutParams(
	                    android.view.ViewGroup.LayoutParams.MATCH_PARENT,
	                    android.view.ViewGroup.LayoutParams.WRAP_CONTENT));
		    		layoutTeam.addView(text1);	    			
	    		}
	    		
	    		if (!TextUtils.isEmpty(member.email))
	    		{
		    		text1 = new TextView(this);
		    		text1.setId(startId++);
		    		sb.setLength(0);
		    		text1.setText(sb.append(getString(R.string.contact_email)).append(": ").append(member.email).toString());
		    		text1.setAutoLinkMask(Linkify.EMAIL_ADDRESSES);
		    		text1.setTextAppearance(this, android.R.attr.textAppearanceMedium);
		    		text1.setLayoutParams(new LinearLayout.LayoutParams(
	                    android.view.ViewGroup.LayoutParams.MATCH_PARENT,
	                    android.view.ViewGroup.LayoutParams.WRAP_CONTENT));
		    		layoutTeam.addView(text1);	    			
	    		}	    		
    		}    		
    	}
    }    
}
