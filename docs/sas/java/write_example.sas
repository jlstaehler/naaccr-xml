/************************************************************************************************************;
    This programs demonstrates how to include and call the "write_naaccr_xml_macro.sas" macro.

    While it's possible to use the write macro without the read one, they are really meant to be used together.

    This example assumes that the JAR file is in the same folder as this program.

    Make sure that the naaccrVersion and recordType are correct or some data items won't be correctly populated.

    This example references an extra user-defined dictionary that defines non-standard NAACCR data items. If
    your data file only contains standard data items, that dictionary is not needed. Otherwise the dictionary
    should have been provided by the organization that created the XML data file. Dictionaries are usually
    in XML files, but for technical reasons, the macro expects them in CSV files; the NAACCR XML Tool that
    is distributed with the macros has an option to load a dictionary and save it as CSV. For writing proper
    XML files, the macro also need the dictionary URI; since the CSV format doesn't contain that URI, it needs
    to be provided as a parameter. The URI can be found as a root attribute of the XML dictionary (it usually
    looks like an internet address, but it's rarely a legit address).

 ************************************************************************************************************/;

%include "read_naaccr_xml_macro.sas";
%readNaaccrXml(
  libpath="naaccr-xml-6.7-sas.jar",
  sourcefile="synthetic-data_naaccr-180-incidence_10-tumors.xml",
  naaccrversion="180", 
  recordtype="I",
  dataset=fromxml,
  dictfile="my-own-dictionary.csv"
);

proc freq data=fromxml;
    tables primarySite;
run;


%include "write_naaccr_xml_macro.sas";
%writeNaaccrXml(
  libpath="naaccr-xml-6.7-sas.jar",
  targetfile="test.xml.gz",
  naaccrversion="180", 
  recordtype="I",
  dataset=fromxml,
  dictfile="my-own-dictionary.csv",
  dictUri="https://my.organization/naaccrxml/my-own-dictionary.xml"
);
