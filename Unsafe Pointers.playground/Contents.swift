//: Playground - noun: a place where people can play

import UIKit

MemoryLayout<Int>.size         // returns 8
MemoryLayout<Int>.alignment    // returns 8
MemoryLayout<Int>.stride       // returns 8

// Int16 ima velicinu od dva bajta, a posto je alignment dva mora poceti od adrese sa parnim brojem
// tako da ga mogu alocirati na adresi 100, a ne mogu na adresi 101 jer to krsi alignment
MemoryLayout<Int16>.size        // returns 2
MemoryLayout<Int16>.alignment   // returns 2
MemoryLayout<Int16>.stride      // returns 2

MemoryLayout<Bool>.size         // returns 1
MemoryLayout<Bool>.alignment    // returns 1
MemoryLayout<Bool>.stride       // returns 1

MemoryLayout<Float>.size        // returns 4
MemoryLayout<Float>.alignment   // returns 4
MemoryLayout<Float>.stride      // returns 4

MemoryLayout<Double>.size       // returns 8
MemoryLayout<Double>.alignment  // returns 8
MemoryLayout<Double>.stride     // returns 8



struct EmptyStruct {}

MemoryLayout<EmptyStruct>.size      // returns 0
MemoryLayout<EmptyStruct>.alignment // returns 1
MemoryLayout<EmptyStruct>.stride    // returns 1 // ovu vrednost ima iako je prazna struktura, zato sto svaku EmptyStruct koji napravim mora imati jedinstvenu adresu

struct SampleStruct {
    let number: UInt32
    let flag: Bool
}

MemoryLayout<SampleStruct>.size       // returns 5 --> velicina ukupne memorije
MemoryLayout<SampleStruct>.alignment  // returns 4 --> poravnanje prema velicini najveceg elementa, najveci zajednicki sadrzalac
MemoryLayout<SampleStruct>.stride     // returns 8 --> korak (koraci) memorije koji mora da se izdvoji prema najvecem alignment-u pomnozenom sa brojem elemenats

// Stride je prosiriv kod onih koji nisu buffer, tj nisu kolekcije

class EmptyClass {}

MemoryLayout<EmptyClass>.size      // returns 8 (on 64-bit)
MemoryLayout<EmptyClass>.stride    // returns 8 (on 64-bit)
MemoryLayout<EmptyClass>.alignment // returns 8 (on 64-bit)

class SampleClass {
    let number: Int64 = 0
    let flag: Bool = false
}
// Posto su klase referentni tipovi, ovde velicina nije jednaka sadrzaju klase, vec samoj referenci koja iznosi 8
MemoryLayout<SampleClass>.size      // returns 8 (on 64-bit)
MemoryLayout<SampleClass>.stride    // returns 8 (on 64-bit)
MemoryLayout<SampleClass>.alignment // returns 8 (on 64-bit)



let count = 2
let stride = MemoryLayout<Int>.stride             // returns 8
let alignment = MemoryLayout<Int>.alignment       // returns 8
let byteCount = stride * count      // 16

do {
    // RAW POINTER
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
    defer {
        pointer.deallocate()  // deallocate(bytes: byteCount, alignedTo: alignment) mora da se dealocira jer ovde zbog eskiviranja kompajlera ARC nece raditi
    }
    
    pointer.storeBytes(of: 42, as: Int.self)
    pointer.advanced(by: stride).storeBytes(of: 6, as: Int.self)
    //    ovaj pointer je strideable-ilan u ovo se moglo drugacije napisti
    //    (pointer + stride).storeBytes(of: 6, as: Int.self)
    pointer.load(as: Int.self)
    pointer.advanced(by: stride).load(as: Int.self)
    
    let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
    for (index, byte) in bufferPointer.enumerated() {
        print("byte \(index): \(byte)")
    }
}


do {
    // TYPED POINTER
    let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
    pointer.initialize(repeating: 0, count: count)
    defer {
        pointer.deinitialize(count: count)
        pointer.deallocate()
    }
    
    pointer.pointee = 42
    pointer.advanced(by: 1).pointee = 6 // moze i ovako ---> (pointer+1).pointee = 6 // pointee sluzi za type-safe nacin load-ovanja i store-ovanja vrednosti
    pointer.pointee
    pointer.advanced(by: 1).pointee
    
    let bufferPointter = UnsafeBufferPointer(start: pointer, count: count)
    for (index, value) in bufferPointter.enumerated() {
        print("value \(index): \(value)") // ovaj vrsi iteraciju po vrednostima umesto po bajtovima
    }
}


