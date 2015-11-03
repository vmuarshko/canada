package com.skyfinancial1.canadamortgage.xml;

import java.util.Stack;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

public class XMLBaseHandler extends DefaultHandler
{	
	protected Stack<String> enclosingTags = new Stack<String>();
	
	@Override
	public void startDocument() throws SAXException 
	{
		super.startDocument();

		enclosingTags.clear();
	}

	@Override
	public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException
	{
		super.startElement(uri, localName, qName, attributes);
				
		enclosingTags.push(localName);		
	}

	@Override
	public void characters(char ch[], int start, int length) throws SAXException 
	{
		super.characters(ch, start, length);
    }	
	
	@Override
	public void endElement(String uri, String localName, String qName) throws SAXException
	{
		enclosingTags.pop();		
		super.endElement(uri, localName, qName);
	}		
	
	@Override
	public void endDocument() throws SAXException 
	{
	}	
	
}
