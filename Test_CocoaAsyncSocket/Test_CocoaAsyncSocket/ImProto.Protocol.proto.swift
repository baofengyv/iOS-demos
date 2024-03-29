// Generated by the protocol buffer compiler.  DO NOT EDIT!
// Source file Protocol.proto

import Foundation
import ProtocolBuffers


public extension ImProto{}

public func == (lhs: ImProto.Im, rhs: ImProto.Im) -> Bool {
  if (lhs === rhs) {
    return true
  }
  var fieldCheck:Bool = (lhs.hashValue == rhs.hashValue)
  fieldCheck = fieldCheck && (lhs.hasLength == rhs.hasLength) && (!lhs.hasLength || lhs.length == rhs.length)
  fieldCheck = fieldCheck && (lhs.hasHeader == rhs.hasHeader) && (!lhs.hasHeader || lhs.header == rhs.header)
  fieldCheck = fieldCheck && (lhs.hasBody == rhs.hasBody) && (!lhs.hasBody || lhs.body == rhs.body)
  fieldCheck = (fieldCheck && (lhs.unknownFields == rhs.unknownFields))
  return fieldCheck
}

public extension ImProto {
  public struct ProtocolRoot {
    public static var sharedInstance : ProtocolRoot {
     struct Static {
         static let instance : ProtocolRoot = ProtocolRoot()
     }
     return Static.instance
    }
    public var extensionRegistry:ExtensionRegistry

    init() {
      extensionRegistry = ExtensionRegistry()
      registerAllExtensions(extensionRegistry)
      ImProto.HeaderRoot.sharedInstance.registerAllExtensions(extensionRegistry)
      ImProto.BodyRoot.sharedInstance.registerAllExtensions(extensionRegistry)
    }
    public func registerAllExtensions(registry:ExtensionRegistry) {
    }
  }

  final public class Im : GeneratedMessage, GeneratedMessageProtocol {
    public private(set) var length:Int32 = Int32(0)

