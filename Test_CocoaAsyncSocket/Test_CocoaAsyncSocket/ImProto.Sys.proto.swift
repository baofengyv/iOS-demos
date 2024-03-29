// Generated by the protocol buffer compiler.  DO NOT EDIT!
// Source file Sys.proto

import Foundation
import ProtocolBuffers


public extension ImProto{}

public func == (lhs: ImProto.SysAck, rhs: ImProto.SysAck) -> Bool {
  if (lhs === rhs) {
    return true
  }
  var fieldCheck:Bool = (lhs.hashValue == rhs.hashValue)
  fieldCheck = fieldCheck && (lhs.hasSerialNumber == rhs.hasSerialNumber) && (!lhs.hasSerialNumber || lhs.serialNumber == rhs.serialNumber)
  fieldCheck = (fieldCheck && (lhs.unknownFields == rhs.unknownFields))
  return fieldCheck
}

public func == (lhs: ImProto.SysOffConnect, rhs: ImProto.SysOffConnect) -> Bool {
  if (lhs === rhs) {
    return true
  }
  var fieldCheck:Bool = (lhs.hashValue == rhs.hashValue)
  fieldCheck = fieldCheck && (lhs.hasUserId == rhs.hasUserId) && (!lhs.hasUserId || lhs.userId == rhs.userId)
  fieldCheck = fieldCheck && (lhs.hasClientIp == rhs.hasClientIp) && (!lhs.hasClientIp || lhs.clientIp == rhs.clientIp)
  fieldCheck = fieldCheck && (lhs.hasCreateTime == rhs.hasCreateTime) && (!lhs.hasCreateTime || lhs.createTime == rhs.createTime)
  fieldCheck = (fieldCheck && (lhs.unknownFields == rhs.unknownFields))
  return fieldCheck
}

public func == (lhs: ImProto.SysNoRecordsPush, rhs: ImProto.SysNoRecordsPush) -> Bool {
  if (lhs === rhs) {
    return true
  }
  var fieldCheck:Bool = (lhs.hashValue == rhs.hashValue)
  fieldCheck = fieldCheck && (lhs.hasUserId == rhs.hasUserId) && (!lhs.hasUserId || lhs.userId == rhs.userId)
  fieldCheck = (fieldCheck && (lhs.unknownFields == rhs.unknownFields))
  return fieldCheck
}

public extension ImProto {
  public struct SysRoot {
    public static var sharedInstance : SysRoot {
     struct Static {
         static let instance : SysRoot = SysRoot()
     }
     return Static.instance
    }
    public var extensionRegistry:ExtensionRegistry

    init() {
      extensionRegistry = ExtensionRegistry()
      registerAllExtensions(extensionRegistry)
      ImProto.BaseDefineRoot.sharedInstance.registerAllExtensions(extensionRegistry)
    }
    public func registerAllExtensions(registry:ExtensionRegistry) {
    }
  }

  // 系统自动回执
  final public class SysAck : GeneratedMessage, GeneratedMessageProtocol {
    public private(set) var serialNumber:UInt32 = UInt32(0)

