unit Xml.Reader.Intf;

interface

uses Xml.Reader.Node.Intf;

type
  IXmlReader = interface
    ['{B0700246-D6CF-4CA2-8AD8-5AAD0B317C8D}']
    function LoadFromString(const AXml: string): IXmlReader;
    function LoadFromFile(const APath: string): IXmlReader;
    function Node: IXmlNode;
    function Version: string;
    function Encoding: string;
  end;

implementation

end.