    public private(set) var hasLength:Bool = false
    public private(set) var header:ImProto.Header!
    public private(set) var hasHeader:Bool = false
    public private(set) var body:ImProto.Body!
    public private(set) var hasBody:Bool = false
    required public init() {
         super.init()
    }
    override public func isInitialized() -> Bool {
      if !hasHeader {
        return false
      }
      if !header.isInitialized() {
        return false
      }
      if hasBody {
       if !body.isInitialized() {
         return false
       }
      }
     return true
    }
    override public func writeToCodedOutputStream(output:CodedOutputStream) throws {
      if hasLength {
        try output.writeInt32(1, value:length)
      }
      if hasHeader {
        try output.writeMessage(2, value:header)
      }
      if hasBody {
        try output.writeMessage(3, value:body)
      }
      try unknownFields.writeToCodedOutputStream(output)
    }
    override public func serializedSize() -> Int32 {
      var serialize_size:Int32 = memoizedSerializedSize
      if serialize_size != -1 {
       return serialize_size
      }

      serialize_size = 0
      if hasLength {
        serialize_size += length.computeInt32Size(1)
      }
      if hasHeader {
          if let varSizeheader = header?.computeMessageSize(2) {
              serialize_size += varSizeheader
          }
      }
      if hasBody {
          if let varSizebody = body?.computeMessageSize(3) {
              serialize_size += varSizebody
          }
      }
      serialize_size += unknownFields.serializedSize()
      memoizedSerializedSize = serialize_size
      return serialize_size
    }
    public class func parseArrayDelimitedFromInputStream(input:NSInputStream) throws -> Array<ImProto.Im> {
      var mergedArray = Array<ImProto.Im>()
      while let value = try parseFromDelimitedFromInputStream(input) {
        mergedArray += [value]
      }
      return mergedArray
    }
    public class func parseFromDelimitedFromInputStream(input:NSInputStream) throws -> ImProto.Im? {
      return try ImProto.Im.Builder().mergeDelimitedFromInputStream(input)?.build()
    }
    public class func parseFromData(data:NSData) throws -> ImProto.Im {
      return try ImProto.Im.Builder().mergeFromData(data, extensionRegistry:ImProto.ProtocolRoot.sharedInstance.extensionRegistry).build()
    }
    public class func parseFromData(data:NSData, extensionRegistry:ExtensionRegistry) throws -> ImProto.Im {
      return try ImProto.Im.Builder().mergeFromData(data, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFromInputStream(input:NSInputStream) throws -> ImProto.Im {
      return try ImProto.Im.Builder().mergeFromInputStream(input).build()
    }
    public class func parseFromInputStream(input:NSInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.Im {
      return try ImProto.Im.Builder().mergeFromInputStream(input, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFromCodedInputStream(input:CodedInputStream) throws -> ImProto.Im {
      return try ImProto.Im.Builder().mergeFromCodedInputStream(input).build()
    }
    public class func parseFromCodedInputStream(input:CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.Im {
      return try ImProto.Im.Builder().mergeFromCodedInputStream(input, extensionRegistry:extensionRegistry).build()
    }
    public class func getBuilder() -> ImProto.Im.Builder {
      return ImProto.Im.classBuilder() as! ImProto.Im.Builder
    }
    public func getBuilder() -> ImProto.Im.Builder {
      return classBuilder() as! ImProto.Im.Builder
    }
    public override class func classBuilder() -> MessageBuilder {
      return ImProto.Im.Builder()
    }
    public override func classBuilder() -> MessageBuilder {
      return ImProto.Im.Builder()
    }
    public func toBuilder() throws -> ImProto.Im.Builder {
      return try ImProto.Im.builderWithPrototype(self)
    }
    public class func builderWithPrototype(prototype:ImProto.Im) throws -> ImProto.Im.Builder {
      return try ImProto.Im.Builder().mergeFrom(prototype)
    }
    override public func getDescription(indent:String) throws -> String {
      var output:String = ""
      if hasLength {
        output += "\(indent) length: \(length) \n"
      }
      if hasHeader {
        output += "\(indent) header {\n"
        if let outDescHeader = header {
          output += try outDescHeader.getDescription("\(indent)  ")
        }
        output += "\(indent) }\n"
      }
      if hasBody {
        output += "\(indent) body {\n"
        if let outDescBody = body {
          output += try outDescBody.getDescription("\(indent)  ")
        }
        output += "\(indent) }\n"
      }
      output += unknownFields.getDescription(indent)
      return output
    }
    override public var hashValue:Int {
        get {
            var hashCode:Int = 7
            if hasLength {
               hashCode = (hashCode &* 31) &+ length.hashValue
            }
            if hasHeader {
                if let hashValueheader = header?.hashValue {
                    hashCode = (hashCode &* 31) &+ hashValueheader
                }
            }
            if hasBody {
                if let hashValuebody = body?.hashValue {
                    hashCode = (hashCode &* 31) &+ hashValuebody
                }
            }
            hashCode = (hashCode &* 31) &+  unknownFields.hashValue
            return hashCode
        }
    }


    //Meta information declaration start

    override public class func className() -> String {
        return "ImProto.Im"
    }
    override public func className() -> String {
        return "ImProto.Im"
    }
    override public func classMetaType() -> GeneratedMessage.Type {
        return ImProto.Im.self
    }
    //Meta information declaration end

    final public class Builder : GeneratedMessageBuilder {
      private var builderResult:ImProto.Im = ImProto.Im()
      public func getMessage() -> ImProto.Im {
          return builderResult
      }

      required override public init () {
         super.init()
      }
      public var hasLength:Bool {
           get {
                return builderResult.hasLength
           }
      }
      public var length:Int32 {
           get {
                return builderResult.length
           }
           set (value) {
               builderResult.hasLength = true
               builderResult.length = value
           }
      }
      public func setLength(value:Int32) -> ImProto.Im.Builder {
        self.length = value
        return self
      }
      public func clearLength() -> ImProto.Im.Builder{
           builderResult.hasLength = false
           builderResult.length = Int32(0)
           return self
      }
      public var hasHeader:Bool {
           get {
               return builderResult.hasHeader
           }
      }
      public var header:ImProto.Header! {
           get {
               if headerBuilder_ != nil {
                  builderResult.header = headerBuilder_.getMessage()
               }
               return builderResult.header
           }
           set (value) {
               builderResult.hasHeader = true
               builderResult.header = value
           }
      }
      private var headerBuilder_:ImProto.Header.Builder! {
           didSet {
              builderResult.hasHeader = true
           }
      }
      public func getHeaderBuilder() -> ImProto.Header.Builder {
        if headerBuilder_ == nil {
           headerBuilder_ = ImProto.Header.Builder()
           builderResult.header = headerBuilder_.getMessage()
           if header != nil {
              try! headerBuilder_.mergeFrom(header)
           }
        }
        return headerBuilder_
      }
      public func setHeader(value:ImProto.Header!) -> ImProto.Im.Builder {
        self.header = value
        return self
      }
      public func mergeHeader(value:ImProto.Header) throws -> ImProto.Im.Builder {
        if builderResult.hasHeader {
          builderResult.header = try ImProto.Header.builderWithPrototype(builderResult.header).mergeFrom(value).buildPartial()
        } else {
          builderResult.header = value
        }
        builderResult.hasHeader = true
        return self
      }
      public func clearHeader() -> ImProto.Im.Builder {
        headerBuilder_ = nil
        builderResult.hasHeader = false
        builderResult.header = nil
        return self
      }
      public var hasBody:Bool {
           get {
               return builderResult.hasBody
           }
      }
      public var body:ImProto.Body! {
           get {
               if bodyBuilder_ != nil {
                  builderResult.body = bodyBuilder_.getMessage()
               }
               return builderResult.body
           }
           set (value) {
               builderResult.hasBody = true
               builderResult.body = value
           }
      }
      private var bodyBuilder_:ImProto.Body.Builder! {
           didSet {
              builderResult.hasBody = true
           }
      }
      public func getBodyBuilder() -> ImProto.Body.Builder {
        if bodyBuilder_ == nil {
           bodyBuilder_ = ImProto.Body.Builder()
           builderResult.body = bodyBuilder_.getMessage()
           if body != nil {
              try! bodyBuilder_.mergeFrom(body)
           }
        }
        return bodyBuilder_
      }
      public func setBody(value:ImProto.Body!) -> ImProto.Im.Builder {
        self.body = value
        return self
      }
      public func mergeBody(value:ImProto.Body) throws -> ImProto.Im.Builder {
        if builderResult.hasBody {
          builderResult.body = try ImProto.Body.builderWithPrototype(builderResult.body).mergeFrom(value).buildPartial()
        } else {
          builderResult.body = value
        }
        builderResult.hasBody = true
        return self
      }
      public func clearBody() -> ImProto.Im.Builder {
        bodyBuilder_ = nil
        builderResult.hasBody = false
        builderResult.body = nil
        return self
      }
      override public var internalGetResult:GeneratedMessage {
           get {
              return builderResult
           }
      }
      public override func clear() -> ImProto.Im.Builder {
        builderResult = ImProto.Im()
        return self
      }
      public override func clone() throws -> ImProto.Im.Builder {
        return try ImProto.Im.builderWithPrototype(builderResult)
      }
      public override func build() throws -> ImProto.Im {
           try checkInitialized()
           return buildPartial()
      }
      public func buildPartial() -> ImProto.Im {
        let returnMe:ImProto.Im = builderResult
        return returnMe
      }
      public func mergeFrom(other:ImProto.Im) throws -> ImProto.Im.Builder {
        if other == ImProto.Im() {
         return self
        }
        if other.hasLength {
             length = other.length
        }
        if (other.hasHeader) {
            try mergeHeader(other.header)
        }
        if (other.hasBody) {
            try mergeBody(other.body)
        }
        try mergeUnknownFields(other.unknownFields)
        return self
      }
      public override func mergeFromCodedInputStream(input:CodedInputStream) throws -> ImProto.Im.Builder {
           return try mergeFromCodedInputStream(input, extensionRegistry:ExtensionRegistry())
      }
      public override func mergeFromCodedInputStream(input:CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.Im.Builder {
        let unknownFieldsBuilder:UnknownFieldSet.Builder = try UnknownFieldSet.builderWithUnknownFields(self.unknownFields)
        while (true) {
          let protobufTag = try input.readTag()
          switch protobufTag {
          case 0: 
            self.unknownFields = try unknownFieldsBuilder.build()
            return self

          case 8 :
            length = try input.readInt32()

          case 18 :
            let subBuilder:ImProto.Header.Builder = ImProto.Header.Builder()
            if hasHeader {
              try subBuilder.mergeFrom(header)
            }
            try input.readMessage(subBuilder, extensionRegistry:extensionRegistry)
            header = subBuilder.buildPartial()

          case 26 :
            let subBuilder:ImProto.Body.Builder = ImProto.Body.Builder()
            if hasBody {
              try subBuilder.mergeFrom(body)
            }
            try input.readMessage(subBuilder, extensionRegistry:extensionRegistry)
            body = subBuilder.buildPartial()

          default:
            if (!(try parseUnknownField(input,unknownFields:unknownFieldsBuilder, extensionRegistry:extensionRegistry, tag:protobufTag))) {
               unknownFields = try unknownFieldsBuilder.build()
               return self
            }
          }
        }
      }
    }

  }

}

// @@protoc_insertion_point(global_scope)