do {
    // CONVERTING RAW POINTER TO TYPED POINTER
    
    let RAW_POINTER = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
    defer {
        RAW_POINTER.deallocate()  //deallocate(bytes: byteCount, alignedTo: alignment)
    }
    
    let typedPointer = RAW_POINTER.bindMemory(to: Int.self, capacity: count)
    typedPointer.initialize(repeating: 0, count: count)
    defer {
        typedPointer.deinitialize(count: count)
    }
    
    typedPointer.pointee = 42
    typedPointer.advanced(by: 1).pointee = 6
    typedPointer.pointee
    typedPointer.advanced(by: 1).pointee
    
    let bufferPointer = UnsafeBufferPointer(start: typedPointer, count: count)
    for (index, value) in bufferPointer.enumerated() {
        print("value \(index): \(value)")
    }
}


do {
    // Getting the bytes of an instance
    
    var sampleStruct = SampleStruct(number: 25, flag: true)
    
    // ovo printa raw bajtove instance SampleStruct-a
    // pomocu - withUnsafeBytes(of:) - pristupa se UnsafeRawBufferPointer
    withUnsafeBytes(of: &sampleStruct) { bytes in
        for byte in bytes {
            print(byte)
        }
    }
}


do {
    // Checksum the bytes of a struct
    
    var sampleStruct = SampleStruct(number: 25, flag: true)
    
    let checksum = withUnsafeBytes(of: &sampleStruct) { (bytes) -> UInt32 in
        return ~bytes.reduce(UInt32(0)) { $0 + numericCast($1) }
    }
    
    print("checksum", checksum) // prints checksum 4294967269
}



// PRAVILA UNSAFE POINTERA
do {
    // 1. Nemoj vracati pointer iz withUnsafeBytes
    
    var sampleStruct = SampleStruct(number: 25, flag: true)
    
    let bytes = withUnsafeBytes(of: &sampleStruct) { bytes in
        return bytes // neobjasnjivi bug-ovi se desavaju zbog ovog vracanja
    }
    
    print("Horse is out of the barn!", bytes)  /// nedefinisano !!!
}
do {
    // 2. Radi sa jednim tipom podataka po pointeru
    
    let count = 3
    let stride = MemoryLayout<Int16>.stride
    let alignment = MemoryLayout<Int16>.alignment
    let byteCount =  count * stride
    
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
    
    let typedPointer1 = pointer.bindMemory(to: UInt16.self, capacity: count)
    
    // Pointeru si ovde promenio tip umesto Int16 postao je Bool  (Undefined behavior)
    _ = pointer.bindMemory(to: Bool.self, capacity: count * 2)
    
    // Ako bas mora da se to uradi, onda ovako:
    typedPointer1.withMemoryRebound(to: Bool.self, capacity: count * 2) {
        (boolPointer: UnsafeMutablePointer<Bool>) in
        print(boolPointer.pointee)  // See Rule #1, don't return the pointer
    }
}
do {
    // 3. Ne menjaj naglo velicinu bajtova
    
    let count = 3
    let stride = MemoryLayout<Int16>.stride
    let alignment = MemoryLayout<Int16>.alignment
    let byteCount =  count * stride
    
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
    let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount + 1) // EVO OVDE JE PROMENJENO ???????
    
    for byte in bufferPointer {
        print(byte)  // pawing through memory like an animal
    }
}

// PRIMER KOMPRESIJE I DEKOMPRESIJE

import Compression

enum CompressionAlgorithm {
    case lz4   // speed is critical
    case lz4a  // space is critical
    case zlib  // reasonable speed and space
    case lzfse // better speed and space
}

enum CompressionOperation {
    case compression, decompression
}

