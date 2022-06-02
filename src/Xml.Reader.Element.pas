unit Xml.Reader.Element;

{$IF DEFINED(FPC)}
  {$MODE DELPHI}{$H+}
{$ENDIF}

interface

uses Xml.Reader.Element.Intf;

type
  TXmlElement = class(TInterfacedObject, IXmlElement)
  private
    FName: string;
    FValue: Variant;
    function Name: string; overload;
    function Name(const AName: string): IXmlElement; overload;
    function Value: Variant; overload;
    function Value(const AValue: Variant): IXmlElement; overload;
    function AsString: string;
    function AsInteger: Integer;
  public
    class function New: IXmlElement;
  end;

implementation

uses
{$IF DEFINED(FPC)}
  Variants, SysUtils;
{$ELSE}
  System.Variants, System.SysUtils;
{$ENDIF}

{ TXmlElement }

function TXmlElement.AsInteger: Integer;
begin
  Result := 0;
  if VarIsNumeric(FValue) then
    Result := FValue;
end;

function TXmlElement.AsString: string;
begin
  Result := EmptyStr;
  if VarIsStr(FValue) then
    Result := FValue;
end;

function TXmlElement.Name: string;
begin
  Result := FName;
end;

function TXmlElement.Name(const AName: string): IXmlElement;
begin
  FName := AName;
  Result := Self;
end;

class function TXmlElement.New: IXmlElement;
begin
  Result := TXmlElement.Create;
end;

function TXmlElement.Value(const AValue: Variant): IXmlElement;
begin
  FValue := AValue;
  Result := Self;
end;

function TXmlElement.Value: Variant;
begin
  Result := FValue;
end;

end.
