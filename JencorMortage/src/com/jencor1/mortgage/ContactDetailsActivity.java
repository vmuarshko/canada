package com.jencor1.mortgage;

import java.util.Locale;

import com.jencor1.mortgage.common.JMContactsData;
import com.jencor1.mortgage.R;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.TextView;

public class ContactDetailsActivity extends ContactBaseActivity implements OnClickListener
{
	public static final String CONTACT_ID = "CONTACT_ID";
	
	private int contactId;
	
	private static final class ButtonLink
	{
		public final int id;
		public final String url;
		
		public ButtonLink(int id, final String url)
		{
			this.id = id;
			this.url = url;
		}
	}
	
	private static final ButtonLink [] BTN_LINKS = new ButtonLink []
			{
				new ButtonLink(R.id.btnTwitter, JMContactsData.TWITTER_ADDRESS)
				, new ButtonLink(R.id.btnLinkedIn, JMContactsData.LINKEDIN_ADDRESS)
				, new ButtonLink(R.id.btnFacebook, JMContactsData.FACEBOOK_ADDRESS)
				, new ButtonLink(R.id.btnRss, JMContactsData.BLOG_SOURCE_URL)
			};

	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.contact_details);
     
        initDefaultControls();
        
        contactId = getIntent().getIntExtra(CONTACT_ID, 0);
        
        if (contactId >= 0 && contactId < JMContactsData.OFFICE_LIST.length)
        {
        	TextView textTitle = (TextView) findViewById(R.id.textViewTitle);
        	if (textTitle != null)
        		textTitle.setText(JMContactsData.OFFICE_LIST[contactId]);
        	
//        	Button btnShowOnMap = (Button) findViewById(R.id.btnShowOnMap);
//        	if (btnShowOnMap != null)
//        	{
//        		if (JMContactsData.OFFICE_DATA[contactId].latitude != 0 && 
//        				JMContactsData.OFFICE_DATA[contactId].longitude != 0)
//        		{
//        			btnShowOnMap.setOnClickListener(new View.OnClickListener()
//					{						
//						@Override
//						public void onClick(View v)
//						{
//							String geoLocation = String.format(Locale.US, "geo:%.6f,%.6f"
//								, JMContactsData.OFFICE_DATA[contactId].latitude
//								, JMContactsData.OFFICE_DATA[contactId].longitude
//							);
//							Intent intent = new Intent(Intent.ACTION_VIEW);
//							intent.setData(Uri.parse(geoLocation));
//							startActivity(intent);
//						}
//					});
//        		}
//        		else btnShowOnMap.setVisibility(View.INVISIBLE);
//        	}
        	
        	TextView textAddr1 = (TextView) findViewById(R.id.textAddr1);
        	textAddr1.setMaxLines(6);
        	if (textAddr1 != null)
        		textAddr1.setText(JMContactsData.OFFICE_DATA[contactId].addrLine1);
//        	TextView textAddr2 = (TextView) findViewById(R.id.textAddr2);
//        	if (textAddr2 != null)
//        		textAddr2.setText(JMContactsData.OFFICE_DATA[contactId].addrLine2);

//        	TextView textContact = (TextView) findViewById(R.id.textContact);
//        	if (textContact != null)
//        		if (JMContactsData.OFFICE_DATA[contactId].contact != null)
//        			textContact.setText(getString(R.string.label_contact) + " " + 
//        					JMContactsData.OFFICE_DATA[contactId].contact);
//        		else textContact.setVisibility(View.GONE);
        	
        	TextView textEmail = (TextView) findViewById(R.id.textEmail);
        	if (textEmail != null)
        		if (JMContactsData.OFFICE_DATA[contactId].email != null)
        			textEmail.setText(getString(R.string.label_email_us) + " " + 
        					JMContactsData.OFFICE_DATA[contactId].email);
        		else textEmail.setVisibility(View.GONE);
        	
        	TextView textPhone = (TextView) findViewById(R.id.textPhone);
        	if (textPhone != null)
        		if (JMContactsData.OFFICE_DATA[contactId].workPhone != null)
        			textPhone.setText(getString(R.string.label_call_us) + " " + 
        					JMContactsData.OFFICE_DATA[contactId].workPhone);
        		else textPhone.setVisibility(View.GONE);

        	TextView textMobilePhone = (TextView) findViewById(R.id.textMobilePhone);
        	if (textMobilePhone != null)
        		if (JMContactsData.OFFICE_DATA[contactId].mobilePhone != null)
        			textMobilePhone.setText(getString(R.string.label_mobile_phone) + " " + 
        					JMContactsData.OFFICE_DATA[contactId].mobilePhone);
        		else textMobilePhone.setVisibility(View.GONE);

//        	TextView textFax = (TextView) findViewById(R.id.textFax);
//        	if (textFax != null)
//        		if (JMContactsData.OFFICE_DATA[contactId].fax != null)
//        			textFax.setText(getString(R.string.label_fax) + " " + 
//        					JMContactsData.OFFICE_DATA[contactId].fax);
//        		else textFax.setVisibility(View.GONE);
        	
        	TextView textUrl = (TextView) findViewById(R.id.textUrl);
        	if (textUrl != null)
        		if (JMContactsData.OFFICE_DATA[contactId].url != null)
        			textUrl.setText(JMContactsData.OFFICE_DATA[contactId].url);
        		else
        			textUrl.setText(JMContactsData.HOME_URL);
        }
        
        for (ButtonLink link: BTN_LINKS)
        {
        	View btn = findViewById(link.id);
        	if (btn != null)
        		btn.setOnClickListener(this);
        }
    }


	@Override
	public void onClick(View v)
	{
        for (ButtonLink link: BTN_LINKS)
        {
        	if (link.id == v.getId())
        	{
        		try
        		{
	        		String url = link.url;
	        		if (!url.startsWith("http://") && !url.startsWith("https://")) url = "http://" + url;
	        		
	        		Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
	        		startActivity(browserIntent);
        		}
        		catch (Exception ex)
        		{
        			showErrorMessage(ex.getLocalizedMessage());
        		}
        	}
        }
		
	}

}