// return compressed or uncompressed data depending on the operation
func perform(_ operation: CompressionOperation,
             on input: Data,
             using algorithm: CompressionAlgorithm,
             workingBufferSize: Int = 2000) -> Data?  {
    
    // set the algorithm
    let streamAlgorithm: compression_algorithm
    switch algorithm {
    case .lz4:   streamAlgorithm = COMPRESSION_LZ4
    case .lz4a:  streamAlgorithm = COMPRESSION_LZMA
    case .zlib:  streamAlgorithm = COMPRESSION_ZLIB
    case .lzfse: streamAlgorithm = COMPRESSION_LZFSE
    }
    
    // set the stream operation and flags
    let streamOperation: compression_stream_operation
    let flags: Int32
    switch operation {
    case .compression:
        streamOperation = COMPRESSION_STREAM_ENCODE
        flags = Int32(COMPRESSION_STREAM_FINALIZE.rawValue)
    case .decompression:
        streamOperation = COMPRESSION_STREAM_DECODE
        flags = 0
    }
    // dovde je zavrseno pretvaranje SWIFT tipova u C tipove
    
    
    // 1: create a stream
    var streamPointer = UnsafeMutablePointer<compression_stream>.allocate(capacity: 1)
    defer {
        streamPointer.deallocate(capacity: 1)
    }
    
    // 2: initialize the stream
    var stream = streamPointer.pointee
    var status = compression_stream_init(&stream, streamOperation, streamAlgorithm)
    guard status != COMPRESSION_STATUS_ERROR else {
        return nil
    }
    defer {
        compression_stream_destroy(&stream)
    }
    
    // 3: set up a destination buffer
    let dstSize = workingBufferSize
    let dstPointer = UnsafeMutablePointer<UInt8>.allocate(capacity: dstSize)
    defer {
        dstPointer.deallocate(capacity: dstSize)
    }
    
    
    // process the input
    return input.withUnsafeBytes { (srcPointer: UnsafePointer<UInt8>) in
        // 1 Create a Data object which is going to contain the output – either the compressed or decompressed data, depending on what operation this is.
        var output = Data()
        
        // 2 Set up the source and destination buffers with the pointers you allocated and their sizes.
        stream.src_ptr = srcPointer
        stream.src_size = input.count
        stream.dst_ptr = dstPointer
        stream.dst_size = dstSize
        
        // 3 Then you keep calling compression_stream_process as long as it continues to return COMPRESSION_STATUS_OK.
        while status == COMPRESSION_STATUS_OK {
            // process the stream
            status = compression_stream_process(&stream, flags)
            
            // collect bytes from the stream and reset
            switch status {
                
            case COMPRESSION_STATUS_OK:
                // 4 The destination buffer is then copied into output that is eventually returned from this function.
                output.append(dstPointer, count: dstSize)
                stream.dst_ptr = dstPointer
                stream.dst_size = dstSize
                
            case COMPRESSION_STATUS_ERROR:
                return nil
                
            case COMPRESSION_STATUS_END:
                // 5
                output.append(dstPointer, count: stream.dst_ptr - dstPointer)
                
            default:
                fatalError()
            }
        }
        return output
    }
}

struct Compressed {
    
    let data: Data
    let algorithm: CompressionAlgorithm
    
    init(data: Data, algorithm: CompressionAlgorithm) {
        self.data = data
        self.algorithm = algorithm
    }
    
    // Compress the input with the specified algorithm. Returns nil if it fails.
    static func compress(input: Data,
                         with algorithm: CompressionAlgorithm) -> Compressed? {
        guard let data = perform(.compression, on: input, using: algorithm) else {
            return nil
        }
        return Compressed(data: data, algorithm: algorithm)
    }
    
    // Uncompressed data. Returns nil if the data cannot be decompressed.
    func decompressed() -> Data? {
        return perform(.decompression, on: data, using: algorithm)
    }
    
}


// PRIMER RANDOM GENERATORA
enum RandomSource {
    
    static let file = fopen("/dev/urandom", "r")!       // Declared static so only one will exist in the system
    static let queue = DispatchQueue(label: "random")   // Since it is possible that multiple threads will want random numbers, you need to protect access to it with a serial GCD queue
    
    static func get(count: Int) -> [Int8] {
        let capacity = count + 1                         // create some unallocated storage that is one beyond what you need because fgets is always 0 terminated
        var data = UnsafeMutablePointer<Int8>.allocate(capacity: capacity)
        defer {
            data.deallocate(capacity: capacity)
        }
        queue.sync {
            fgets(data, Int32(capacity), file)          // you get the data from the file, making sure to do so while operating on the GCD queue
        }
        return Array(UnsafeMutableBufferPointer(start: data, count: count))
    }
}

extension BinaryInteger {
    
    static var randomized: Self {
        let numbers = RandomSource.get(count: MemoryLayout<Self>.size)
        return numbers.withUnsafeBufferPointer { bufferPointer in
            return bufferPointer.baseAddress!.withMemoryRebound(to: Self.self, capacity: 1) {
                return $0.pointee
            }
        }
    }
    
}

Int8.randomized
UInt8.randomized
Int16.randomized
UInt16.randomized
Int16.randomized
UInt32.randomized
Int64.randomized
UInt64.randomized

