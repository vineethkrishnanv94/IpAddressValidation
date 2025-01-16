import UIKit


func validateIpAddress(_ ipAddress: String) -> String{

    if ipAddress.contains(".") {
        return validateIpv4(ipAddress: ipAddress) ?  "ipv4": "Neither"
    }
    else if ipAddress.contains(":") {
        return  validateIpv6(ipAddress: ipAddress) ?  "ipv6": "Neither"
    }
    else {
        return "Neither"
    }
}

func validateIpv4(ipAddress: String) -> Bool{
    
    var parts = 0
    var current = ""
    
    for char in ipAddress {
        if char == "." {
            if !validateIpv4Part(content: current) {
                return false
            }
            parts += 1
            current = ""
        } else {
            current.append(char)
        }
    }
    
    // Check the last part
    if !validateIpv4Part(content: current) { return false }
     parts += 1
    
    return parts == 4
}

func validateIpv4Part(content: String) -> Bool {
    
    guard let ipNum = Int(content), ipNum > 0, ipNum < 255 else {
        return false
    }
    
    return String(ipNum) == content
}

func validateIpv6(ipAddress: String) -> Bool {
    var parts = 0
    var current = ""
    
    for char in ipAddress {
        if char == ":" {
            if !validateIpv6Part(content: current) {
                return false
            }
            parts += 1
            current = ""
        } else if char.isHexDigit {
            current.append(char)
        } else {
            return false
        }
    }
    
    if !validateIpv6Part(content: current) { return false }
      parts += 1
    
    return parts == 8
}

func validateIpv6Part(content: String) -> Bool {
    guard !content.isEmpty, content.count <= 4 else { return false }
        for char in content {
            if !char.isHexDigit { return false }
        }
        return true
}


print(validateIpAddress("192.168.1.1")) // Output: IPv4
print(validateIpAddress("2001:0db8:85a3:0000:0000:8a2e:0370:7334")) // Output: IPv6
print(validateIpAddress("256.256.256.256")) // Output: Neither
print(validateIpAddress("1e1.4.5.6")) // Output: Neither


