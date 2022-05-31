unit Xml.Reader.Element.Intf;

interface

type
  IXmlElement = interface
    ['{920ADF7E-DB8C-4A9A-919A-02C49BD618F4}']
    function Name: string; overload;
    function Name(const AName: string): IXmlElement; overload;
    function Value: Variant; overload;
    function Value(const AValue: Variant): IXmlElement; overload;
    function AsString: string;
    function AsInteger: Integer;
  end;

implementation

end.
