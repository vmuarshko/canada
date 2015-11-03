package com.skyfinancial1.canadamortgage;

import java.util.Locale;

import com.skyfinancial1.canadamortgage.common.SFContactsData;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class ContactDetailsActivity extends ContactBaseActivity
{
	public static final String CONTACT_ID = "CONTACT_ID";
	
	private int contactId;
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.contact_details);
     
        initDefaultControls();
        
        contactId = getIntent().getIntExtra(CONTACT_ID, 0);
        
        if (contactId >= 0 && contactId < SFContactsData.OFFICE_LIST.length)
        {
        	TextView textTitle = (TextView) findViewById(R.id.textTitle);
        	if (textTitle != null)
        		textTitle.setText(SFContactsData.OFFICE_LIST[contactId]);
        	
        	Button btnShowOnMap = (Button) findViewById(R.id.btnShowOnMap);
        	if (btnShowOnMap != null)
        	{
        		if (SFContactsData.OFFICE_DATA[contactId].latitude != 0 && 
        				SFContactsData.OFFICE_DATA[contactId].longitude != 0)
        		{
        			btnShowOnMap.setOnClickListener(new View.OnClickListener()
					{						
						@Override
						public void onClick(View v)
						{
							String geoLocation = String.format(Locale.US, "geo:%.6f,%.6f"
								, SFContactsData.OFFICE_DATA[contactId].latitude
								, SFContactsData.OFFICE_DATA[contactId].longitude
							);
							Intent intent = new Intent(Intent.ACTION_VIEW);
							intent.setData(Uri.parse(geoLocation));
							startActivity(intent);
						}
					});
        		}
        		else btnShowOnMap.setVisibility(View.INVISIBLE);
        	}
        	
        	TextView textAddr1 = (TextView) findViewById(R.id.textAddr1);
        	textAddr1.setMaxLines(6);
        	if (textAddr1 != null)
        		textAddr1.setText(SFContactsData.OFFICE_DATA[contactId].addrLine1);
//        	TextView textAddr2 = (TextView) findViewById(R.id.textAddr2);
//        	if (textAddr2 != null)
//        		textAddr2.setText(SFContactsData.OFFICE_DATA[contactId].addrLine2);
        	
        	TextView textEmail = (TextView) findViewById(R.id.textEmail);
        	if (textEmail != null)
        		if (SFContactsData.OFFICE_DATA[contactId].email != null)
        			textEmail.setText(getString(R.string.label_email_us) + " " + 
        					SFContactsData.OFFICE_DATA[contactId].email);
        		else textEmail.setVisibility(View.GONE);
        	
        	TextView textPhone = (TextView) findViewById(R.id.textPhone);
        	if (textPhone != null)
        		if (SFContactsData.OFFICE_DATA[contactId].phone != null)
        			textPhone.setText(getString(R.string.label_call_us) + " " + 
        					SFContactsData.OFFICE_DATA[contactId].phone);
        		else textPhone.setVisibility(View.GONE);
        	
        	TextView textUrl = (TextView) findViewById(R.id.textUrl);
        	if (textUrl != null)
        		if (SFContactsData.OFFICE_DATA[contactId].url != null)
        			textUrl.setText(SFContactsData.OFFICE_DATA[contactId].url);
        		else
        			textUrl.setText(SFContactsData.HOME_URL);
        }
    }

}
