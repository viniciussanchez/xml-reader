unit Xml.Reader.Attribute.Intf;

interface

type
  IXmlAttribute = interface
    ['{9ABACA38-3FBF-4107-8263-03E2AA87C3E6}']
    function Name: string; overload;
    function Name(const AName: string): IXmlAttribute; overload;
    function Value: Variant; overload;
    function Value(const AValue: Variant): IXmlAttribute; overload;
    function AsString: string;
    function AsInteger: Integer;
  end;

implementation

end.
