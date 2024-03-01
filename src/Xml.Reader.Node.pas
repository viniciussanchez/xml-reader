unit Xml.Reader.Node;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses Xml.Reader.Node.Intf, Xml.Reader.Attribute.Intf, Xml.Reader.Element.Intf,
{$IF DEFINED(FPC)}
  Generics.Collections;
{$ELSE}
  System.Generics.Collections;
{$ENDIF}

type
  TXmlNode = class(TInterfacedObject, IXmlNode)
  private
    FName: string;
    FOwner: IXmlNode;
    FAttributes: TList<IXmlAttribute>;
    FNodes: TList<IXmlNode>;
    FElements: TList<IXmlElement>;
    function Owner: IXmlNode;
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
  public
    constructor Create; overload;
    constructor Create(const AOwner: IXmlNode); overload;
    class function New(const AOwner: IXmlNode): IXmlNode; overload;
    class function New: IXmlNode; overload;
    destructor Destroy; override;
  end;

implementation

{ TXmlNode }

uses Xml.Reader.Element, Xml.Reader.Attribute;

function TXmlNode.Attributes: TList<IXmlAttribute>;
begin
  Result := FAttributes;
end;

function TXmlNode.ContainsAttribute(const AAttributeName: string): Boolean;
var
  LAttribute: IXmlAttribute;
begin
  Result := False;
  for LAttribute in FAttributes do
  begin
    Result := LAttribute.Name = AAttributeName;
    if Result then
      Break;
  end;
end;

function TXmlNode.ContainsElement(const AElementName: string): Boolean;
var
  LElement: IXmlElement;
begin
  Result := False;
  for LElement in FElements do
  begin
    Result := LElement.Name = AElementName;
    if Result then
      Break;
  end;
end;

function TXmlNode.ContainsNode(const ANodeName: string): Boolean;
var
  LNode: IXmlNode;
begin
  Result := False;
  for LNode in FNodes do
  begin
    Result := LNode.Name = ANodeName;
    if Result then
      Break;
  end;
end;

constructor TXmlNode.Create(const AOwner: IXmlNode);
begin
  FOwner := AOwner;
  FAttributes := TList<IXmlAttribute>.Create;
  FNodes := TList<IXmlNode>.Create;
  FElements := TList<IXmlElement>.Create;
end;

constructor TXmlNode.Create;
begin
  Create(nil);
end;

destructor TXmlNode.Destroy;
begin
  if Assigned(FAttributes) then
    FAttributes.Free;
  if Assigned(FNodes) then
    FNodes.Free;
  if Assigned(FElements) then
    FElements.Free;
  inherited;
end;

function TXmlNode.Elements: TList<IXmlElement>;
begin
  Result := FElements;
end;

function TXmlNode.GetAttribute(const AAttributeName: string): IXmlAttribute;
var
  LAttribute: IXmlAttribute;
begin
  for LAttribute in FAttributes do
  begin
    if LAttribute.Name = AAttributeName then
    begin
      Result := LAttribute;
      Break;
    end;
  end;
  if Result = nil then
    Result := TXmlAttribute.New;
end;

function TXmlNode.GetElement(const AElementName: string): IXmlElement;
var
  LElement: IXmlElement;
begin
  for LElement in FElements do
  begin
    if LElement.Name = AElementName then
    begin
      Result := LElement;
      Break;
    end;
  end;
  if Result = nil then
    Result := TXmlElement.New;
end;

function TXmlNode.GetNode(const ANodeName: string): IXmlNode;
var
  LNode: IXmlNode;
begin
  for LNode in FNodes do
  begin
    if LNode.Name = ANodeName then
    begin
      Result := LNode;
      Break;
    end;
  end;
  if Result = nil then
    Result := TXmlNode.New;
end;

function TXmlNode.Name: string;
begin
  Result := FName;
end;

function TXmlNode.Name(const AName: string): IXmlNode;
begin
  FName := AName;
  Result := Self;
end;

class function TXmlNode.New(const AOwner: IXmlNode): IXmlNode;
begin
  Result := TXmlNode.Create(AOwner);
end;

class function TXmlNode.New: IXmlNode;
begin
  Result := TXmlNode.Create;
end;

function TXmlNode.Nodes: TList<IXmlNode>;
begin
  Result := FNodes;
end;

function TXmlNode.Owner: IXmlNode;
begin
  Result := FOwner;
end;

end.
