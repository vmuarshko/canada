package ca1.canadaguaranty.xml;

import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

public class XMLDataErrorHandler implements ErrorHandler
{
	public XMLDataErrorHandler() {}

	@Override
	public void warning(SAXParseException exception) throws SAXException
	{
		throw new SAXException("Error parsing XML file data: " + exception.getLocalizedMessage(), exception);
	}

	@Override
	public void error(SAXParseException exception) throws SAXException
	{
		throw new SAXException("Error parsing XML file data: " + exception.getLocalizedMessage(), exception);
	}

	@Override
	public void fatalError(SAXParseException exception) throws SAXException
	{
		throw new SAXException("Error parsing XML file data: " + exception.getLocalizedMessage(), exception);
	}
}
