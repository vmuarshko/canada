package com.jencor1.mortgage;

import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;

public class QuickAppActivity extends BaseActivity
{
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.quick_app);
     
        initDefaultControls();
		WebView webView = (WebView) findViewById(R.id.webView);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.setWebViewClient(new WebViewClient());
		webView.loadUrl("http://www.jencormortgage.com/jencor-contact-form/");

//        Spinner spinnerLoanPurpose = (Spinner) findViewById(R.id.spinnerLoanPurpose);
//        if (spinnerLoanPurpose != null)
//        {
//        	ArrayAdapter<CharSequence> adapter = ArrayAdapter.createFromResource(this
//        			, R.array.arr_loan_purposes
//        			, android.R.layout.simple_spinner_item);
//        	adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
//        	spinnerLoanPurpose.setAdapter(adapter);
//        	spinnerLoanPurpose.setSelection(0);
//        }
//        
//        EditText editPhone = (EditText) findViewById(R.id.editPhone);
//        if (editPhone != null)
//        {
//        	editPhone.setOnEditorActionListener(editorImeSendListener);
//        }
//
//        EditText editComments = (EditText) findViewById(R.id.editComments);
//        if (editComments != null)
//        {
//        	editComments.setOnEditorActionListener(editorImeSendListener);
//        }
//        
//        Button btnSend = (Button) findViewById(R.id.btnSend);
//        if (btnSend != null)
//        {
//        	btnSend.setOnClickListener(new View.OnClickListener()
//			{				
//				@Override
//				public void onClick(View v)
//				{
//					handleSend();					
//				}
//			});
//        }
    }

//    private TextView.OnEditorActionListener editorImeSendListener = new TextView.OnEditorActionListener()
//	{
//		
//		@Override
//		public boolean onEditorAction(TextView v, int actionId, KeyEvent event)
//		{
//			if (actionId == EditorInfo.IME_ACTION_SEND && 
//					(event == null || event.getAction() == KeyEvent.ACTION_DOWN)) 
//			{ 
//				handleSend();
//			}
//			return true;				
//		}
//	};
//
//	private void handleSend()
//	{
//        Spinner spinnerLoanPurpose = (Spinner) findViewById(R.id.spinnerLoanPurpose);
//        EditText editAmountRequested = (EditText) findViewById(R.id.editAmountRequested);
//        EditText editName = (EditText) findViewById(R.id.editName);
//        EditText editEmail = (EditText) findViewById(R.id.editEmail);
//        EditText editPhone = (EditText) findViewById(R.id.editPhone);
//        EditText editComments = (EditText) findViewById(R.id.editComments);
//        
//        try
//        {
//        	String name = editName.getText().toString().trim();
//        	if (TextUtils.isEmpty(name))
//        	{
//        		editName.requestFocus();
//        		throw new Exception(getString(R.string.error_empty_value));
//        	}
//        	String phone = editPhone.getText().toString().trim();
//        	if (TextUtils.isEmpty(phone))
//        	{
//        		editPhone.requestFocus();
//        		throw new Exception(getString(R.string.error_empty_value));
//        	}
//        	String email = editEmail.getText().toString().trim();
//        	if (TextUtils.isEmpty(email))
//        	{
//        		editEmail.requestFocus();
//        		throw new Exception(getString(R.string.error_empty_value));
//        	}
//        	else if (!JMContactsData.EMAIL_ADDRESS_PATTERN.matcher(email).matches())
//        	{
//        		editEmail.requestFocus();
//        		throw new Exception(getString(R.string.error_invalid_value));        		
//        	}
//        	
//        	String loanPurpose = getResources()
//        			.getStringArray(R.array.arr_loan_purposes)[spinnerLoanPurpose.getSelectedItemPosition()];
//        	Double amountRequested = Double.parseDouble(editAmountRequested.getText().toString().trim());
//        	if (amountRequested <= 0.01)
//        		throw new NumberFormatException();
//        	
//        	String comment = editComments.getText().toString().trim();
//        	
//        	final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);            
//            emailIntent.setType("plain/text");
//       
//            emailIntent.putExtra(android.content.Intent.EXTRA_EMAIL, new String[] { JMContactsData.QUICK_APP_EMAIL });     
//            emailIntent.putExtra(android.content.Intent.EXTRA_SUBJECT
//            	, String.format(getString(R.string.quick_application_subj), name));
//     
//            emailIntent.putExtra(android.content.Intent.EXTRA_TEXT
//            	, String.format(getString(R.string.quick_application_text)
//            			, loanPurpose, amountRequested, name, email, phone, comment));
//
//            startActivity(Intent.createChooser(emailIntent, getString(R.string.sending_email)));        	
//        }
//        catch (NumberFormatException ex)
//        {
//        	showErrorMessage(getString(R.string.error_number_format));
//        	editAmountRequested.requestFocus();        	
//        }
//        catch (Exception ex)
//        {
//        	showErrorMessage(ex.getMessage());
//        }		
//	}
//
}


