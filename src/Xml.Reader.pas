unit Xml.Reader;

interface

uses Xml.Reader.Intf, Xml.Reader.Attribute.Intf, Xml.Reader.Element.Intf, Xml.Reader.Node.Intf,
  System.Classes, System.Generics.Collections;

type
  IXmlReader = Xml.Reader.Intf.IXmlReader;
  IXmlNode = Xml.Reader.Node.Intf.IXmlNode;
  IXmlElement = Xml.Reader.Element.Intf.IXmlElement;
  IXmlAttribute = Xml.Reader.Attribute.Intf.IXmlAttribute;

  TXmlReader = class(TInterfacedObject, IXmlReader)
  private
    FVersion: string;
    FEncoding: string;
    FNode: IXmlNode;
    procedure ReadXmlInfo(const AXml: string);
    procedure ParseXml(const AXml: TStringList);
    procedure ParseNode(const ANode: IXmlNode; const AXml: string);
    function GetNameXmlValue(const AXml: string): string;
    function GetAttributes(const AXml: string): TDictionary<string, string>;
    function LoadFromString(const AXml: string): IXmlReader;
    function LoadFromFile(const APath: string): IXmlReader;
    function Node: IXmlNode;
    function Version: string;
    function Encoding: string;
  public
    constructor Create;
    class function New: IXmlReader;
  end;

implementation

uses Xml.Reader.Attribute, Xml.Reader.Element, Xml.Reader.Node,
  System.SysUtils;

{ TXmlReader }

constructor TXmlReader.Create;
begin
  FNode := TXmlNode.New;
end;

function TXmlReader.Encoding: string;
begin
  Result := FEncoding;
end;

function TXmlReader.LoadFromFile(const APath: string): IXmlReader;
var
  LXml: TStringList;
begin
  LXml := TStringList.Create;
  try
    LXml.LoadFromFile(APath);
    Result := LoadFromString(LXml.Text);
  finally
    LXml.Free;
  end;
end;

function TXmlReader.LoadFromString(const AXml: string): IXmlReader;
var
  I: Int64;
  LClearXml, LLine, LLineTrim: string;
  LXml: TStringList;
begin
  Result := Self;
  LXml := TStringList.Create;
  try
    LLine := EmptyStr;
    LClearXml := AXml.Replace(#0, EmptyStr);
    for I := 1 to Length(LClearXml) do
    begin
      LLine := LLine + LClearXml[I];
      LLineTrim := LLine.Trim;
      if LLineTrim.StartsWith('<') and LLineTrim.EndsWith('>') then
      begin
        LXml.Add(LLineTrim);
        LLine := EmptyStr;
      end
      else if LLineTrim.EndsWith('<') and (LLineTrim.Length > 1) then
      begin
        LXml.Add(LLineTrim.Replace('<', EmptyStr));
        LLine := '<';
      end;
    end;
    ParseXml(LXml);
  finally
    LXml.Free;
  end;
end;

class function TXmlReader.New: IXmlReader;
begin
  Result := TXmlReader.Create;
end;

function TXmlReader.Node: IXmlNode;
begin
  Result := FNode;
end;

function TXmlReader.GetAttributes(const AXml: string): TDictionary<string, string>;
var
  I: Integer;
  LKey, LValue: string;
  LReadingValue: Boolean;
begin
  LReadingValue := False;
  Result := TDictionary<string, string>.Create();
  for I := 1 to AXml.Length do
  begin
    if LReadingValue then
    begin
      if AXml[I] = '"' then
      begin
        if LValue.IsEmpty then
          Continue;
        Result.Add(LKey, LValue);
        LReadingValue := False;
        LValue := EmptyStr;
        LKey := EmptyStr;
        Continue;
      end;
      LValue := LValue + AXml[I];
      Continue;
    end;
    LReadingValue := AXml[I] = '=';
    if LReadingValue then
      Continue;
    if AXml[I] = ' ' then
      LKey := EmptyStr
    else
      LKey := LKey + AXml[I];
  end;
end;

function TXmlReader.GetNameXmlValue(const AXml: string): string;
var
  I: Integer;
begin
  Result := EmptyStr;
  for I := 1 to AXml.Length do
  begin
    if (AXml[I] = '<') or ((AXml[I] = '>')) then
      Continue;
    if (AXml[I] = '/') and (AXml[Pred(I)] = '<') then
      Continue;
    if (AXml[I] = ' ') and (not Result.Trim.IsEmpty) then
      Break;
    Result := Result + AXml[I];
  end;
  Result := Result.Trim;
end;

procedure TXmlReader.ParseNode(const ANode: IXmlNode; const AXml: string);
var
  LAttribute: TPair<string, string>;
  LAttributes: TDictionary<string, string>;
begin
  LAttributes := GetAttributes(AXml);
  try
    ANode.Name(GetNameXmlValue(AXml));
    for LAttribute in LAttributes do
      ANode.Attributes.Add(TXmlAttribute.New.Name(LAttribute.Key).Value(LAttribute.Value));
  finally
    LAttributes.Free;
  end;
end;

procedure TXmlReader.ParseXml(const AXml: TStringList);
var
  I: Integer;
  LLastNode: IXmlNode;
  LLastElement: IXmlElement;
begin
  for I := 0 to Pred(AXml.Count) do
  begin
    if AXml[I].StartsWith('</') then
      Continue;
    if AXml[I].StartsWith('<?') then
      ReadXmlInfo(AXml[I])
    else if AXml[I].StartsWith('<') and AXml[I].EndsWith('>') then
    begin
      if AXml[Succ(I)].StartsWith('<') then
      begin
        if FNode.Name.Trim.IsEmpty then
          LLastNode := FNode
        else
          LLastNode := TXmlNode.New;
        ParseNode(LLastNode, AXml[I]);
      end
      else
      begin
        LLastElement := TXmlElement.New.Name(GetNameXmlValue(AXml[I]));
        LLastNode.Elements.Add(LLastElement);
      end;
    end
//    else if AXml[I].EndsWith('/>') then
//    begin
//      // element without value
//    end
    else
    begin
      // element value
    end;
  end;
end;

procedure TXmlReader.ReadXmlInfo(const AXml: string);
var
  LAttribute: TPair<string, string>;
  LAttributes: TDictionary<string, string>;
begin
  LAttributes := GetAttributes(AXml);
  try
    for LAttribute in LAttributes do
    begin
      if LAttribute.Key.ToLower.Equals('version') then
        FVersion := LAttribute.Value
      else if LAttribute.Key.ToLower.Equals('encoding') then
        FEncoding := LAttribute.Value;
    end;
  finally
    LAttributes.Free;
  end;
end;

function TXmlReader.Version: string;
begin
  Result := FVersion;
end;

end.
