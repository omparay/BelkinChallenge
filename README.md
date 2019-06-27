Belkin Challenge

This was mostly done in Objective-C as I did have some issues early on in integrating some Swift code in my current Library. But what I did was basically convert the basics of what I was doing in my HTTP client in Swift over to ObjC.

Some things I could not convert over easily. Had some issues with the conversion of Blocks but then I decided to use the Delegation pattern to overcome this.

Because ObjC is not as type-safe and nullable-safe as Swift some things I would probably add over time will include more nil checks and more tests against expected class types. However the overall operations and logic would probably be kept the same.
