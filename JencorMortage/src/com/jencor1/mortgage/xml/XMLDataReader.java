package com.jencor1.mortgage.xml;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;

public class XMLDataReader
{
	public static void readFromXML(InputStream is, XMLBaseHandler handler) throws Exception
	{
		BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
		
		// Hotfix: skip <?xml version="1.0" encoding="UTF-8"?> message
		int c;
		while ((c = reader.read()) >= 0)
			if (c == '>') break;
		
	  	/* Handling XML */
		SAXParserFactory spf = SAXParserFactory.newInstance();
		SAXParser sp = spf.newSAXParser();
		XMLReader xr = sp.getXMLReader();
		xr.setErrorHandler(new XMLDataErrorHandler());

		xr.setContentHandler(handler);
		xr.parse(new InputSource(reader));				
	}
}
