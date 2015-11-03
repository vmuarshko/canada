package ca1.canadaguaranty;

import java.io.InputStream;

import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import ca1.canadaguaranty.common.CGContactsData;
import ca1.canadaguaranty.common.CommonUtil;

public class NewsletterActivity extends BaseActivity
{
//	private static final String LOG_TAG = NewsletterActivity.class.getSimpleName();
//	
//	int languageSelection = 0;
//	private List<String> languages = new ArrayList<String>();

	
//	private int getScale(){
//	    Display display = ((WindowManager) getSystemService(Context.WINDOW_SERVICE)).getDefaultDisplay(); 
//	    int width = display.getWidth(); 
//	    Double val = new Double(width)/new Double(PIC_WIDTH);
//	    val = val * 100d;
//	    return val.intValue();
//	}
	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		setContentView(R.layout.newsletter);

		initDefaultControls();
		
		WebView webView = (WebView) findViewById(R.id.webView);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.setWebViewClient(new WebViewClient());
		//webView.getSettings().setBuiltInZoomControls(true);
		CGContactsData.Resources r = CGContactsData.getResources();
		if (r.locale.getLanguage().equalsIgnoreCase("en")){
			webView.loadUrl("http://www.canadaguaranty.ca/newsletter-signup-responsive");	
		}else{
			webView.loadUrl("http://www.canadaguaranty.ca/fr/newsletter-signup-responsive");
		}
//		webView.setInitialScale(260); 
//		InputStream is = null;
//    	try
//    	{
//    		// 
//            final String fileName = "signupform.html";
//    		
//    		CGContactsData.Resources r = CGContactsData.getResources();
//			StringBuilder dirName = new StringBuilder();
//   			dirName.append("data_").append(r.locale.getLanguage()).append('/').append(fileName);
//   			
//			is = getAssets().open(dirName.toString());
//			if (is != null)
//			{
//				String content = CommonUtil.streamToString(is, "\n");
//				webView.loadData(content, "text/html; charset=UTF-8", null);
//			}
//    	}
//    	catch (Exception ex)
//    	{
//    		showErrorMessage(ex.toString());
//    	}
//    	finally
//    	{
//    		try
//    		{
//    			if (is != null) is.close();
//    		}
//    		catch (Exception ex) {}
//    	}

		

//		Resources r = CGContactsData.getResources();
//		int count = 0;
//		for (Locale l : CGContactsData.resourceMap.keySet())
//		{
//			if (l.equals(r.locale)) languageSelection = count;
//			languages.add(l.getDisplayLanguage());
//			count++;
//		}
//
//		Spinner spinnerLanguage = (Spinner) findViewById(R.id.spinnerLanguage);
//		if (spinnerLanguage != null)
//		{
//			ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
//				android.R.layout.simple_spinner_item, languages);
//			adapter
//				.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//			spinnerLanguage.setAdapter(adapter);
//			spinnerLanguage.setSelection(languageSelection);
//		}
//
//		Button btnSugnup = (Button) findViewById(R.id.btnSignup);
//		btnSugnup.setOnClickListener(new View.OnClickListener()
//		{			
//			@Override
//			public void onClick(View v)
//			{
//				onHandleSignup(v);
//			}
//		});
//		
//        try
//        {
//            Spinner spinnerProvince = (Spinner) findViewById(R.id.spinnerProvince);
//            if (spinnerProvince != null)
//            {
//            	ArrayAdapter<String> adapter = new ArrayAdapter<String>(this
//            		, android.R.layout.simple_spinner_item
//            		, getResources().getStringArray(R.array.provincies));
//            	adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//            	spinnerProvince.setAdapter(adapter);
//            	spinnerProvince.setSelection(0);
//            }        	
//        }
//        catch (Exception ex)
//        {
//        	showErrorMessage(ex.getLocalizedMessage());
//        	return;
//        }
		
	}

//	private String webLeadInformation = null;
//	private SoapPrimitive response = null;
	
