CPDictionaryProxy
===============

With this component you can _access any NSDictionary via properties_.

Something like this:

	NSString* value = dictProxy.key;
	dictProxy.key = @"value";

Instead of:

	NSString* value = [dict objectForKey:@"key"];
	[dict setObject:@"value" forKey:@"key"];

And there are some nice side effects too:

* Automatic value object cast as defined in your category, a cast is no longer needed.
* Xcode autocompletion for the dictionary keys.
* Every typo error when accessing a key will automatically result in a compiler error. You can’t read/write wrong keys any more.

I described the technology behind on the [compeople developer blog on Mobile Apps](http://blog.compeople.eu/apps/?p=452).

Feel free to comment, fork, and submit pull requests!

Requirements
------------
* Made for projects under [ARC](http://developer.apple.com/library/ios/#releasenotes/ObjectiveC/RN-TransitioningToARC/_index.html); you will therefore need to use SDK 5.0+.
* Deployment target iPad iOS 5.1+ (component should also work at iPhone and with iOS 5.0).

License
-------
The CPDictionaryProxy component is released under the MIT License.

The MIT License (MIT)
Copyright (c) 2012 compeople AG

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.