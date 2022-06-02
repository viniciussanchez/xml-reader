# XML Reader

## ⚙️ Installation
Installation is done using the [`boss install`](https://github.com/HashLoad/boss) command line:
``` sh
boss install viniciussanchez/xml-reader
```

## ⚙️ Manual Installation for Delphi
If you choose to install manually, simply add the following folders to your project, in *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*
```
../xml-reader/src
```

## ⚡️ Quickstart

```pascal
uses Xml.Reader;
```

#### Load from file

```pascal
var
  LXmlReader: IXmlReader;
begin
  LXmlReader := TXmlReader.New.LoadFromFile('C:\xml\nfe.xml');
end;
```

#### Load from string

```pascal
var
  LXmlReader: IXmlReader;
begin
  LXmlReader := TXmlReader.New.LoadFromString('my xml here!');
end;
```

#### Get xml version

```pascal
begin
  Result := LXmlReader.Version;
end;
```

#### Get xml encoding

```pascal
begin
  Result := LXmlReader.Encoding;
end;
```

#### Get main node

```pascal
var
  LMainNode: IXmlNode;
begin
  LMainNode := LXmlReader.Node;
end;
```

#### How to list nodes

```pascal
var
  LNode: IXmlNode;
begin
  for LNode in LMainNode.Nodes do
    // my code here!
end;
```

#### How to list attributes

```pascal
var
  LAttribute: IXmlAttribute;
begin
  for LAttribute in LMainNode.Attributes do
    // my code here!
end;
```

#### How to list elements

```pascal
var
  LElement: IXmlElement;
begin
  for LElement in LMainNode.Elements do
    // my code here!
end;
```

#### Other resources

```pascal
var
  LNode: IXmlNode;
  LElement: IXmlElement;
  LAttribute: IXmlAttribute;
begin
  // get the name of a node
  LNode.Name;

  // check if the node has an attribute
  LNode.ContainsAttribute('attribute name');

  // check if the node has a node
  LNode.ContainsNode('node name');

  // check if the node has an element
  LNode.ContainsElement('element name');    

  // get the value of an attribute from a node
  LNode.GetAttribute('attribute name');

  // get a node from a node
  LNode.GetNode('node name');

  // get the element of a node
  LNode.GetElement('element name');

  // get the attributes of a node
  LNode.Attributes;

  // get the elements of a node
  LNode.Elements;

  // get the nodes of a node
  LNode.Nodes;

  // get the name of an element
  LElement.Name;

  // get the value of an element
  LElement.Value;  

  // get the value in string format from an element
  LElement.AsString;

  // get the value in integer format of an element
  LElement.AsInteger;

  // get the name of an attribute
  LAttribute.Name;

  // get the value of an attribute
  LAttribute.Value;  

  // get the value in string format of an attribute
  LAttribute.AsString;

  // get the value in integer format of an attribute
  LAttribute.AsInteger;
end;
```

## ⚠️ License

`XML Reader` is free and open-source software licensed under the [MIT License](https://github.com/viniciussanchez/xml-reader/blob/master/LICENSE).