//	public void onHandleSignup(View view)
//    {
//        EditText editName = (EditText) findViewById(R.id.editName);
//        EditText editLastName = (EditText) findViewById(R.id.editLastName);
//        EditText editEmail = (EditText) findViewById(R.id.editEmail);
//        EditText editCompany = (EditText) findViewById(R.id.editCompany);
//        Spinner spinnerLanguage = (Spinner) findViewById(R.id.spinnerLanguage);
//        Spinner spinnerProvince = (Spinner) findViewById(R.id.spinnerProvince);
//        CheckBox checkBoxSubscription = (CheckBox) findViewById(R.id.checkBoxSubscription);
//        
//        try
//        {
//        	String firstName = editName.getText().toString().trim();
//        	String lastName = editLastName.getText().toString().trim();
//        	String company = editCompany.getText().toString().trim();
//        	
//        	if (TextUtils.isEmpty(firstName))
//        	{
//        		editName.requestFocus();
//        		throw new Exception(getString(R.string.invalid_first_name));
//        	}
//        	if (TextUtils.isEmpty(lastName))
//        	{
//        		editLastName.requestFocus();
//        		throw new Exception(getString(R.string.invalid_last_name));
//        	}
//        	if (TextUtils.isEmpty(company))
//        	{
//        		editCompany.requestFocus();
//        		throw new Exception(getString(R.string.invalid_company));
//        	}
//        	
//        	String email = editEmail.getText().toString().trim();
//        	if (TextUtils.isEmpty(email))
//        	{
//        		editEmail.requestFocus();
//        		throw new Exception(getString(R.string.invalid_email));
//        	}        	
//        	else if (!CGContactsData.EMAIL_ADDRESS_PATTERN.matcher(email).matches())
//        	{
//        		editEmail.requestFocus();
//        		throw new Exception(getString(R.string.invalid_valid_email));        		
//        	}
//        	if (checkBoxSubscription.isChecked() == false){
//           		throw new Exception(getString(R.string.error_no_terms));        		
//        	}
//        	int provinceId = spinnerProvince.getSelectedItemPosition();
//        	int langId = spinnerLanguage.getSelectedItemPosition();
//        	
//        	String [] provincies = getResources().getStringArray(R.array.provincies);
//        	        	
//     	    webLeadInformation = String.format(XML_REQUEST_FORMAT
//     	    	, firstName
//     	    	, lastName
//     	    	, provincies[provinceId]
//     	    	, email
//     	    	, DateFormat.getDateFormat(this).format(new Date())
//     	    	, company
//     	    	, langId
//     	    ); 
//     	   TheTask cattask = new TheTask();
//     	   cattask.execute();
//        }
//        catch (Exception ex)
//        {
//        	showErrorAlert(ex.getMessage());
//        }		
//    }
//	
//	private void showErrorAlert(String message){
//		new AlertDialog.Builder(this)
//	    .setTitle(R.string.invalid_title)
//	    .setMessage(message)
//	    .setPositiveButton(android.R.string.ok, new DialogInterface.OnClickListener() {
//	        public void onClick(DialogInterface dialog, int which) { 
//	            dialog.dismiss();
//	        }
//	     }).show();
//	}
//	
//	
//	class TheTask extends AsyncTask<Void, Void, Void> {
//		protected void onPreExecute() {
//			super.onPreExecute();
//			// display progressdialog.
//		}
//
//		protected Void doInBackground(Void... params)// return result here
//		{
//			try {
//				response = callSoap(webLeadInformation);
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} catch (XmlPullParserException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//			return null;
//		}
//
//	protected void onPostExecute(Void result)//result of doInBackground is passed a parameter
//	{     
//	        super.onPostExecute(result);
//			if (response != null
//					&& response.toString().contains("<eventId>10001</eventId>")) {
//				showErrorMessage(getString(R.string.subscription_succeeded));
//			} else showErrorMessage(getString(R.string.subscription_failed)); 
//
//	} 
//
//	}
//	
//	private static final String XML_REQUEST_FORMAT = "<WebLeadContact>"
//		+ "<webLeadIdentifier>16202</webLeadIdentifier >"
//		+ "<firstName>%s</firstName>" + "<lastName>%s</lastName>"
//		+ "<province>%s</province>" + "<city>N/A</city>"
//		+ "<emailAddress>%s</emailAddress>" + "<phoneNumber>N/A</phoneNumber>"
//		+ "<creditProfile></creditProfile>" + "<purposeOfLoan></purposeOfLoan>"
//		+ "<purchasePrice></purchasePrice>" + "<fundRequired></fundRequired>"
//		+ "<likelyTimeToFinance></likelyTimeToFinance>"
//		+ "<bestTimeToCall></bestTimeToCall>"
//		+ "<agentFirstName>Brian</agentFirstName>"
//		+ "<agentLastName>Bell</agentLastName>"
//		+ "<websiteEntryDate>%s</websiteEntryDate>"
//		+ "<company>%s</company>"
//		+ "<preferredLanguage>%d</preferredLanguage>"
//		+ "<websiteNote1></websiteNote1>" + "<websiteNote2></websiteNote2>"
//		+ "<websiteNote3></websiteNote3>" + "<websiteNote4></websiteNote4>"
//		+ "<sourceWebsite>CanGAndroidLead</sourceWebsite>"
//		+ "</WebLeadContact>";
//
//	private static final String METHOD_NAME = "submitLead";
//	private static final String SOAP_ACTION = "https://nexa.incontact.ca/Nexa/services/WebLeadService";
//	private static final String NAMESPACE = "https://weblead.ws.nexa.openface.com/";
//	//private static final String URL = "https://nexa.incontact.ca/Nexa/services/WebLeadService?wsdl";
//	
//	public SoapPrimitive callSoap(final String webLeadInformation)
//					throws IOException, XmlPullParserException
//	{
//		SoapObject request = new SoapObject(NAMESPACE, METHOD_NAME); 
//		
//		PropertyInfo pi = new PropertyInfo();
//        pi.setName("requestSource");
//        pi.setValue("CanGuarAndroid");
//        pi.setType(PropertyInfo.STRING_CLASS);
//        request.addProperty(pi);
//        
//		PropertyInfo pi2 = new PropertyInfo();
//        pi2.setName("webLeadInformation");
//        pi2.setValue(webLeadInformation);
//        pi2.setType(PropertyInfo.OBJECT_CLASS);
//        request.addProperty(pi2);
//		        
//		SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(
//			SoapEnvelope.VER11); // put all required data into a soap envelope
//		envelope.setOutputSoapObject(request); // prepare request
//		
//		HttpTransportSE httpTransport = new HttpTransportSE(SOAP_ACTION);		
//		SoapPrimitive result = null;
//		
//		try
//		{			
//			httpTransport.call(SOAP_ACTION, envelope); // send request			
//			result = (SoapPrimitive) envelope.getResponse(); // get response				
//		}
//		catch (Exception ex)
//		{
//			Log.d(LOG_TAG, "callSoap", ex);
//		}
//		
//		return result;
//	}

}
