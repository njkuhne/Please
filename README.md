
[![Version](https://img.shields.io/cocoapods/v/Please.svg?style=flat)](http://cocoapods.org/pods/Please)
[![License](https://img.shields.io/cocoapods/l/Please.svg?style=flat)](http://cocoapods.org/pods/Please)
[![Platform](https://img.shields.io/cocoapods/p/Please.svg?style=flat)](http://cocoapods.org/pods/Please)

# Please
#### Be Polite, be efficient. 

`Please` is a library written in `Swift` with the singular purpose of making loading images from the network simple and less painful to developers at every experience level. 

## Please, let me tell you about a problem I have
Having worked in web and in iOS, I have envied web developers for the maturity and simplicity of the tools and conventions they get to use. Some tasks can be handled so easily that the complexity held within them is often forgotten about. 
While writing `Please`, I intended to see a simple task simply, and let the developer spend more time caring about higher value logic.

### A Simple Example

Our story begins in Browser-ville, 

```HTML
<img src="awesome_icon.png">
```

**Ohh, That looks simple, I should use that!**

Let's break down what the developer is asking to have done here:

1. Make space in the UI to display an image
2. Here is a URL where you can find that image
3. Go ahead and fetch that image from the network (and deal with any error you encounter)
4. Parse the response to verify that it is in fact an image
5. Display that image in the UI, verifying, of course, that I haven't changed the `src` in the mean time
6. Oh and if you don't mind, cache that locally for me to speed up future requests, cause I might use this image again...

**Thank you very much web browser... How about the native iOS world**

How an iOS dev thinks about this problem. 

1. I need a UIImageView, I can set that up in my nib or storyboard.
2. Maybe I can use `Alamofire` for this! They have something for image loading right?
3. Oh wait, what about cell recycling, if the cell data changes before the image is loaded, I guess I cancel the request, and spin off a new one? 
4. Okay, so what if the request fails? Do I use a placeholder image or something? Do I try again if the error was lack of network? So I have to parse any error to figure this out and decide what to do. 
5. I can check to see if the image data can be used to make a UIImage, that can help me sanity check the raw data.
6. Caching? nah, it will be fine, most of my assets are in an assets catalog anyways, so it's not a big deal. 

As you can see, there is complex behaviour behind this simple HTML element, with one simple statement the developer can invoke complex UI and networking, and he can do so while being expressive and specific about what they want the browser to do.

### Please, rescue me!

So here's what I want to have happen.

`imageView.url = URL(string: "http://mysite.io/awesome_icon.png")`

Or more likely:

`imageView.url = itemModel.url`

I'll let the system do the work, and solve this common problem just like a browser would.

This is where `Please` comes in.

## Again, Please?
Stated simply, 
> Please provides a simple, expressive way to load images into a UIImageView from a network source 

### Usage

Please gives every `UIImageView` in your project an additional property:

`var url : URL? {get set}`

With this you can assign a `URL` to the `UIImageView`, Please will load this image from the `URL` and assign it to the `image` property on that `UIImageView` 

#### Works like I want it to
Please is designed to work similarly to the way an HTML img tag would. This means it follows the following patterns:
1. Please will respect reassignment of the `url` property, only displaying a `UIImage` for the url presently assigned to the `UIImageView`
2. Please won't do fancy animations, display the `UIImage` ASAP that's it 
3. Please will cache that image in the local file storage to be used later
4. Please is just simple, no crazy params, no confusion.

### Advanced Usage

#### Strings
> Please, times are tough, I just want to throw a string in there. 

Look no further friend, Please use: 

`var urlString: String?` 

Just as your would the standard `URL` property

#### Speed
> Please, load quicker, I need my images NOW!

Me too! Please includes a simple method for requesting images when you first know about them. 

`Please.cache(url: myImageURL)`

Put this in your API response handlers, for quick Image caching then simply perform the regular steps

`imageView.url = myImageURL`

#### Fancy ImageViews
> Please, extend this to work with other types of image displaying things

Sure thing, did that already! 
Don't like UIImageView? Please use:

`Please.cache(url: myImageURL)`

and 

```swift
Please.retrieve(url: myImageURL) { (image) in
	// do somethign with the image
	}
```
	

## Example Project

To run the example project, Please clone the repo, and run  `pod install`  from the Example directory first.

## Installation

Please is available through [CocoaPods](http://cocoapods.org). To install
it, Please add the following line to your Podfile:

```ruby
pod "Please"
```

## Author

Nicholas Kuhne, njkuhne@me.com

## License

Please is available under the MIT license. See the LICENSE file for more info.
