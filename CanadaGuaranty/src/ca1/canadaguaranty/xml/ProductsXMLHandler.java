package ca1.canadaguaranty.xml;

import java.util.ArrayList;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;

import android.text.TextUtils;
import android.util.Log;

public class ProductsXMLHandler extends XMLBaseHandler
{	
	public static final class Product
	{
		public String category;
		public String title;
		public String subtitle;
		public String description;		
		
		public static final class Point
		{
			public String title;
			public String notes;				
			public ArrayList<String> descriptions = new ArrayList<String>();				
		}			
		public ArrayList<Point> points = new ArrayList<Point>();
		
		public static final class Premium
		{
			public String ltv;
			public String singlePremium;
			public String topUp;			
		}
		public ArrayList<Premium> premiums = new ArrayList<Premium>();
		
		public void clear() 
		{
			points.clear();
			premiums.clear();
			category = title = subtitle = description = null;		
		}
		
		@Override
		public String toString() { return title; }
	}
		
	public ArrayList<ProductsXMLHandler.Product> products = new ArrayList<ProductsXMLHandler.Product>();
	
	@Override
	public void startDocument() throws SAXException 
	{
		super.startDocument();
		products.clear();
	}	
	
	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		super.startElement(uri, localName, qName, attributes);
		
		try
		{
			if (localName.equals(ProdXMLTags.productRoot))
			{
				products.add(new Product());
			}
			else if (localName.equals(ProdXMLTags.pointData) && products.size() > 0)
			{
				products.get(products.size() - 1).points.add(new Product.Point());
			}
			else if (localName.equals(ProdXMLTags.appPremium) && products.size() > 0)
			{
				products.get(products.size() - 1).premiums.add(new Product.Premium());				
			}
			else if (localName.equals(ProdXMLTags.pointDescription))
			{
				Product lastProduct = products.get(products.size() - 1);
				Product.Point point = lastProduct.points.get(lastProduct.points.size() - 1);
				point.descriptions.add("");
			}
			
		}
		catch (Exception ex)
		{
			Log.e("NewsXMLHandler", "XMLError", ex);
			throw new SAXException(ex);
		}
	}

	@Override
	public void characters(char ch[], int start, int length) throws SAXException 
	{
		super.characters(ch, start, length);
		
		try
		{			
			if (!enclosingTags.isEmpty() && products.size() > 0)
			{
				Product lastProduct = products.get(products.size() - 1);
				if (ProdXMLTags.productTitle.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					if (TextUtils.isEmpty(lastProduct.title))
						lastProduct.title = s;
					else 
						lastProduct.title += s;
				}
				else if (ProdXMLTags.productCategory.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					if (TextUtils.isEmpty(lastProduct.category))
						lastProduct.category = s;
					else 
						lastProduct.category += s;
				}
				else if (ProdXMLTags.productSubTitle.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					if (TextUtils.isEmpty(lastProduct.subtitle))
						lastProduct.subtitle = s;
					else 
						lastProduct.subtitle += s;
				}
				else if (ProdXMLTags.productCategory.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					if (TextUtils.isEmpty(lastProduct.category))
						lastProduct.category = s;
					else 
						lastProduct.category += s;
				}
				else if (ProdXMLTags.productDescription.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					if (TextUtils.isEmpty(lastProduct.description))
						lastProduct.description = s;
					else 
						lastProduct.description += s;
				}
				else if (ProdXMLTags.pointTitle.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					Product.Point point = lastProduct.points.get(lastProduct.points.size() - 1);
					if (TextUtils.isEmpty(point.title))
						point.title = s;
					else 
						point.title += s;
				}
				else if (ProdXMLTags.pointNotes.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					Product.Point point = lastProduct.points.get(lastProduct.points.size() - 1);
					if (TextUtils.isEmpty(point.notes))
						point.notes = s;
					else 
						point.notes += s;
				}
				else if (ProdXMLTags.pointDescription.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					Product.Point point = lastProduct.points.get(lastProduct.points.size() - 1);
					String str = point.descriptions.get(point.descriptions.size() - 1) + s;
					point.descriptions.set(point.descriptions.size() - 1, str);
				}
				else if (ProdXMLTags.appPremiumLTV.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					Product.Premium premium = lastProduct.premiums.get(lastProduct.premiums.size() - 1);
					premium.ltv = s;
				}
				else if (ProdXMLTags.appSinglePremium.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					Product.Premium premium = lastProduct.premiums.get(lastProduct.premiums.size() - 1);
					premium.singlePremium = s;
				}
				else if (ProdXMLTags.appPremiumTopUp.equals(enclosingTags.peek()))
				{
					String s = new String(ch, start, length);
					Product.Premium premium = lastProduct.premiums.get(lastProduct.premiums.size() - 1);
					premium.topUp = s;
				}
			}
		}
		catch (Exception ex)
		{
			Log.e("NewsXMLHandler", "XMLError", ex);
			throw new SAXException(ex);
		}
 
    }	

}

