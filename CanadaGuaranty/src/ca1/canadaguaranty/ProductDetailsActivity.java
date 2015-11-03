package ca1.canadaguaranty;

import java.io.File;
import java.io.FileInputStream;
import android.os.Bundle;
import android.text.Html;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TableRow;
import android.widget.TextView;
import ca1.canadaguaranty.common.CGContactsData;
import ca1.canadaguaranty.common.CommonUtil;
import ca1.canadaguaranty.xml.ProductsXMLHandler;
import ca1.canadaguaranty.xml.XMLDataReader;
import ca1.canadaguaranty.R;

public class ProductDetailsActivity extends BaseActivity
{
    private ProductsXMLHandler handler = new ProductsXMLHandler();
	
	public static final String PRODUCT_INDEX = "PRODUCT_INDEX";
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.product_details);
     
        initDefaultControls();

		enableBackButton(true);
		
		ViewGroup layoutData = (ViewGroup) findViewById(R.id.layoutData);
		layoutData.setVisibility(View.INVISIBLE);
        
        File dataFolder = CommonUtil.getFilesFolder(this, null);
        File dataFile = new File(dataFolder, CGContactsData.PRODUCTS_FILE_NAME);
        if (!dataFile.exists()) 
        {  
        	showErrorMessage(getString(R.string.error_products_file_not_found));
        	return;
        }
        
        try
        {
        	XMLDataReader.readFromXML(new FileInputStream(dataFile), handler);
        	
            ProductsXMLHandler.Product product = handler.products.get(getIntent().getIntExtra(PRODUCT_INDEX, 0));

        	TextView textCategory = (TextView) findViewById(R.id.textCategory);
        	if (textCategory != null)
        		textCategory.setText(product.category);
            
        	TextView textTitle = (TextView) findViewById(R.id.textTitle);
        	if (textTitle != null)
        		textTitle.setText(product.title);

        	TextView textDescription = (TextView) findViewById(R.id.textDescription);
        	if (textDescription != null)
        		textDescription.setText(Html.fromHtml(product.description));
        	
        	LinearLayout layoutPoints = (LinearLayout) findViewById(R.id.layoutPoints);
        	if (layoutPoints != null)
        	{
        		//int startId = R.id.layoutPoints + 1;
        		
        		for (ProductsXMLHandler.Product.Point point: product.points)
        		{
            		TextView text1 = new TextView(this);
            		//text1.setId(startId++);
            		text1.setText(point.title);
            		text1.setTextColor(getResources().getColor(R.color.highlight_color));
            		text1.setTextAppearance(this, android.R.attr.textAppearanceMedium);
            		text1.setLayoutParams(new LinearLayout.LayoutParams(
                            android.view.ViewGroup.LayoutParams.MATCH_PARENT,
                            android.view.ViewGroup.LayoutParams.WRAP_CONTENT));
            		layoutPoints.addView(text1);
        			
                	for (String descr: point.descriptions)
                	{
	            		TextView textDescr = new TextView(this);
	            		// textDescr.setId(startId++);
	            		textDescr.setText("• " + descr);
	            		//textDescr.setMaxLines(10);
	            		textDescr.setTextAppearance(this, android.R.attr.textAppearanceSmall);                		
	            		LinearLayout.LayoutParams tParams = new LinearLayout.LayoutParams(
	                        android.view.ViewGroup.LayoutParams.MATCH_PARENT,
	                        android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
	            		tParams.setMargins((int)getResources().getDimension(R.dimen.view_divider_margin), 0, 0, 0);
	            		textDescr.setLayoutParams(tParams);
	            		layoutPoints.addView(textDescr);
                	}
            		
            		
            		/*TableLayout tableDescriptions = new TableLayout(this);
            		// tableDescriptions.setId(startId++);
            		tableDescriptions.setStretchAllColumns(false);
            		LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(
                        android.view.ViewGroup.LayoutParams.MATCH_PARENT,
                        android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
            		params.setMargins(20, 0, 0, 0);
            		tableDescriptions.setLayoutParams(params);
            		
                	for (String descr: point.descriptions)
                	{
                		TableRow tableRow = new TableRow(this);
                		//tableRow.setId(startId++);
                		
                		TableRow.LayoutParams rowParams = new TableRow.LayoutParams(
                                android.view.ViewGroup.LayoutParams.MATCH_PARENT,
                                android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
                		tableRow.setLayoutParams(rowParams);
                		//tableRow.setPadding(5, 8, 5, 8);
                		tableRow.setGravity(Gravity.TOP);
                		
                		ImageView image = new ImageView(this);
                		// image.setId(startId++);
                		image.setImageResource(R.drawable.paragraph_sign);
                		TableRow.LayoutParams bulletParams = new TableRow.LayoutParams(
                            android.view.ViewGroup.LayoutParams.WRAP_CONTENT,
                            android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
                		bulletParams.setMargins(0, 15, 0, 0);
                		image.setLayoutParams(bulletParams);
                		tableRow.addView(image);
                		
                		TextView textDescr = new TextView(this);
                		// textDescr.setId(startId++);
                		textDescr.setText(descr);
                		//textDescr.setMaxLines(10);
                		textDescr.setTextAppearance(this, android.R.attr.textAppearanceSmall);                		
                		TableRow.LayoutParams tParams = new TableRow.LayoutParams(
                            android.view.ViewGroup.LayoutParams.WRAP_CONTENT,
                            android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
                		tParams.setMargins((int)getResources().getDimension(R.dimen.view_divider_margin), 0, 0, 0);
                		textDescr.setLayoutParams(tParams);
                		tableRow.addView(textDescr);
                		                		
                		tableDescriptions.addView(tableRow, new TableRow.LayoutParams(
                                android.view.ViewGroup.LayoutParams.MATCH_PARENT,
                                android.view.ViewGroup.LayoutParams.WRAP_CONTENT));
                	}
            		layoutPoints.addView(tableDescriptions);*/            		
        		}
        	}
        	
        	ViewGroup layoutAppPremiums = (ViewGroup) findViewById(R.id.layoutAppPremiums);
        	TextView textAppPremiumsTitle = (TextView) findViewById(R.id.textAppPremiumsTitle);
        	
        	if (layoutAppPremiums != null && textAppPremiumsTitle != null)
        	{
        		
        		if (!product.premiums.isEmpty())
        		{
            		//int startId = R.id.layoutAppPremiumsRow1 + 1;
        			for (ProductsXMLHandler.Product.Premium premium: product.premiums)
        			{        				
                		TableRow tableRow = new TableRow(this);
                		// tableRow.setId(startId++);
                		
                		TableRow.LayoutParams rowParams = new TableRow.LayoutParams(
                            android.view.ViewGroup.LayoutParams.MATCH_PARENT,
                            android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
	            		tableRow.setLayoutParams(rowParams);
	            		/*tableRow.setPadding(5, 8, 5, 8);
	            		tableRow.setGravity(Gravity.TOP | Gravity.CENTER_HORIZONTAL);*/

	            		{
	                		TextView textLtv = new TextView(this);
	                		//textLtv.setId(startId++);
	                		textLtv.setText(premium.ltv);	                		
	                		//textLtv.setMaxLines(1);
	                		textLtv.setTextAppearance(this, android.R.attr.textAppearanceSmall);                		
	                		TableRow.LayoutParams tParams = new TableRow.LayoutParams(
	                            android.view.ViewGroup.LayoutParams.MATCH_PARENT,
	                            android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
	                		tParams.weight = 1.0f;
	                		tParams.setMargins(0, 0, 0, 0);
	                		textLtv.setLayoutParams(tParams);
	                		tableRow.addView(textLtv);
	            		}
	            		
	            		{
	                		TextView textSingle = new TextView(this);
	                		//textSingle.setId(startId++);
	                		textSingle.setText(premium.singlePremium);
	                		//textSingle.setMaxLines(2);
	                		textSingle.setTextAppearance(this, android.R.attr.textAppearanceSmall);                		
	                		TableRow.LayoutParams tParams = new TableRow.LayoutParams(
	                            android.view.ViewGroup.LayoutParams.MATCH_PARENT,
	                            android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
	                		tParams.weight = 1.0f;
	                		tParams.setMargins(0, 0, 0, 0);
	                		textSingle.setLayoutParams(tParams);
	                		tableRow.addView(textSingle);
	            		}
	            			            		
        				
	            		{
	                		TextView textTopup = new TextView(this);
	                		//textTopup.setId(startId++);
	                		textTopup.setText(premium.topUp);
	                		//textTopup.setMaxLines(2);
	                		textTopup.setTextAppearance(this, android.R.attr.textAppearanceSmall);                		
	                		TableRow.LayoutParams tParams = new TableRow.LayoutParams(
	                            android.view.ViewGroup.LayoutParams.MATCH_PARENT,
	                            android.view.ViewGroup.LayoutParams.WRAP_CONTENT);
	                		tParams.weight = 1.0f;
	                		tParams.setMargins(0, 0, 0, 0);
	                		textTopup.setLayoutParams(tParams);
	                		tableRow.addView(textTopup);
	            		}
	            		
	            		layoutAppPremiums.addView(tableRow);
        			}
        			
        			layoutAppPremiums.setVisibility(View.VISIBLE);
        			textAppPremiumsTitle.setVisibility(View.VISIBLE);
        		}
        		else
        		{
        			layoutAppPremiums.setVisibility(View.GONE);
        			textAppPremiumsTitle.setVisibility(View.GONE);        			
        		}
        	}
        	
       		layoutData.setVisibility(View.VISIBLE);		
        }
        catch (Exception ex)
        {
        	showErrorMessage(ex.getLocalizedMessage());
        	return;
        }

        
    }

}
