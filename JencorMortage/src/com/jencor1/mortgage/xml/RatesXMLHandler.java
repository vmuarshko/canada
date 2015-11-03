package com.jencor1.mortgage.xml;

import java.util.ArrayList;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;

import android.util.Log;

public class RatesXMLHandler extends XMLBaseHandler
{
	public class LenderRate
	{
		public String mortType;
		public String ourRate;
		public String dateChanged; 
		public String mortgageType; 
	}
	
	public ArrayList<RatesXMLHandler.LenderRate> lenderRates = new ArrayList<RatesXMLHandler.LenderRate>();
	
	@Override
	public void startDocument() throws SAXException 
	{
		super.startDocument();
	}	
	
	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		super.startElement(uri, localName, qName, attributes);
		
		try
		{
			if (localName.equals(RatesXMLTags.RateRoot))
			{
				lenderRates.add(new LenderRate());
			}
		}
		catch (Exception ex)
		{
			Log.e("RatesXMLHandler", "XMLError", ex);
			throw new SAXException(ex);
		}
	}

	@Override
	public void characters(char ch[], int start, int length) throws SAXException 
	{
		super.characters(ch, start, length);
		
		try
		{			
			if (!enclosingTags.isEmpty() && lenderRates.size() > 0)
			{
				if (RatesXMLTags.mortType.equals(enclosingTags.peek()))
				{
					lenderRates.get(lenderRates.size() - 1).mortType = new String(ch, start, length);
				}
				else if (RatesXMLTags.mortgageType.equals(enclosingTags.peek()))
				{
					lenderRates.get(lenderRates.size() - 1).mortgageType = new String(ch, start, length);
				}
				else if (RatesXMLTags.ourRate.equals(enclosingTags.peek()))
				{
					lenderRates.get(lenderRates.size() - 1).ourRate = new String(ch, start, length);
				}
				else if (RatesXMLTags.dateChanged.equals(enclosingTags.peek()))
				{
					lenderRates.get(lenderRates.size() - 1).dateChanged = new String(ch, start, length); 
				}
			}
		}
		catch (Exception ex)
		{
			Log.e("RatesXMLHandler", "XMLError", ex);
			throw new SAXException(ex);
		}
 
    }	

}

