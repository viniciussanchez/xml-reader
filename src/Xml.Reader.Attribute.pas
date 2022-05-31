unit Xml.Reader.Attribute;

interface

uses Xml.Reader.Attribute.Intf;

type
  TXmlAttribute = class(TInterfacedObject, IXmlAttribute)
  private
    FName: string;
    FValue: Variant;
    function Name: string; overload;
    function Name(const AName: string): IXmlAttribute; overload;
    function Value: Variant; overload;
    function Value(const AValue: Variant): IXmlAttribute; overload;
    function AsString: string;
    function AsInteger: Integer;
  public
    class function New: IXmlAttribute;
  end;

implementation

uses System.Variants, System.SysUtils;

{ TXmlAttribute }

function TXmlAttribute.AsInteger: Integer;
begin
  Result := 0;
  if VarIsNumeric(FValue) then
    Result := FValue;
end;

function TXmlAttribute.AsString: string;
begin
  Result := EmptyStr;
  if VarIsStr(FValue) then
    Result := FValue;
end;

function TXmlAttribute.Name: string;
begin
  Result := FName;
end;

function TXmlAttribute.Name(const AName: string): IXmlAttribute;
begin
  FName := AName;
  Result := Self;
end;

class function TXmlAttribute.New: IXmlAttribute;
begin
  Result := TXmlAttribute.Create;
end;

function TXmlAttribute.Value(const AValue: Variant): IXmlAttribute;
begin
  FValue := AValue;
  Result := Self;
end;

function TXmlAttribute.Value: Variant;
begin
  Result := FValue;
end;

end.
