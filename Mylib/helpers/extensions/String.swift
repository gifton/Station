
import UIKit


extension String {
    
    // find string within string
    func contains(_ string: String) -> Bool {
        if (self.range(of: string) != nil) {
            return true
        } else {
            return false
        }
    }
    
    // find string but with compare options
    func contains(_ string: String, withCompareOptions compareOptions: NSString.CompareOptions) -> Bool {
        if ((self.range(of:string, options: compareOptions)) != nil) {
            return true
        } else {
            return false
        }
    }
    
    // return greeting depending on time of day, [
    // good evening, good afternoon, good morning]
    static func timeSensativeGreeting() -> String {
        let date = NSDate()
        let calendar = NSCalendar.current
        let currentHour = calendar.component(.hour, from: date as Date)
        let hourInt = Int(currentHour.description)!
        var greeting = ""

        if hourInt >= 12 && hourInt <= 16 {
            greeting = "Good Afternoon"
        }
        else if hourInt >= 7 && hourInt <= 12 {
            greeting = "Good Morning"
        }
        else if hourInt >= 18 && hourInt <= 24 {
            greeting = "Good Evening"
        }
        
        return greeting
    }
    
    
    // convert ssstring into date format
    // api returns string in SWAPI conformance, call the DateFormatter helper method for conversion
    // return todays date if all falls through
    func toDate() -> Date {
        let df = DateFormatter()
        return df.date(rawString: self) ?? Date()
    }
}
