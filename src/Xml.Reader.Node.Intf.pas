unit Xml.Reader.Node.Intf;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses Xml.Reader.Element.Intf, Xml.Reader.Attribute.Intf,
{$IF DEFINED(FPC)}
  Generics.Collections;
{$ELSE}
  System.Generics.Collections;
{$ENDIF}

type
  IXmlNode = interface
    ['{4E1C725C-EFF4-43AB-820D-C3438A41D140}']
    function GetAttribute(const AAttributeName: string): IXmlAttribute;
    function GetNode(const ANodeName: string): IXmlNode;
    function GetElement(const AElementName: string): IXmlElement;
    function Attributes: TList<IXmlAttribute>;
    function Nodes: TList<IXmlNode>;
    function Elements: TList<IXmlElement>;
    function ContainsAttribute(const AAttributeName: string): Boolean;
    function ContainsNode(const ANodeName: string): Boolean;
    function ContainsElement(const AElementName: string): Boolean;
    function Name: string; overload;
    function Name(const AName: string): IXmlNode; overload;
  end;

implementation

end.