    public private(set) var hasSerialNumber:Bool = false
    required public init() {
         super.init()
    }
    override public func isInitialized() -> Bool {
      if !hasSerialNumber {
        return false
      }
     return true
    }
    override public func writeToCodedOutputStream(output:CodedOutputStream) throws {
      if hasSerialNumber {
        try output.writeUInt32(1, value:serialNumber)
      }
      try unknownFields.writeToCodedOutputStream(output)
    }
    override public func serializedSize() -> Int32 {
      var serialize_size:Int32 = memoizedSerializedSize
      if serialize_size != -1 {
       return serialize_size
      }

      serialize_size = 0
      if hasSerialNumber {
        serialize_size += serialNumber.computeUInt32Size(1)
      }
      serialize_size += unknownFields.serializedSize()
      memoizedSerializedSize = serialize_size
      return serialize_size
    }
    public class func parseArrayDelimitedFromInputStream(input:NSInputStream) throws -> Array<ImProto.SysAck> {
      var mergedArray = Array<ImProto.SysAck>()
      while let value = try parseFromDelimitedFromInputStream(input) {
        mergedArray += [value]
      }
      return mergedArray
    }
    public class func parseFromDelimitedFromInputStream(input:NSInputStream) throws -> ImProto.SysAck? {
      return try ImProto.SysAck.Builder().mergeDelimitedFromInputStream(input)?.build()
    }
    public class func parseFromData(data:NSData) throws -> ImProto.SysAck {
      return try ImProto.SysAck.Builder().mergeFromData(data, extensionRegistry:ImProto.SysRoot.sharedInstance.extensionRegistry).build()
    }
    public class func parseFromData(data:NSData, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysAck {
      return try ImProto.SysAck.Builder().mergeFromData(data, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFromInputStream(input:NSInputStream) throws -> ImProto.SysAck {
      return try ImProto.SysAck.Builder().mergeFromInputStream(input).build()
    }
    public class func parseFromInputStream(input:NSInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysAck {
      return try ImProto.SysAck.Builder().mergeFromInputStream(input, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFromCodedInputStream(input:CodedInputStream) throws -> ImProto.SysAck {
      return try ImProto.SysAck.Builder().mergeFromCodedInputStream(input).build()
    }
    public class func parseFromCodedInputStream(input:CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysAck {
      return try ImProto.SysAck.Builder().mergeFromCodedInputStream(input, extensionRegistry:extensionRegistry).build()
    }
    public class func getBuilder() -> ImProto.SysAck.Builder {
      return ImProto.SysAck.classBuilder() as! ImProto.SysAck.Builder
    }
    public func getBuilder() -> ImProto.SysAck.Builder {
      return classBuilder() as! ImProto.SysAck.Builder
    }
    public override class func classBuilder() -> MessageBuilder {
      return ImProto.SysAck.Builder()
    }
    public override func classBuilder() -> MessageBuilder {
      return ImProto.SysAck.Builder()
    }
    public func toBuilder() throws -> ImProto.SysAck.Builder {
      return try ImProto.SysAck.builderWithPrototype(self)
    }
    public class func builderWithPrototype(prototype:ImProto.SysAck) throws -> ImProto.SysAck.Builder {
      return try ImProto.SysAck.Builder().mergeFrom(prototype)
    }
    override public func getDescription(indent:String) throws -> String {
      var output:String = ""
      if hasSerialNumber {
        output += "\(indent) serialNumber: \(serialNumber) \n"
      }
      output += unknownFields.getDescription(indent)
      return output
    }
    override public var hashValue:Int {
        get {
            var hashCode:Int = 7
            if hasSerialNumber {
               hashCode = (hashCode &* 31) &+ serialNumber.hashValue
            }
            hashCode = (hashCode &* 31) &+  unknownFields.hashValue
            return hashCode
        }
    }


    //Meta information declaration start

    override public class func className() -> String {
        return "ImProto.SysAck"
    }
    override public func className() -> String {
        return "ImProto.SysAck"
    }
    override public func classMetaType() -> GeneratedMessage.Type {
        return ImProto.SysAck.self
    }
    //Meta information declaration end

    final public class Builder : GeneratedMessageBuilder {
      private var builderResult:ImProto.SysAck = ImProto.SysAck()
      public func getMessage() -> ImProto.SysAck {
          return builderResult
      }

      required override public init () {
         super.init()
      }
      public var hasSerialNumber:Bool {
           get {
                return builderResult.hasSerialNumber
           }
      }
      public var serialNumber:UInt32 {
           get {
                return builderResult.serialNumber
           }
           set (value) {
               builderResult.hasSerialNumber = true
               builderResult.serialNumber = value
           }
      }
      public func setSerialNumber(value:UInt32) -> ImProto.SysAck.Builder {
        self.serialNumber = value
        return self
      }
      public func clearSerialNumber() -> ImProto.SysAck.Builder{
           builderResult.hasSerialNumber = false
           builderResult.serialNumber = UInt32(0)
           return self
      }
      override public var internalGetResult:GeneratedMessage {
           get {
              return builderResult
           }
      }
      public override func clear() -> ImProto.SysAck.Builder {
        builderResult = ImProto.SysAck()
        return self
      }
      public override func clone() throws -> ImProto.SysAck.Builder {
        return try ImProto.SysAck.builderWithPrototype(builderResult)
      }
      public override func build() throws -> ImProto.SysAck {
           try checkInitialized()
           return buildPartial()
      }
      public func buildPartial() -> ImProto.SysAck {
        let returnMe:ImProto.SysAck = builderResult
        return returnMe
      }
      public func mergeFrom(other:ImProto.SysAck) throws -> ImProto.SysAck.Builder {
        if other == ImProto.SysAck() {
         return self
        }
        if other.hasSerialNumber {
             serialNumber = other.serialNumber
        }
        try mergeUnknownFields(other.unknownFields)
        return self
      }
      public override func mergeFromCodedInputStream(input:CodedInputStream) throws -> ImProto.SysAck.Builder {
           return try mergeFromCodedInputStream(input, extensionRegistry:ExtensionRegistry())
      }
      public override func mergeFromCodedInputStream(input:CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysAck.Builder {
        let unknownFieldsBuilder:UnknownFieldSet.Builder = try UnknownFieldSet.builderWithUnknownFields(self.unknownFields)
        while (true) {
          let protobufTag = try input.readTag()
          switch protobufTag {
          case 0: 
            self.unknownFields = try unknownFieldsBuilder.build()
            return self

          case 8 :
            serialNumber = try input.readUInt32()

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

  // 长连接断掉消息
  final public class SysOffConnect : GeneratedMessage, GeneratedMessageProtocol {
    public private(set) var userId:String = ""

    public private(set) var hasUserId:Bool = false
    public private(set) var clientIp:String = ""

    public private(set) var hasClientIp:Bool = false
    public private(set) var createTime:UInt64 = UInt64(0)

    public private(set) var hasCreateTime:Bool = false
    required public init() {
         super.init()
    }
    override public func isInitialized() -> Bool {
      if !hasUserId {
        return false
      }
      if !hasClientIp {
        return false
      }
      if !hasCreateTime {
        return false
      }
     return true
    }
    override public func writeToCodedOutputStream(output:CodedOutputStream) throws {
      if hasUserId {
        try output.writeString(1, value:userId)
      }
      if hasClientIp {
        try output.writeString(2, value:clientIp)
      }
      if hasCreateTime {
        try output.writeUInt64(3, value:createTime)
      }
      try unknownFields.writeToCodedOutputStream(output)
    }
    override public func serializedSize() -> Int32 {
      var serialize_size:Int32 = memoizedSerializedSize
      if serialize_size != -1 {
       return serialize_size
      }

      serialize_size = 0
      if hasUserId {
        serialize_size += userId.computeStringSize(1)
      }
      if hasClientIp {
        serialize_size += clientIp.computeStringSize(2)
      }
      if hasCreateTime {
        serialize_size += createTime.computeUInt64Size(3)
      }
      serialize_size += unknownFields.serializedSize()
      memoizedSerializedSize = serialize_size
      return serialize_size
    }
    public class func parseArrayDelimitedFromInputStream(input:NSInputStream) throws -> Array<ImProto.SysOffConnect> {
      var mergedArray = Array<ImProto.SysOffConnect>()
      while let value = try parseFromDelimitedFromInputStream(input) {
        mergedArray += [value]
      }
      return mergedArray
    }
    public class func parseFromDelimitedFromInputStream(input:NSInputStream) throws -> ImProto.SysOffConnect? {
      return try ImProto.SysOffConnect.Builder().mergeDelimitedFromInputStream(input)?.build()
    }
    public class func parseFromData(data:NSData) throws -> ImProto.SysOffConnect {
      return try ImProto.SysOffConnect.Builder().mergeFromData(data, extensionRegistry:ImProto.SysRoot.sharedInstance.extensionRegistry).build()
    }
    public class func parseFromData(data:NSData, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysOffConnect {
      return try ImProto.SysOffConnect.Builder().mergeFromData(data, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFromInputStream(input:NSInputStream) throws -> ImProto.SysOffConnect {
      return try ImProto.SysOffConnect.Builder().mergeFromInputStream(input).build()
    }
    public class func parseFromInputStream(input:NSInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysOffConnect {
      return try ImProto.SysOffConnect.Builder().mergeFromInputStream(input, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFromCodedInputStream(input:CodedInputStream) throws -> ImProto.SysOffConnect {
      return try ImProto.SysOffConnect.Builder().mergeFromCodedInputStream(input).build()
    }
    public class func parseFromCodedInputStream(input:CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysOffConnect {
      return try ImProto.SysOffConnect.Builder().mergeFromCodedInputStream(input, extensionRegistry:extensionRegistry).build()
    }
    public class func getBuilder() -> ImProto.SysOffConnect.Builder {
      return ImProto.SysOffConnect.classBuilder() as! ImProto.SysOffConnect.Builder
    }
    public func getBuilder() -> ImProto.SysOffConnect.Builder {
      return classBuilder() as! ImProto.SysOffConnect.Builder
    }
    public override class func classBuilder() -> MessageBuilder {
      return ImProto.SysOffConnect.Builder()
    }
    public override func classBuilder() -> MessageBuilder {
      return ImProto.SysOffConnect.Builder()
    }
    public func toBuilder() throws -> ImProto.SysOffConnect.Builder {
      return try ImProto.SysOffConnect.builderWithPrototype(self)
    }
    public class func builderWithPrototype(prototype:ImProto.SysOffConnect) throws -> ImProto.SysOffConnect.Builder {
      return try ImProto.SysOffConnect.Builder().mergeFrom(prototype)
    }
    override public func getDescription(indent:String) throws -> String {
      var output:String = ""
      if hasUserId {
        output += "\(indent) userId: \(userId) \n"
      }
      if hasClientIp {
        output += "\(indent) clientIp: \(clientIp) \n"
      }
      if hasCreateTime {
        output += "\(indent) createTime: \(createTime) \n"
      }
      output += unknownFields.getDescription(indent)
      return output
    }
    override public var hashValue:Int {
        get {
            var hashCode:Int = 7
            if hasUserId {
               hashCode = (hashCode &* 31) &+ userId.hashValue
            }
            if hasClientIp {
               hashCode = (hashCode &* 31) &+ clientIp.hashValue
            }
            if hasCreateTime {
               hashCode = (hashCode &* 31) &+ createTime.hashValue
            }
            hashCode = (hashCode &* 31) &+  unknownFields.hashValue
            return hashCode
        }
    }


    //Meta information declaration start

    override public class func className() -> String {
        return "ImProto.SysOffConnect"
    }
    override public func className() -> String {
        return "ImProto.SysOffConnect"
    }
    override public func classMetaType() -> GeneratedMessage.Type {
        return ImProto.SysOffConnect.self
    }
    //Meta information declaration end

    final public class Builder : GeneratedMessageBuilder {
      private var builderResult:ImProto.SysOffConnect = ImProto.SysOffConnect()
      public func getMessage() -> ImProto.SysOffConnect {
          return builderResult
      }

      required override public init () {
         super.init()
      }
      public var hasUserId:Bool {
           get {
                return builderResult.hasUserId
           }
      }
      public var userId:String {
           get {
                return builderResult.userId
           }
           set (value) {
               builderResult.hasUserId = true
               builderResult.userId = value
           }
      }
      public func setUserId(value:String) -> ImProto.SysOffConnect.Builder {
        self.userId = value
        return self
      }
      public func clearUserId() -> ImProto.SysOffConnect.Builder{
           builderResult.hasUserId = false
           builderResult.userId = ""
           return self
      }
      public var hasClientIp:Bool {
           get {
                return builderResult.hasClientIp
           }
      }
      public var clientIp:String {
           get {
                return builderResult.clientIp
           }
           set (value) {
               builderResult.hasClientIp = true
               builderResult.clientIp = value
           }
      }
      public func setClientIp(value:String) -> ImProto.SysOffConnect.Builder {
        self.clientIp = value
        return self
      }
      public func clearClientIp() -> ImProto.SysOffConnect.Builder{
           builderResult.hasClientIp = false
           builderResult.clientIp = ""
           return self
      }
      public var hasCreateTime:Bool {
           get {
                return builderResult.hasCreateTime
           }
      }
      public var createTime:UInt64 {
           get {
                return builderResult.createTime
           }
           set (value) {
               builderResult.hasCreateTime = true
               builderResult.createTime = value
           }
      }
      public func setCreateTime(value:UInt64) -> ImProto.SysOffConnect.Builder {
        self.createTime = value
        return self
      }
      public func clearCreateTime() -> ImProto.SysOffConnect.Builder{
           builderResult.hasCreateTime = false
           builderResult.createTime = UInt64(0)
           return self
      }
      override public var internalGetResult:GeneratedMessage {
           get {
              return builderResult
           }
      }
      public override func clear() -> ImProto.SysOffConnect.Builder {
        builderResult = ImProto.SysOffConnect()
        return self
      }
      public override func clone() throws -> ImProto.SysOffConnect.Builder {
        return try ImProto.SysOffConnect.builderWithPrototype(builderResult)
      }
      public override func build() throws -> ImProto.SysOffConnect {
           try checkInitialized()
           return buildPartial()
      }
      public func buildPartial() -> ImProto.SysOffConnect {
        let returnMe:ImProto.SysOffConnect = builderResult
        return returnMe
      }
      public func mergeFrom(other:ImProto.SysOffConnect) throws -> ImProto.SysOffConnect.Builder {
        if other == ImProto.SysOffConnect() {
         return self
        }
        if other.hasUserId {
             userId = other.userId
        }
        if other.hasClientIp {
             clientIp = other.clientIp
        }
        if other.hasCreateTime {
             createTime = other.createTime
        }
        try mergeUnknownFields(other.unknownFields)
        return self
      }
      public override func mergeFromCodedInputStream(input:CodedInputStream) throws -> ImProto.SysOffConnect.Builder {
           return try mergeFromCodedInputStream(input, extensionRegistry:ExtensionRegistry())
      }
      public override func mergeFromCodedInputStream(input:CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysOffConnect.Builder {
        let unknownFieldsBuilder:UnknownFieldSet.Builder = try UnknownFieldSet.builderWithUnknownFields(self.unknownFields)
        while (true) {
          let protobufTag = try input.readTag()
          switch protobufTag {
          case 0: 
            self.unknownFields = try unknownFieldsBuilder.build()
            return self

          case 10 :
            userId = try input.readString()

          case 18 :
            clientIp = try input.readString()

          case 24 :
            createTime = try input.readUInt64()

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

  // 长连接断掉消息
  final public class SysNoRecordsPush : GeneratedMessage, GeneratedMessageProtocol {
    public private(set) var userId:String = ""

    public private(set) var hasUserId:Bool = false
    required public init() {
         super.init()
    }
    override public func isInitialized() -> Bool {
      if !hasUserId {
        return false
      }
     return true
    }
    override public func writeToCodedOutputStream(output:CodedOutputStream) throws {
      if hasUserId {
        try output.writeString(1, value:userId)
      }
      try unknownFields.writeToCodedOutputStream(output)
    }
    override public func serializedSize() -> Int32 {
      var serialize_size:Int32 = memoizedSerializedSize
      if serialize_size != -1 {
       return serialize_size
      }

      serialize_size = 0
      if hasUserId {
        serialize_size += userId.computeStringSize(1)
      }
      serialize_size += unknownFields.serializedSize()
      memoizedSerializedSize = serialize_size
      return serialize_size
    }
    public class func parseArrayDelimitedFromInputStream(input:NSInputStream) throws -> Array<ImProto.SysNoRecordsPush> {
      var mergedArray = Array<ImProto.SysNoRecordsPush>()
      while let value = try parseFromDelimitedFromInputStream(input) {
        mergedArray += [value]
      }
      return mergedArray
    }
    public class func parseFromDelimitedFromInputStream(input:NSInputStream) throws -> ImProto.SysNoRecordsPush? {
      return try ImProto.SysNoRecordsPush.Builder().mergeDelimitedFromInputStream(input)?.build()
    }
    public class func parseFromData(data:NSData) throws -> ImProto.SysNoRecordsPush {
      return try ImProto.SysNoRecordsPush.Builder().mergeFromData(data, extensionRegistry:ImProto.SysRoot.sharedInstance.extensionRegistry).build()
    }
    public class func parseFromData(data:NSData, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysNoRecordsPush {
      return try ImProto.SysNoRecordsPush.Builder().mergeFromData(data, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFromInputStream(input:NSInputStream) throws -> ImProto.SysNoRecordsPush {
      return try ImProto.SysNoRecordsPush.Builder().mergeFromInputStream(input).build()
    }
    public class func parseFromInputStream(input:NSInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysNoRecordsPush {
      return try ImProto.SysNoRecordsPush.Builder().mergeFromInputStream(input, extensionRegistry:extensionRegistry).build()
    }
    public class func parseFromCodedInputStream(input:CodedInputStream) throws -> ImProto.SysNoRecordsPush {
      return try ImProto.SysNoRecordsPush.Builder().mergeFromCodedInputStream(input).build()
    }
    public class func parseFromCodedInputStream(input:CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysNoRecordsPush {
      return try ImProto.SysNoRecordsPush.Builder().mergeFromCodedInputStream(input, extensionRegistry:extensionRegistry).build()
    }
    public class func getBuilder() -> ImProto.SysNoRecordsPush.Builder {
      return ImProto.SysNoRecordsPush.classBuilder() as! ImProto.SysNoRecordsPush.Builder
    }
    public func getBuilder() -> ImProto.SysNoRecordsPush.Builder {
      return classBuilder() as! ImProto.SysNoRecordsPush.Builder
    }
    public override class func classBuilder() -> MessageBuilder {
      return ImProto.SysNoRecordsPush.Builder()
    }
    public override func classBuilder() -> MessageBuilder {
      return ImProto.SysNoRecordsPush.Builder()
    }
    public func toBuilder() throws -> ImProto.SysNoRecordsPush.Builder {
      return try ImProto.SysNoRecordsPush.builderWithPrototype(self)
    }
    public class func builderWithPrototype(prototype:ImProto.SysNoRecordsPush) throws -> ImProto.SysNoRecordsPush.Builder {
      return try ImProto.SysNoRecordsPush.Builder().mergeFrom(prototype)
    }
    override public func getDescription(indent:String) throws -> String {
      var output:String = ""
      if hasUserId {
        output += "\(indent) userId: \(userId) \n"
      }
      output += unknownFields.getDescription(indent)
      return output
    }
    override public var hashValue:Int {
        get {
            var hashCode:Int = 7
            if hasUserId {
               hashCode = (hashCode &* 31) &+ userId.hashValue
            }
            hashCode = (hashCode &* 31) &+  unknownFields.hashValue
            return hashCode
        }
    }


    //Meta information declaration start

    override public class func className() -> String {
        return "ImProto.SysNoRecordsPush"
    }
    override public func className() -> String {
        return "ImProto.SysNoRecordsPush"
    }
    override public func classMetaType() -> GeneratedMessage.Type {
        return ImProto.SysNoRecordsPush.self
    }
    //Meta information declaration end

    final public class Builder : GeneratedMessageBuilder {
      private var builderResult:ImProto.SysNoRecordsPush = ImProto.SysNoRecordsPush()
      public func getMessage() -> ImProto.SysNoRecordsPush {
          return builderResult
      }

      required override public init () {
         super.init()
      }
      public var hasUserId:Bool {
           get {
                return builderResult.hasUserId
           }
      }
      public var userId:String {
           get {
                return builderResult.userId
           }
           set (value) {
               builderResult.hasUserId = true
               builderResult.userId = value
           }
      }
      public func setUserId(value:String) -> ImProto.SysNoRecordsPush.Builder {
        self.userId = value
        return self
      }
      public func clearUserId() -> ImProto.SysNoRecordsPush.Builder{
           builderResult.hasUserId = false
           builderResult.userId = ""
           return self
      }
      override public var internalGetResult:GeneratedMessage {
           get {
              return builderResult
           }
      }
      public override func clear() -> ImProto.SysNoRecordsPush.Builder {
        builderResult = ImProto.SysNoRecordsPush()
        return self
      }
      public override func clone() throws -> ImProto.SysNoRecordsPush.Builder {
        return try ImProto.SysNoRecordsPush.builderWithPrototype(builderResult)
      }
      public override func build() throws -> ImProto.SysNoRecordsPush {
           try checkInitialized()
           return buildPartial()
      }
      public func buildPartial() -> ImProto.SysNoRecordsPush {
        let returnMe:ImProto.SysNoRecordsPush = builderResult
        return returnMe
      }
      public func mergeFrom(other:ImProto.SysNoRecordsPush) throws -> ImProto.SysNoRecordsPush.Builder {
        if other == ImProto.SysNoRecordsPush() {
         return self
        }
        if other.hasUserId {
             userId = other.userId
        }
        try mergeUnknownFields(other.unknownFields)
        return self
      }
      public override func mergeFromCodedInputStream(input:CodedInputStream) throws -> ImProto.SysNoRecordsPush.Builder {
           return try mergeFromCodedInputStream(input, extensionRegistry:ExtensionRegistry())
      }
      public override func mergeFromCodedInputStream(input:CodedInputStream, extensionRegistry:ExtensionRegistry) throws -> ImProto.SysNoRecordsPush.Builder {
        let unknownFieldsBuilder:UnknownFieldSet.Builder = try UnknownFieldSet.builderWithUnknownFields(self.unknownFields)
        while (true) {
          let protobufTag = try input.readTag()
          switch protobufTag {
          case 0: 
            self.unknownFields = try unknownFieldsBuilder.build()
            return self

          case 10 :
            userId = try input.readString()

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
